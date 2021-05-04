======================
 Neutron Packet Flows
======================

Introduction
============

Bionic / Stein
l3ha
ovs

Setup
=====

1. Create network and subnet
2. Create router on subnet
3. Create server on subnet
4. Create security group allowing ingress ICMP and add to server

Follow DHCP request from server at boot
=======================================

Get the location of the DHCP server for the `private` network:

.. code-block::

   openstack network agent list --network private
   +--------------------------------------+------------+--------------------------------+-------------------+-------+-------+--------------------+
   | ID                                   | Agent Type | Host                           | Availability Zone | Alive | State | Binary             |
   +--------------------------------------+------------+--------------------------------+-------------------+-------+-------+--------------------+
   | c2b15417-dcb2-48ee-8e54-42f4eadec901 | DHCP agent | juju-94df60-flows-16.cloud.sts | nova              | :-)   | UP    | neutron-dhcp-agent |
   +--------------------------------------+------------+--------------------------------+-------------------+-------+-------+--------------------+

Find the network namespace of the DHCP server:

.. code-block::

   ubuntu@juju-94df60-flows-16:~$ ip netns
   qdhcp-a8d9b6d0-3a76-4d4e-b48f-0a9286d4f8d2 (id: 0)

.. note::

   Note that the interface is always named ``qdhcp-NETWORK_ID``.

.. code-block::

   ubuntu@juju-94df60-flows-16:~$ sudo ip netns exec qdhcp-a8d9b6d0-3a76-4d4e-b48f-0a9286d4f8d2 ip addr
   1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
       link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
       inet 127.0.0.1/8 scope host lo
          valid_lft forever preferred_lft forever
       inet6 ::1/128 scope host
          valid_lft forever preferred_lft forever
   12: tap00e43d21-e4: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
       link/ether fa:16:3e:24:df:fc brd ff:ff:ff:ff:ff:ff
       inet 192.168.21.2/24 brd 192.168.21.255 scope global tap00e43d21-e4
          valid_lft forever preferred_lft forever
       inet 169.254.169.254/16 brd 169.254.255.255 scope global tap00e43d21-e4
          valid_lft forever preferred_lft forever
       inet6 fe80::f816:3eff:fe24:dffc/64 scope link

Run ``tcpdump`` on the interface to get DHCP traffic:

.. code-block::

   tcpdump -n -l -e -v -i tap00e43d21-e4 port 67 or port 68
