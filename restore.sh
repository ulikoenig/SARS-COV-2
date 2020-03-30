#!/bin/bash
#git checkout https://github.com/ulikoenig/SARS-COV-2.git
git pull

restoreFile(){
TODAY=`date --iso-8601`
cd $1.xlsx
zip -r ../$1.xlsx.zip *
cd ..
mv $1.xlsx.zip $1-restore-$TODAY.xlsx
}

restoreFile "SH"
