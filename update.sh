#!/bin/bash
TODAY=`date --iso-8601`
unzip -u ../Corona-.xlsx -d SH.xlsx
unzip -u ../Corona-RKI.xlsx -d RKI.xlsx
git add SH.xlsx
git add RKI.xlsx
git commit -m "Update vom $TODAY"
git push
