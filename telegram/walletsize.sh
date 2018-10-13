#!/bin/bash
TELEGRAMDIR=/home/user/bin/telegram
WALLETSIZE=`cd /home/user/.komodo;du -sh wallet.dat`
${TELEGRAMDIR}/telegram_send.sh "${WALLETSIZE}"
