#!/bin/bash
cd "$(dirname "$0")"
TODAY=`date`
echo Update Git
git pull


#RKI

echo Hole CSV von RKI
until wget -O RKI-CSV.csv.tmp  https://opendata.arcgis.com/datasets/dd4580c810204019a7b8eb3e0b329dd6_0.csv 
do 
	sleep 10
done 
mv RKI-CSV.csv.tmp RKI-CSV.csv
git add RKI-CSV.csv
git commit -m "CSV Update von $TODAY - Quellenvermerk: Robert Koch-Institut (RKI), dl-de/by-2-0"


#STK

echo Hole HTML von STK
until wget -O "/tmp/`date --iso-8601`-STK.html" --header "Cookie: JSESSIONID=0.delivery2-master;" https://www.schleswig-holstein.de/DE/Landesregierung/I/Presse/_documents/Corona-Liste_Kreise.html
do 
	sleep 10
done 
#Entferne zufälligen Mail Hash
sed -e 's/uriHash%[^%]*%//1' "/tmp/`date --iso-8601`-STK.html" > "/tmp/`date --iso-8601`-STK.html.tmp"
rm "/tmp/`date --iso-8601`-STK.html"
mv "/tmp/`date --iso-8601`-STK.html.tmp" "./STK-Quelle/`date --iso-8601`-STK.html"
git add STK-Quelle
git commit -m "HTML Update von $TODAY - Quellenvermerk: Staatskanzlei SH"


#DIVI

echo Hole HTML von Divi
until wget -O "./divi-Quelle/`date --iso-8601`-divi.html.tmp" https://diviexchange.z6.web.core.windows.net/
do 
	sleep 10
done 
mv "./divi-Quelle/`date --iso-8601`-divi.html.tmp" "./divi-Quelle/`date --iso-8601`-divi.html"
git add divi-Quelle
git commit -m "DIVI Update von $TODAY - Quellen https://diviexchange.z6.web.core.windows.net/"


echo Upload
git add update-csv.sh
git commit -m "Script Update vom $TODAY"
git push

echo Fertig
