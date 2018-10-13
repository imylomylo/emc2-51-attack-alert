# EMC 51 Alert
Put this in your cron replacing /home/user/contrib with the location for these scripts.
Also assumption einsteinium-cli is installed and available at /home/user/einsteinium/src/einsteinium-cli

```
# STATS COLLECTORS
#* * * * * /home/user/contrib/monitor_timelast30blocks 2>&1
* * * * * /home/user/contrib/emc2/cron.query.emc2.network.sh 2>&1
# 51 ALERTS
* * * * * /home/user/contrib/emc2/stats.emc2.networkhashps.10min.sh 2>&1
```

For the alert to works, create a telegram bot. Rename telegram_info.txt.sample to telegram_info.txt
Alternatively you can email through mailgun, or start an emergency conference call through twilio
