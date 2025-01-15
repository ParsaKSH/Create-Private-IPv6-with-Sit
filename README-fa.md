[English](https://github.com/ParsaKSH/Create-Private-IPv6-with-Sit/blob/main/README.md)


درودی به وسعت خاکم ایران!  
سپاس از اینکه این اسکریپت رو انتخاب کردید. این اسکریپت به شما امکان می‌دهد بین یک سرور ایران و چندین سرور خارج، آیپی ورژن۶ خصوصی (لوکال) را روی آیپی ورژن۴ سرورهای خود داشته باشید.

**مراحل استفاده از اسکریپت (روی سرور ایران)**  
1. اسکریپت را با دستور زیر در سرور ایران اجرا کنید.  
2. در پاسخ به پرسش:  
   `Are you running this script on the IRAN server or the FOREIGN server? (IRAN/FOREIGN):`  
   عبارت **IRAN** یا **iran** را وارد کنید.  
3. آیپی سرور ایران را وارد کنید.  
4. مقدار **MTU** را مشخص کنید (یا برای مقدار پیش‌فرض، فقط Enter بزنید).  
5. در پاسخ به پرسش:  
   `How many FOREIGN servers do you have?`  
   تعداد سرورهای خارجی موردنظر را وارد کنید.  
6. برای هر پرسش مشابه  
   `Enter IPv4 of FOREIGN server #1:`  
   آیپی سرورهای خارجی خود را یکی‌یکی وارد کنید.  
   اسکریپت در پایان آیپی‌های IPv6 مربوط به سرور ایران را نمایش می‌دهد؛ سپس سرور ایران را ریبوت کنید.

**سرور(های) خارج**  
1. اسکریپت را با همان دستور در سرور خارجی اجرا کنید.  
2. در پاسخ به پرسش:  
   `Are you running this script on the IRAN server or the FOREIGN server? (IRAN/FOREIGN):`  
   عبارت **FOREIGN** را وارد کنید.  
3. آیپی سرور خارجی را وارد کنید.  
4. آیپی سرور ایران را وارد کنید.  
5. مقدار **MTU** را وارد کنید (یا Enter برای مقدار پیش‌فرض).  
6. در پاسخ به پرسش:  
   `Which number is this FOREIGN server? (If you have multiple foreign servers, type which one this is. If only one, type 1):`  
   شماره‌ای را وارد کنید که موقع پیکربندی سرور ایران، برای این سرور خارجی در نظر گرفتید.  
   اسکریپت در انتها آیپی IPv6 خصوصی این سرور را نمایش می‌دهد؛ سپس سرور خارجی را ریبوت کنید.

**دستور اجرای اسکریپت**:
```
bash <(curl -Ls https://raw.githubusercontent.com/ParsaKSH/Create-Private-IPv6-with-Sit/main/script.sh)
```

اگر سؤال یا مشکلی داشتید، در گروه اُپ‌ایران من را منشن کنید تا راهنمایی کنم.  
- **آی‌دی تلگرام من**: [@ParsaA_KSH](https://t.me/ParsaA_KSH)  
- **لینک گروه اُپ‌ایران**: [https://t.me/OPIranClub](https://t.me/OPIranClub)  

اگر این اسکریپت برایتان مفید بود، سپاسگزار می‌شوم اگر به پروژه ستاره بدهید ❤️  

**حمایت مالی**  
- **Tron**: TD3vY9Drpo3eLi8z2LtGT9Vp4ESuF2AEgo  
- **USDT**: UQAm3obHuD5kWf4eE4JmAO_5rkQdZPhaEpmRWs6Rk8vGQJog  
- **TON**: bc1qaquv5vg35ua7qnd3wlueytw0fugpn8qkkuq9r2  
- **BTC**: 0x800680F566A394935547578bc5599D98B139Ea22  
