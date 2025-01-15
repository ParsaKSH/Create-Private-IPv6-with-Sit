#!/bin/bash
    
sudo ip link set tunel01 up
sudo ip -6 route replace 2619:db8:85a3:1b2e::1/128 dev tunel01
sudo ip link set tunel03 up
sudo ip -6 route replace 2619:db8:85a3:1b2e::3/128 dev tunel03
sudo ip link set tunel05 up
sudo ip -6 route replace 2619:db8:85a3:1b2e::5/128 dev tunel05
sudo ip link set tunel07 up
sudo ip -6 route replace 2619:db8:85a3:1b2e::7/128 dev tunel07
sudo ip link set tunel09 up
sudo ip -6 route replace 2619:db8:85a3:1b2e::9/128 dev tunel09
sudo ip link set tunel011 up
sudo ip -6 route replace 2619:db8:85a3:1b2e::11/128 dev tunel011
sudo ip link set tunel013 up
sudo ip -6 route replace 2619:db8:85a3:1b2e::13/128 dev tunel013
sudo ip link set tunel015 up
sudo ip -6 route replace 2619:db8:85a3:1b2e::15/128 dev tunel015
sudo ip link set tunel017 up
sudo ip -6 route replace 2619:db8:85a3:1b2e::17/128 dev tunel017
sudo ip link set tunel019 up
sudo ip -6 route replace 2619:db8:85a3:1b2e::19/128 dev tunel019
sudo ip link set tunel021 up
sudo ip -6 route replace 2619:db8:85a3:1b2e::21/128 dev tunel021
