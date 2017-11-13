#!/bin/bash
#
# Usage: ./getarrivals.sh stopCode
# e.g. : ./getarrivals.sh 310020 
#

BASEURL="http://telematics.oasa.gr/api/?act="
ACTION="getStopArrivals"
STOP=$1

curl -s "http://telematics.oasa.gr/api/?act=getStopNameAndXY&p1=$STOP" | jq -r '.[].stop_descr'

echo "========"

thecurl=$(curl -s "$BASEURL$ACTION" --data "p1=$STOP" |  jq  -r 'map(.route_code,",",.veh_code,",",.btime2,"\n") | join ("")' | awk NF)

IFS=","
while read -r route vehicle time; do
  route=$(grep "$route" "/home/nik/projects/oasa/OASA-telematics-playground/routes" | awk -F "," '{print $4}')
  my+="$route : $time´
"
done <<< "$thecurl"
echo "$my" |  awk -F':' -v OFS='' '{x=$1;$1="";a[x]=a[x]$0}END{for(x in a)print x,":"a[x]}' | grep -v ":$"
