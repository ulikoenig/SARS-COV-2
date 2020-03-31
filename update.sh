#!/bin/bash
TODAY=`date --iso-8601`
git pull
echo Entferne alte Daten
rm -r SH.xlsx
rm -r RKI.xlsx
echo Entpacke Excel Dateien
unzip -u ../Corona-.xlsx -d SH.xlsx
unzip -u ../Corona-RKI.xlsx -d RKI.xlsx
echo Formatiere XML
find . -name "*.xml" -type f -exec xmllint --output '{}' --format '{}' \;
echo Upload
git add SH.xlsx
git add RKI.xlsx
git commit -m "Update vom $TODAY"
git push
echo Fertig
