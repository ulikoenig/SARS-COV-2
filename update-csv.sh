#!/bin/bash
cd "$(dirname "$0")"
TODAY=`date`
echo Update Git
git pull

echo Hole CSV von RKI
until wget -O RKI-CSV.csv.tmp  https://opendata.arcgis.com/datasets/dd4580c810204019a7b8eb3e0b329dd6_0.csv 
do 
	sleep 10
done 

echo Hole HTML von STK
until wget -O "./STK-Quelle/`date --iso-8601`-STK.html"  https://www.schleswig-holstein.de/DE/Landesregierung/I/Presse/_documents/Corona-Liste_Kreise.html
do 
	sleep 10
done 


mv RKI-CSV.csv.tmp RKI-CSV.csv
echo Upload
git add RKI-CSV.csv
git add update-csv.sh
git add STK-Quelle
#git commit -m "CSV Update von $TODAY - Quellenvermerk: Robert Koch-Institut (RKI), dl-de/by-2-0"
#git push

echo Fertig
