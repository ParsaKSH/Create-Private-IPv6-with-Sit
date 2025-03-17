[فارسی](https://github.com/ParsaKSH/Create-Private-IPv6-with-Sit/blob/main/README.md)



Greetings from the heart of Iran!  
Thank you for choosing this script. It allows you to set up local (private) IPv6 addresses over your servers’ IPv4 connections between one Iranian server and multiple foreign servers.

**How to use this script**  
1. Run the script on your Iranian server using the command shown below.  
2. When asked:  
   `Are you running this script on the IRAN server or the FOREIGN server? (IRAN/FOREIGN):`  
   type **IRAN** or **iran**.  
3. Enter the IPv4 address of your Iranian server.  
4. Enter the MTU value (or just press **Enter** to use the default if you’re unsure).  
5. When asked:  
   `How many FOREIGN servers do you have?`  
   enter the number of foreign servers you want to connect.  
6. For each foreign server prompt (e.g. `Enter IPv4 of FOREIGN server #1:`), enter its IPv4 address.  
   The script will show you the corresponding IPv6 addresses for your Iranian server. Once that’s done, simply reboot your Iranian server.

**For the foreign servers**  
1. Run the script on each foreign server using the same command.  
2. When asked:  
   `Are you running this script on the IRAN server or the FOREIGN server? (IRAN/FOREIGN):`  
   type **FOREIGN**.  
3. Enter the foreign server’s IPv4 address.  
4. Enter the Iranian server’s IPv4 address.  
5. Enter the MTU value (or just press **Enter** to use the default).  
6. When asked:  
   `Which number is this FOREIGN server? (If you have multiple foreign servers, type which one this is. If only one, type 1):`  
   enter the same server number you used when setting up on the Iranian server.

Once the script finishes, the local IPv6 address for that foreign server will be displayed. Reboot the foreign server afterward.

**How to run the script:**
```
bash <(curl -Ls https://raw.githubusercontent.com/ParsaKSH/Create-Private-IPv6-with-Sit/main/script.sh)
```

If you have any questions or issues, feel free to tag me in the OPIran group on Telegram:
- **Telegram ID**: @ParsaA_KSH  
- **OPIran group**: [https://t.me/OPIranClub](https://t.me/OPIranClub)  

If you found this script helpful, giving a star to the project would be greatly appreciated ❤️  

