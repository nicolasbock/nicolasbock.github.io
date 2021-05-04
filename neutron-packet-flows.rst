---
title: Neutron Packet Flows
---

# Introduction

Bionic / Stein
l3ha
ovs

## Setup

1. Create network and subnet
2. Create router on subnet
3. Create server on subnet
4. Create security group allowing ingress ICMP and add to server

## Follow DHCP request from server at boot

Get the location of the DHCP server for the `private` network:

```
openstack network agent list --network private
+--------------------------------------+------------+-------------------------------------+-------------------+-------+-------+--------------------+
| ID                                   | Agent Type | Host                                | Availability Zone | Alive | State | Binary             |
+--------------------------------------+------------+-------------------------------------+-------------------+-------+-------+--------------------+
| c2b15417-dcb2-48ee-8e54-42f4eadec901 | DHCP agent | juju-94df60-telefonica-16.cloud.sts | nova              | :-)   | UP    | neutron-dhcp-agent |
+--------------------------------------+------------+-------------------------------------+-------------------+-------+-------+--------------------+
```

Find the network namespace of the DHCP server:

```
ubuntu@juju-94df60-telefonica-16:~$ ip netns
qdhcp-a8d9b6d0-3a76-4d4e-b48f-0a9286d4f8d2 (id: 0)
```

Note that 
