[English](https://github.com/ParsaKSH/Create-Private-IPv6-with-Sit/blob/main/README.md)



درودی به وسعت خاکم ایران
سپاس از اینکه این اسکریپت رو انتخاب کردید.
با استفاده از این اسکریپت می‌تونید بین یک سرور ایران و چندین سرور خارج، آیپی ورژن6 لوکال(خصوصی) بر روی آیپی ورژن4 خود سرور ها داشته باشید.


برای استفاده از اسکریپت، مراحل زیر رو پیش برید:
1_اسکریپت رو با دستوری که در زیر هست روی سرور ایرانتون اجرا کنید.
2_در پاسخ به پرسش 
Are you running this script on the IRAN server or the FOREIGN server? (IRAN/FOREIGN):
عبارت IRAN یا iran رو وارد کنید.
3_آیپی سرور ایرانتون رو وارد کنید
4_مقدار mtu رو وارد کنید(اگر نمی‌دونید که چیه، چیزی وارد نکنید و enter بزنید.)
5_در پاسخ به پرسش 
How many FOREIGN servers do you have?
تعداد سرورهای خارجی که می‌خواید به این سرور وصل کنید رو وارد کنید.
6_Enter IPv4 of FOREIGN server #1:
به ترتیب آیپی سرور(های) خارجتون رو وارد کنید.
آیپی های سرور ایران شما در قبال هر سرور خارج نمایش داده شده و کار روی سرور ایران تمومه، فقط کافیه که سرور رو ریبوت کنید.

سرور(های) خارج:
1_دستور اجرای اسکریپت رو وارد کنید.
2_در پاسخ به پرسش 
Are you running this script on the IRAN server or the FOREIGN server? (IRAN/FOREIGN):
عبارت FOREIGN رو وارد کنید.
3_آیپی سرور خارجتون رو وارد کنید.
4_آیپی سرور ایرانتون رو وارد کنید.
5_مقدار mtu رو وارد کنید(اگر نمی‌دونید که چیه، چیزی وارد نکنید و enter بزنید.)
6_در پاسخ به پرسش 
Which number is this FOREIGN server? (If you have multiple foreign servers, type which one this is. If only one, type 1):
باید عددی رو وارد کنید که در انجام تنظیمات داخل سرور ایران، این سرور خارج رو با اون شماره معرفی کردید.

تنظیمات روی این سرور خارج تموم شد و آیپی6 لوکال این سرور هم به شما نمایش داده شده.
سرور رو ریبوت کنید.

دستور اجرای اسکریپت:
```
bash <(curl -Ls https://raw.githubusercontent.com/ParsaKSH/Create-Private-IPv6-with-Sit/main/script.sh)
```


اگر مشکل یا سوالی بود داخل گروه اپ‌ایران من رو تگ کنید و سوالتون رو بپرسید.
آی‌دی تلگرام من: 
@ParsaA_KSH
لینک گروه اپ‌ایران: https://t.me/OPIranClub

 اگر به کارتون اومد، ممنون میشم  به پروژه ستاره بدید❤️



حمایت مالی:
Tron
TD3vY9Drpo3eLi8z2LtGT9Vp4ESuF2AEgo
USDT
UQAm3obHuD5kWf4eE4JmAO_5rkQdZPhaEpmRWs6Rk8vGQJog
TON
bc1qaquv5vg35ua7qnd3wlueytw0fugpn8qkkuq9r2
BTC
0x800680F566A394935547578bc5599D98B139Ea22


