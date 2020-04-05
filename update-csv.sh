#!/bin/bash
TODAY=`date`
echo Update Git
git pull

echo Hole CSV von RKI
rm RKI-CSV.csv
wget -O RKI-CSV.csv  https://opendata.arcgis.com/datasets/dd4580c810204019a7b8eb3e0b329dd6_0.csv 

echo Upload
git add RKI-CSV.csv
git add update-csv.sh
git commit -m "CSV Update von $TODAY "
git push

echo Fertig
