#!/bin/bash
#git checkout https://github.com/ulikoenig/SARS-COV-2.git
echo Update GIT
git pull

restoreFile(){
TODAY=`date --iso-8601`
echo Wiederherstellung $1
cd $1.xlsx
zip -q -9 -r ../$1.xlsx.zip *
cd ..
mv $1.xlsx.zip $1-restore-$TODAY.xlsx
echo Erledigt
}

restoreFile "SH"
restoreFile "RKI"
