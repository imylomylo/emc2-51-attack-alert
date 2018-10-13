#!/bin/bash
/home/user/einsteinium/src/einsteinium-cli getmininginfo > /home/user/contrib/emc2/cron.result.emc2.mining.json
DIFFICULTY=`cat /home/user/contrib/emc2/cron.result.emc2.mining.json | jq '.difficulty'`
NETWORKHASHPS=`cat /home/user/contrib/emc2/cron.result.emc2.mining.json | jq '.networkhashps'`
MINUTE=`date +%M`
if [ $((${MINUTE} % 30)) == 0  ]
then
	echo ${DIFFICULTY} >> /home/user/contrib/emc2/emc2.difficulty.30min.log
	echo ${NETWORKHASHPS} >> /home/user/contrib/emc2/emc2.networkhashps.30min.log
fi
if [ $((${MINUTE} % 10)) == 0  ]
then
	echo ${DIFFICULTY} >> /home/user/contrib/emc2/emc2.difficulty.10min.log
	echo ${NETWORKHASHPS} >> /home/user/contrib/emc2/emc2.networkhashps.10min.log
fi
if [ $((${MINUTE} % 5)) == 0  ]
then
	echo ${DIFFICULTY} >> /home/user/contrib/emc2/emc2.difficulty.5min.log
	echo ${NETWORKHASHPS} >> /home/user/contrib/emc2/emc2.networkhashps.5min.log
fi
if [ $((${MINUTE} % 1)) == 0  ]
then
	echo ${DIFFICULTY} >> /home/user/contrib/emc2/emc2.difficulty.1min.log
	echo ${NETWORKHASHPS} >> /home/user/contrib/emc2/emc2.networkhashps.1min.log
fi

#
# IF YOU HAVE SPECIFIC MINUTES TO LOG/EMAIL ETC.
#
#if [ "${MINUTE}" == "30" ]
#then
#	echo ${DIFFICULTY} >> /home/user/contrib/emc2/emc2.difficulty.30min.log
#	echo ${NETWORKHASHPS}  >> /home/user/contrib/emc2/emc2.networkhashps.30min.log
#fi
