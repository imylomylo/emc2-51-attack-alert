#!/bin/bash
TELEGRAMDIR=/home/user/bin/telegram
WORKDIR=/home/user/contrib/emc2
# CHECK IF RECENT SEND THEN EXIT
PREVIOUS=`cat ${WORKDIR}/lastsent`
NOW=`date +%s`
SENDTHRESHOLD=300
echo "Previous: ${PREVIOUS}"
echo "NOW: ${NOW}"
echo "Threshold (s): ${SENDTHRESHOLD}"
if (( $(echo "${NOW} - ${PREVIOUS} <  ${SENDTHRESHOLD}" | bc -l) ))
	then
	echo "Less than 300 seconds...exiting"
	exit
fi
# LATEST RECORDS
LAST10min=$(tail -n 1 ${WORKDIR}/emc2.networkhashps.10min.log | cut -d . -f 1)
LATEST=$(tail -n 1 ${WORKDIR}/emc2.networkhashps.1min.log | cut -d . -f 1)
PERCENT10=$(echo "scale=3; (${LATEST})*100/(${LAST10min})-100" | bc)

# 20,30,40,50,60,70,80,90,100,110,120 MINUTES AGO
MINSAGO20=$(tail -n 2 ${WORKDIR}/emc2.networkhashps.10min.log | head -n 1 | cut -d . -f 1)
MINSAGO30=$(tail -n 3 ${WORKDIR}/emc2.networkhashps.10min.log | head -n 1 | cut -d . -f 1)
MINSAGO40=$(tail -n 4 ${WORKDIR}/emc2.networkhashps.10min.log | head -n 1 | cut -d . -f 1)
MINSAGO50=$(tail -n 5 ${WORKDIR}/emc2.networkhashps.10min.log | head -n 1 | cut -d . -f 1)
MINSAGO60=$(tail -n 6 ${WORKDIR}/emc2.networkhashps.10min.log | head -n 1 | cut -d . -f 1)
MINSAGO70=$(tail -n 7 ${WORKDIR}/emc2.networkhashps.10min.log | head -n 1 | cut -d . -f 1)
MINSAGO80=$(tail -n 8 ${WORKDIR}/emc2.networkhashps.10min.log | head -n 1 | cut -d . -f 1)
MINSAGO90=$(tail -n 9 ${WORKDIR}/emc2.networkhashps.10min.log | head -n 1 | cut -d . -f 1)
MINSAGO100=$(tail -n 10 ${WORKDIR}/emc2.networkhashps.10min.log | head -n 1 | cut -d . -f 1)
MINSAGO110=$(tail -n 11 ${WORKDIR}/emc2.networkhashps.10min.log | head -n 1 | cut -d . -f 1)
MINSAGO120=$(tail -n 12 ${WORKDIR}/emc2.networkhashps.10min.log | head -n 1 | cut -d . -f 1)

PERCENT20=$(echo "scale=3; (${LATEST})*100/(${MINSAGO20})-100" | bc)
PERCENT30=$(echo "scale=3; (${LATEST})*100/(${MINSAGO30})-100" | bc)
PERCENT40=$(echo "scale=3; (${LATEST})*100/(${MINSAGO40})-100" | bc)
PERCENT50=$(echo "scale=3; (${LATEST})*100/(${MINSAGO50})-100" | bc)
PERCENT60=$(echo "scale=3; (${LATEST})*100/(${MINSAGO60})-100" | bc)
PERCENT70=$(echo "scale=3; (${LATEST})*100/(${MINSAGO70})-100" | bc)
PERCENT80=$(echo "scale=3; (${LATEST})*100/(${MINSAGO80})-100" | bc)
PERCENT90=$(echo "scale=3; (${LATEST})*100/(${MINSAGO90})-100" | bc)
PERCENT100=$(echo "scale=3; (${LATEST})*100/(${MINSAGO100})-100" | bc)
PERCENT110=$(echo "scale=3; (${LATEST})*100/(${MINSAGO110})-100" | bc)
PERCENT120=$(echo "scale=3; (${LATEST})*100/(${MINSAGO120})-100" | bc)
# DEBUG
#DELTARAW=$((  ${LATEST} - ${LAST10min}  ))

# FUNCTION for putting commas, in numbers for readability on message sending.
function thousands {
    sed -re ' :restart ; s/([0-9])([0-9]{3})($|[^0-9])/\1,\2\3/ ; t restart '
}

# READABILITY VARS
tLAST10min=`echo ${LAST10min} | thousands`
tLATEST=`echo ${LATEST} | thousands`
ghLAST10min=$(( ${LAST10min} / 1000000000 ))
ghLATEST=$(( ${LATEST} / 1000000000 ))
ghMINSAGO20=$(( ${MINSAGO20} / 1000000000 ))
ghMINSAGO30=$(( ${MINSAGO30} / 1000000000 ))
ghMINSAGO40=$(( ${MINSAGO40} / 1000000000 ))
ghMINSAGO50=$(( ${MINSAGO50} / 1000000000 ))
ghMINSAGO60=$(( ${MINSAGO60} / 1000000000 ))
ghMINSAGO70=$(( ${MINSAGO70} / 1000000000 ))
ghMINSAGO80=$(( ${MINSAGO80} / 1000000000 ))
ghMINSAGO90=$(( ${MINSAGO90} / 1000000000 ))
ghMINSAGO100=$(( ${MINSAGO100} / 1000000000 ))
ghMINSAGO110=$(( ${MINSAGO110} / 1000000000 ))
ghMINSAGO120=$(( ${MINSAGO120} / 1000000000 ))
# MSG
MSG="
### EMC2 ###
${PERCENT10}% 
${ghLATEST} GHash 
(Latest:  ${tLATEST})
--- MINUTES AGO ---
10=  ${ghLAST10min} GHash ${PERCENT10}%
20=  ${ghMINSAGO20} GHash ${PERCENT20}%
30=  ${ghMINSAGO30} GHash ${PERCENT30}%
40=  ${ghMINSAGO40} GHash ${PERCENT40}%
50=  ${ghMINSAGO50} GHash ${PERCENT50}%
60=  ${ghMINSAGO60} GHash ${PERCENT60}%
70=  ${ghMINSAGO70} GHash ${PERCENT70}%
80=  ${ghMINSAGO80} GHash ${PERCENT80}%
90=  ${ghMINSAGO90} GHash ${PERCENT90}%
100= ${ghMINSAGO100} GHash ${PERCENT100}%
110= ${ghMINSAGO110} GHash ${PERCENT110}%
120= ${ghMINSAGO120} GHash ${PERCENT120}%
"
echo ${MSG}

# TEST IF LESS THAN 1% CHANGE EXAMPLE
#if (( $(echo "${PERCENT10} <  1" | bc -l) ))
#then
#        echo "Less than 1%"
#fi

# RULE FOR SENDING ANY INCREASE SINCE LAST 10 MINS
if (( ${LATEST}*100/${LAST10min}-100 > 10 | bc -l )) \
|| (( ${LATEST}*100/${MINSAGO20}-100 > 10 | bc -l )) \
|| (( ${LATEST}*100/${MINSAGO30}-100 > 10 | bc -l )) \
|| (( ${LATEST}*100/${MINSAGO40}-100 > 15 | bc -l )) \
|| (( ${LATEST}*100/${MINSAGO50}-100 > 15 | bc -l )) \
|| (( ${LATEST}*100/${MINSAGO60}-100 > 15 | bc -l )) \
|| (( ${LATEST}*100/${MINSAGO70}-100 > 15 | bc -l )) \
|| (( ${LATEST}*100/${MINSAGO80}-100 > 15 | bc -l )) \
|| (( ${LATEST}*100/${MINSAGO90}-100 > 15 | bc -l )) \
|| (( ${LATEST}*100/${MINSAGO100}-100 > 15 | bc -l )) \
|| (( ${LATEST}*100/${MINSAGO110}-100 > 15 | bc -l )) \
|| (( ${LATEST}*100/${MINSAGO120}-100 > 15 | bc -l )) 
then 
	LASTSENT=`date +%s`
	${TELEGRAMDIR}/telegram_send.sh  "${MSG}"
	echo ${LASTSENT} > ${WORKDIR}/lastsent
fi
exit
