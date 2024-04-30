============================
 Octavia Management Network
============================

Setup
=====

#. Bionic / Ussuri
#. Neutron
   * ovs
   * l3ha
   * l2-population
   * dvr

Introduction
============

Octavia uses a special Neutron network called ``lb-mgmt-net`` for
communication between the ``octavia-worker`` and the
``amphora-agent``. Since the ``octavia-worker`` process is outside of
Nova / Neutron the machine that is running
