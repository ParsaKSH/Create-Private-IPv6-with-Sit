#!/bin/bash

echo "=========================================="
echo "Created by Parsa in OPIran club"
echo "Love Iran :)"
echo "=========================================="

read -p "Please enter the IPv4 address of the Iran server: " iran_ip
read -p "Please enter the IPv4 address of the foreign server: " foreign_ip
read -p "Are you running this script on the Iran server? (yes/no): " server_location

echo "Updating and installing required packages..."
sudo apt update
sudo apt-get install iproute2 -y
sudo apt install netplan.io -y

if [ "$server_location" == "yes" ]; then
    echo "Configuring for the Iran server..."
    sudo bash -c "cat > /etc/netplan/pdtun.yaml <<EOF
network:
  version: 2
  tunnels:
    tunel01:
      mode: sit
      local: $iran_ip
      remote: $foreign_ip
      addresses:
        - 2619:db8:69a3:1b2e::2/64
      mtu: 1500
EOF"

    sudo netplan apply

    sudo bash -c "cat > /etc/systemd/network/tun0.network <<EOF
[Network]
Address=2619:db8:69a3:1b2e::2/64
Gateway=2619:db8:69a3:1b2e::1
EOF"

    echo "This is your Private-IPv6 for your Iran server: 2619:db8:69a3:1b2e::2/64"

else
    echo "Configuring for the foreign server..."
    sudo bash -c "cat > /etc/netplan/pdtun.yaml <<EOF
network:
  version: 2
  tunnels:
    tunel01:
      mode: sit
      local: $foreign_ip
      remote: $iran_ip
      addresses:
        - 2619:db8:69a3:1b2e::1/64
      mtu: 1500
EOF"

    sudo netplan apply

    sudo bash -c "cat > /etc/systemd/network/tun0.network <<EOF
[Network]
Address=2619:db8:69a3:1b2e::1/64
Gateway=2619:db8:69a3:1b2e::2
EOF"

    echo "This is your Private-IPv6 for your foreign server: 2619:db8:69a3:1b2e::1/64"
fi

sudo systemctl restart systemd-networkd

read -p "Operation completed successfully. Please reboot the system. Would you like to reboot the system? (yes/no): " reboot_choice
if [ "$reboot_choice" == "yes" ]; then
    echo "Rebooting the system..."
    sudo reboot
else
    echo "Operation completed successfully. Reboot required."
fi
