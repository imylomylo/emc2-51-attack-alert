#!/bin/bash
TELEGRAMDIR=/home/user/bin/telegram
source ${TELEGRAMDIR}/telegram_info.txt
# JUST ECHO
#echo "curl -s -X POST https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage -d chat_id=${TELEGRAM_BOT_CHATID} -d text=\"Hello World\""
# TEST MESSAGE
#curl -s -X POST https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage -d chat_id=${TELEGRAM_BOT_CHATID} -d text="Hello World Again" >> telegram_result.txt
# INPUT $1
curl -s -X POST https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage -d chat_id=${TELEGRAM_BOT_CHATID} -d text="${1}" >> ${TELEGRAMDIR}/telegram_result.txt

