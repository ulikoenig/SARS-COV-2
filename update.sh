#!/bin/bash
TODAY=`date --iso-8601`
git pull

echo Hole CSV von RKI
wget -O RKI-CSV.csv  https://opendata.arcgis.com/datasets/dd4580c810204019a7b8eb3e0b329dd6_0.csv 

echo Entferne alte Daten
rm -r SH.xlsx
rm -r RKI.xlsx
rm Corona-SH.xlsx Corona-RKI.xlsx
echo Entpacke Excel Dateien
unzip -u ../Corona-.xlsx -d SH.xlsx
unzip -u ../Corona-RKI.xlsx -d RKI.xlsx

echo Formatiere XML
find . -name "*.xml" -type f -exec xmllint --output '{}' --format '{}' \;
find . -name "*.xml.rels" -type f -exec xmllint --output '{}' --format '{}' \;

echo Kopiere Dateien
cp ../Corona-.xlsx Corona-SH.xlsx
cp ../Corona-RKI.xlsx Corona-RKI.xlsx
 
echo Upload
git add SH.xlsx
git add RKI.xlsx
git add Corona-SH.xlsx 
git add Corona-RKI.xlsx
git add RKI-CSV.csv
git add update.sh
git add restore.sh
git commit -m "Update vom $TODAY"
git push

echo Fertig
