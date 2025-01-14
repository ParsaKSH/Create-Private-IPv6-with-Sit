#!/bin/bash

echo -e "\033[1;33m=========================================="
echo -e "Created by Parsa in OPIran club https://t.me/OPIranClub"
echo -e "Love Iran :)"
echo -e "==========================================\033[0m"

function ask_yes_no() {
    local prompt=$1
    local answer=""
    while true; do
        read -p "$prompt (yes/no): " answer
        if [[ "$answer" == "yes" || "$answer" == "no" ]]; then
            echo "$answer"
            break
        else
            echo -e "\033[1;31mOnly yes or no allowed.\033[0m"
        fi
    done
}

server_location=$(ask_yes_no "Are you running this script on the Iran server?")

echo -e "\033[1;33mUpdating and installing required packages...\033[0m"
sudo apt update
sudo apt-get install iproute2 -y
sudo apt install nano -y
sudo apt install netplan.io -y

if [ "$server_location" == "yes" ]; then
    read -p "How many foreign servers do you have? " n_server
    
    declare -a foreign_ips
    for (( i=1; i<=n_server; i++ ))
    do
        read -p "Enter the IPv4 address of foreign server #$i: " foreign_ips[$i]
        even_num=$((i * 2))
        sudo bash -c "cat > /etc/netplan/pdtun$i.yaml <<EOF
network:
  version: 2
  tunnels:
    tunel0$i:
      mode: sit
      local: $iran_ip
      remote: ${foreign_ips[$i]}
      addresses:
        - 2619:db8:85a3:1b2e::$even_num/64
      mtu: 1420
EOF"
        
        sudo bash -c "cat > /etc/systemd/network/tun$i.network <<EOF
[Network]
Address=2619:db8:85a3:1b2e::$even_num/64
Gateway=2619:db8:85a3:1b2e::$((even_num - 1))
EOF"
        
        echo -e "\033[1;37mPrivate-IPv6 for Iran server to foreign server #$i: 2619:db8:85a3:1b2e::$even_num\033[0m"
    done
    
    for (( i=1; i<=n_server; i++ ))
    do
        sudo ip -6 route add 2619:db8:85a3:1b2e::$((i * 2 - 1))/128 dev tunel0$i
    done
else
    read -p "Which foreign server number is this? (If only one, enter 1): " server_number
    
    if (( server_number % 2 == 0 )); then
        this_server=$((server_number + 1))
    else
        this_server=$server_number
    fi
    
    sudo bash -c "cat > /etc/netplan/pdtun.yaml <<EOF
network:
  version: 2
  tunnels:
    tunel01:
      mode: sit
      local: $foreign_ip
      remote: $iran_ip
      addresses:
        - 2619:db8:85a3:1b2e::$this_server/64
      mtu: 1420
EOF"
    
    sudo bash -c "cat > /etc/systemd/network/tun0.network <<EOF
[Network]
Address=2619:db8:85a3:1b2e::$this_server/64
Gateway=2619:db8:85a3:1b2e::$((this_server + 1))
EOF"
    
    echo -e "\033[1;37mPrivate-IPv6 for this foreign server: 2619:db8:85a3:1b2e::$this_server\033[0m"
fi

sudo netplan apply
sudo systemctl restart systemd-networkd

reboot_choice=$(ask_yes_no "Operation completed successfully. Please reboot the system")
if [ "$reboot_choice" == "yes" ]; then
    echo -e "\033[1;33mRebooting the system...\033[0m"
    sudo reboot
else
    echo -e "\033[1;33mOperation completed successfully. Reboot required.\033[0m"
fi
