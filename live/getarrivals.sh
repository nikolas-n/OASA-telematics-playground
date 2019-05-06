#!/bin/bash
#
# Usage: ./getarrivals.sh stopCode
# e.g. : ./getarrivals.sh 310020 
#

BASEURL="http://telematics.oasa.gr/api/?act="
ACTION="getStopArrivals"
STOP=$1

echo "<span><h4>"
curl -s "http://telematics.oasa.gr/api/?act=getStopNameAndXY&p1=$STOP" | jq -r '.[].stop_descr' 2>/dev/null
echo "</h4>"

thecurl=$(curl -s "$BASEURL$ACTION" --data "p1=$STOP")
if [[ ! -z $thecurl ]]
then
thecurl=$(echo "$thecurl" | jq  -r 'map(.route_code,",",.veh_code,",",.btime2,"\n") | join ("")' | awk NF)

IFS=","
while read -r route vehicle time; do
  route=$(grep "$route" "/home/nik/projects/oasa/OASA-telematics-playground/routes" | awk -F "," '{print $3}')
  my+="$route : $time<sup><small>$vehicle</small></sup>
"
done <<< "$thecurl"
echo "$my" |  awk -F':' -v OFS='' '{x=$1;$1="";a[x]=a[x]$0}END{for(x in a)print x,":"a[x]}' | grep -v ":$" | sed 's/$/<br>/g'
echo "</span>"

fi
