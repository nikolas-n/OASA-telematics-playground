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

curl -s "$BASEURL$ACTION" --data "p1=$STOP" |  jq  -r 'map(.route_code,",",.veh_code,",",.btime2,"\n") | join ("")' | awk NF > go.txt

IFS=","
while read -r route vehicle time; do
  route=$(grep "$route" "/home/nik/projects/oasa/OASA-telematics-playground/routes" | awk -F "," '{print $4}')
echo $route" : "$time"´"
done < go.txt
rm go.txt
