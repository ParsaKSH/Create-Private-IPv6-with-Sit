#!/bin/bash

# ==========================================
# Created by Parsa in OPIran club
# Love Iran :)
# ==========================================

# Get the IP addresses of Iran and foreign servers from the user
read -p "Please enter the IPv4 address of the Iran server: " iran_ip
read -p "Please enter the IPv4 address of the foreign server: " foreign_ip

# Ask the user whether the script is being run on an Iran server
read -p "Are you running this script on the Iran server? (yes/no): " server_location

# Update and install necessary packages
echo "Updating and installing required packages..."
sudo apt update
sudo apt-get install iproute2 -y
sudo apt install nano -y
sudo apt install netplan.io -y

# Configure based on server location
if [ "$server_location" == "yes" ]; then
    echo "Configuring for the Iran server..."
    
    # Edit pdtun.yaml
    sudo bash -c "cat > /etc/netplan/pdtun.yaml <<EOF
network:
  version: 2
  tunnels:
    tunel01:
      mode: sit
      local: $iran_ip
      remote: $foreign_ip
      addresses:
        - 2619:db8:85a3:1b2e::2/64
      mtu: 1500
EOF"

    sudo netplan apply

    # Edit tun0.network
    sudo bash -c "cat > /etc/systemd/network/tun0.network <<EOF
[Network]
Address=2619:db8:85a3:1b2e::2/64
Gateway=2619:db8:85a3:1b2e::1
EOF"

else
    echo "Configuring for the foreign server..."
    
    # Edit pdtun.yaml
    sudo bash -c "cat > /etc/netplan/pdtun.yaml <<EOF
network:
  version: 2
  tunnels:
    tunel01:
      mode: sit
      local: $foreign_ip
      remote: $iran_ip
      addresses:
        - 2619:db8:85a3:1b2e::1/64
      mtu: 1500
EOF"

    sudo netplan apply

    # Edit tun0.network
    sudo bash -c "cat > /etc/systemd/network/tun0.network <<EOF
[Network]
Address=2619:db8:85a3:1b2e::1/64
Gateway=2619:db8:85a3:1b2e::2
EOF"
fi

# Restart the necessary services
echo "Restarting necessary services..."
sudo systemctl restart systemd-networkd

# Ask for system reboot
read -p "Would you like to reboot the system? (yes/no): " reboot_choice
if [ "$reboot_choice" == "yes" ]; then
    echo "Rebooting the system..."
    sudo reboot
else
    echo "Operation completed. No reboot required."
fi

# ==========================================
# End of script
# Created by Parsa in OPIran club
# Love Iran :)
# ==========================================
