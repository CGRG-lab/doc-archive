@ECHO OFF
ECHO You are going to update MagTIP and its dependent toolbox
ECHO All changes you have made on the source code will be lost
ECHO Continue? 
PAUSE

cd MagTIP-2022
git fetch --all
git reset --hard origin/master
cd ..
ECHO =====================
ECHO MagTIP is up-to-date
ECHO =====================

cd toolbox
git fetch --all
git reset --hard origin/master
cd ..
ECHO =====================
ECHO toolbox is up-to-date
ECHO =====================
ECHO You can close the window now
PAUSE