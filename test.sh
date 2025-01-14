#!/bin/bash

echo -e "\033[1;33m=========================================="
echo -e "Created by Parsa in OPIran club https://t.me/OPIranClub"
echo -e "Love Iran :)"
echo -e "==========================================\033[0m"

# مرحله‌ی اول: تشخیص ایران یا خارج
# (به زبان انگلیسی از کاربر می‌پرسیم روی کدام سرور است)
read -p "Are you running this script on the IRAN server or the FOREIGN server? (IRAN/FOREIGN): " server_location_en

echo -e "\033[1;33mUpdating and installing required packages...\033[0m"
sudo apt update
sudo apt-get install iproute2 -y
sudo apt install nano -y
sudo apt install netplan.io -y

# -- تابع پرسش yes/no قدیمی را نگه می‌داریم چون خواسته شده چیزی از کدها کم نشود:
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

# برای دریافت IPv4 سرور ایران و سرور خارج:
# در نسخه‌ی چند-سروری، همچنان به IPv4 سرور ایران نیاز داریم
if [[ "$server_location_en" == "IRAN" || "$server_location_en" == "iran" ]]; then
    # ما روی سرور ایران هستیم
    read -p "Please enter the IPv4 address of the IRAN server: " iran_ip
    read -p "Please enter the MTU (press Enter for default 1420): " mtu
    mtu=${mtu:-1420}

    # چندتا سرور خارج دارید؟
    read -p "How many FOREIGN servers do you have? " n_server

    # دریافت آیپی تمام سرورهای خارج در یک آرایه
    declare -a foreign_ips
    for (( i=1; i<=$n_server; i++ )); do
        read -p "Enter IPv4 of FOREIGN server #$i: " temp_ip
        foreign_ips[i]=$temp_ip
    done

    # به ازای هر سرور خارج، یک فایل netplan جدید بسازیم:
    # pdtun1.yaml, pdtun2.yaml, ...
    # در addresses از IPv6 با اعداد زوج استفاده می‌کنیم (2, 4, 6, ...)
    # در Gateway از اعداد فرد استفاده می‌کنیم (1, 3, 5, ...)
    # همچنین برای هر سرور فایل systemd-network نیز ایجاد می‌کنیم (tun0, tun1, ...)
    # در پایان هم route مناسب را اضافه می‌کنیم.

    counter_even=2  # از 2 شروع می‌کنیم (برای IP ایران)
    file_index=1
    for (( i=1; i<=$n_server; i++ )); do

        # نام فایل netplan:
        netplan_file="/etc/netplan/pdtun${file_index}.yaml"
        tunnel_name="tunel0${file_index}"

        # مقدار even برای آدرس ایران:
        even_address=$counter_even
        # مقدار odd (فرد) برای Gateway ایران:
        odd_address=$((counter_even - 1)) # اگر even=2 => odd=1, اگر even=4 => odd=3 و ...

        # ساخت فایل netplan مربوط به هر سرور
        sudo bash -c "cat > $netplan_file <<EOF
network:
  version: 2
  tunnels:
    $tunnel_name:
      mode: sit
      local: $iran_ip
      remote: ${foreign_ips[i]}
      addresses:
        - 2619:db8:85a3:1b2e::$even_address/64
      mtu: $mtu
EOF"

        # netplan apply برای هر فایل جدید
        sudo netplan apply

        # فعال کردن و شروع سرویس systemd-networkd (دوباره)
        sudo systemctl unmask systemd-networkd.service
        sudo systemctl start systemd-networkd
        sudo netplan apply

        # حالا فایل systemd-network:
        # نام فایل: tun${i}.network یا tun0, tun1, ... طبق خواسته شما
        network_file="/etc/systemd/network/tun${file_index}.network"
        sudo bash -c "cat > $network_file <<EOF
[Network]
Address=2619:db8:85a3:1b2e::$even_address/64
Gateway=2619:db8:85a3:1b2e::$odd_address
EOF"

        # چاپ IPv6 خصوصی برای سرور ایران مرتبط با این سرور خارج
        echo -e "\033[1;37mThis is your Private-IPv6 for IRAN server #$i: 2619:db8:85a3:1b2e::$even_address\033[0m"

        # افزودن route
        # طبق توضیح: "sudo ip -6 route add 2619:db8:85a3:1b2e::y/128 dev tunel0y"
        # اما در متن درخواست توضیح داده شده که اگر شماره سرور فرد باشد y=i،
        # اگر شماره سرور زوج باشد y=i+1. در عمل از i خودمان استفاده می‌کنیم:
        # چون در ایران server i داریم => باید ببینیم i فرد است یا زوج:
        # ولی دقت کنید: در دستور شما گفتید: "اگر اولین سرور خارج (i=1) => y=1"
        # "اگر دومین سرور خارج (i=2) => y=3" و ...
        # پس y را این‌طوری محاسبه می‌کنیم:
        if (( i % 2 == 1 )); then
            y=$i
        else
            y=$((i+1))
        fi
        # در نهایت dev tunel0y => یعنی dev tunel01, tunel03, ...
        sudo ip -6 route add 2619:db8:85a3:1b2e::$y/128 dev tunel0$y 2>/dev/null

        # آماده برای سرور بعدی
        file_index=$((file_index + 1))
        counter_even=$((counter_even + 2))
    done

    sudo systemctl restart systemd-networkd

    # در پایان مثل اسکریپت قبلی، کاربر را برای ریبوت سوال می‌کنیم
    reboot_choice=$(ask_yes_no "Operation completed successfully. Please reboot the system")
    if [ "$reboot_choice" == "yes" ]; then
        echo -e "\033[1;33mRebooting the system...\033[0m"
        sudo reboot
    else
        echo -e "\033[1;33mOperation completed successfully. Reboot required.\033[0m"
    fi

else
    # ما روی سرور خارج هستیم
    read -p "Please enter the IPv4 address of the FOREIGN server: " foreign_ip
    read -p "Please enter the IPv4 address of the IRAN server: " iran_ip
    read -p "Please enter the MTU (press Enter for default 1420): " mtu
    mtu=${mtu:-1420}

    # می‌پرسیم این چندمین سرور خارج است؟
    # (در پرانتز هم راهنمایی می‌دهیم)
    read -p "Which number is this FOREIGN server? (If you have multiple foreign servers, type which one this is. If only one, type 1): " server_number

    # اگر زوج بود یکی اضافه می‌کنیم، اگر فرد بود همان
    if (( server_number % 2 == 0 )); then
        this_server=$((server_number + 1))
    else
        this_server=$server_number
    fi

    # مثل روال قبلی اما برای FOREIGN server
    # ساخت فایل /etc/netplan/pdtun.yaml
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
      mtu: $mtu
EOF"

    sudo netplan apply
    sudo systemctl unmask systemd-networkd.service
    sudo systemctl start systemd-networkd
    sudo netplan apply

    # فایل /etc/systemd/network/tun0.network
    # Address=2619:db8:85a3:1b2e::$this_server/64
    # Gateway=2619:db8:85a3:1b2e::(this_server+1)
    gateway_for_foreign=$((this_server + 1))
    sudo bash -c "cat > /etc/systemd/network/tun0.network <<EOF
[Network]
Address=2619:db8:85a3:1b2e::$this_server/64
Gateway=2619:db8:85a3:1b2e::$gateway_for_foreign
EOF"

    echo -e "\033[1;37mThis is your Private-IPv6 for your FOREIGN server: 2619:db8:85a3:1b2e::$this_server\033[0m"

    sudo systemctl restart systemd-networkd

    # افزودن route در سرور خارج (مشابه توضیحات)
    # طبق همان روش: اگر شماره سرور فرد بود => y=server_number، اگر زوج بود => server_number+1
    # ولی چون ما قبلا آن را در this_server محاسبه کردیم، پس باید برای route هم همان را پیاده کنیم.
    # با این تفاوت که برای dev چه اینتریفی در نظر بگیریم؟ طبق متن سؤال:
    # sudo ip -6 route add 2619:db8:85a3:1b2e::x/128 dev tunel0x
    # x اینجا همان مقدار this_server است.
    sudo ip -6 route add 2619:db8:85a3:1b2e::$this_server/128 dev tunel0$this_server 2>/dev/null

    # سوال ریبوت مثل قبل
    reboot_choice=$(ask_yes_no "Operation completed successfully. Please reboot the system")
    if [ "$reboot_choice" == "yes" ]; then
        echo -e "\033[1;33mRebooting the system...\033[0m"
        sudo reboot
    else
        echo -e "\033[1;33mOperation completed successfully. Reboot required.\033[0m"
    fi
fi
