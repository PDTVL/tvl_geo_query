#!/bin/bash
today=$(date +"%Y-%m-%d")
while read line
do
User=$(echo $line  | cut -d "," -f1)
IP=$(echo $line  | cut -d "," -f2)
Geo=$(
    if [[ $IP =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        geoiplookup $IP
    else
        geoiplookup6 $IP
    fi
)

echo $User "," $IP "," $Geo | grep -v 'Event Description\|GB, United Kingdom\|ES, Spain\|IE, Ireland\|IN, India' >> GeoResults-"${today}".csv

done < GoogleAdmin_logins.csv


