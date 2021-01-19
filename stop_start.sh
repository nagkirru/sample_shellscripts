#!/bin/sh

LOGFILE="/u/NAGA/START_STOP.log"
Func_Type=$1

# Maintain size of logfile
if [[ -f ${LOGFILE} ]]
then
  logsize=$(cat ${LOGFILE} | wc -c)
  if (( ${logsize} > 2000000 ))
  then
    mv ${LOGFILE} ${LOGFILE}.old
  fi
fi


echo "*********************************" >> ${LOGFILE}
echo "Begin : `date`">> ${LOGFILE}
echo "Running from `hostname -f`">> ${LOGFILE}


START_APPS()
{


for line in `cat config_file.txt`
do
    echo "Reading line:$line" >> ${LOGFILE}
    USER=`echo $line | cut -f1 -d'|'`
    DIRECTORY=`echo $line | cut -f2 -d'|'`
    ALL_SERVICES=`echo $line | cut -f3 -d'|'`
    echo "USER:$USER,DIRECTORY:$DIRECTORY,ALL_SERVICES:$ALL_SERVICES" >> ${LOGFILE}
    #ssh $USER.............
    #cd $DIRECTORY
    for service in $(echo $ALL_SERVICES | sed "s/,/ /g")
    do

       echo "echo service:$service" >> ${LOGFILE}
       #START $service


    done


    echo "End working on the line" >> ${LOGFILE}


done

}


STOP_APPS()
{

for line in `cat config_file.txt`
do
    USER=`echo $line | cut -f1 -d'|'`
    DIRECTORY=`echo $line | cut -f2 -d'|'`
    ALL_SERVICES=`echo $line | cut -f3 -d'|'`
    echo "USER:$USER,DIRECTORY:$DIRECTORY,ALL_SERVICES:$ALL_SERVICES" >> ${LOGFILE}


done



}




if [[ $Func_Type == "START" ]]
then
   START_APPS
elif [[ $Func_Type == "STOP" ]]
then
   STOP_APPS
else
   echo "Invalid Function Feed - $Func_Type" >> ${LOGFILE}
   echo "Provide below Function Type as input argument" >> ${LOGFILE}
   echo "START,STOP" >> ${LOGFILE}

fi


echo "End Script : `date`">> ${LOGFILE}
echo "*********************************" >> ${LOGFILE}
