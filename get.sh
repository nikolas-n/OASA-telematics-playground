#!/bin/bash

if [ ! -d stops_by_route ]; then
mkdir stops_by_route
fi

curl -s "telematics.oasa.gr/api/?act=webGetLines" | jq -r 'map(.LineCode,",",.LineID,",",.LineDescr,"\n") | join ("")' > lines # original command

while IFS=, read lineCode lineID lineDescr; do

json=$(curl -s "telematics.oasa.gr/api/?act=webGetRoutes&p1=$lineCode")

echo $json | jq --arg line "$lineID" -r 'map(.RouteCode,",",.LineCode,",",$line,",",.RouteDescr,"\n") | join ("")' >> myfile

routeCode=$(echo $json | jq -r '.[].RouteCode')

for i in $routeCode; do
route_name=$(curl -s "telematics.oasa.gr/api/?act=getRouteName&p1=$i" | jq -r 'map(.route_descr) | join("")')

route_name=${route_name// /_}

curl -s "telematics.oasa.gr/api/?act=webGetStops&p1=$i" | jq -r 'map(.StopCode,",",.StopDescr,"\n") | join ("")' | awk 'NF' > stops_by_route/"$lineID"-"$route_name"

echo "Οι στάσεις της διαδρομής $route_name της γραμμής $lineID αποθηκεύθηκαν"
done
done < lines
awk 'NF' myfile > routes
rm myfile

if [ ! -d routes_by_stop ]; then
mkdir routes_by_stop
fi


cat stops_by_route/* > unsorted_stops

sort unsorted_stops | uniq > unique_stops
rm unsorted_stops
while IFS=, read stopCode stopName; do
stopName=${stopName// /_}
curl -s "telematics.oasa.gr/api/?act=webRoutesForStop&p1=$stopCode" | jq -r 'map(.LineID,",",.RouteDescr,"\n") | join("")' | uniq | awk 'NF' > routes_by_stop/"$stopCode"_"$stopName"
echo "Οι διαδρομές της στάσης $stopName αποθηκεύθηκαν"
done < unique_stops

