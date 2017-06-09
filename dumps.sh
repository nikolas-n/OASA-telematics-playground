#!/bin/bash
if [ ! -d dumps ]; then
mkdir dumps
fi
cd dumps
declare -a dumps=("lines" "routes" "stops")
for i in "${dumps[@]}"
do
wget -O "$i".archive "http://telematics.oasa.gr/api/?act=get$i"
zcat "$i".archive | sed 's/),(/\n/g' | tr -d "(" | tr -d ")" | tr -d '"' > "$i".dump
done


