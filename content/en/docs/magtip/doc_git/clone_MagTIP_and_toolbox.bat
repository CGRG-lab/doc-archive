@ECHO OFF
ECHO ======================================
ECHO Start to download MagTIP and toolbox 
ECHO and establish the link with the remote
ECHO ======================================

git clone https://github.com/okatsn/MagTIP-2022.git
cd MagTIP-2022
git remote add upstream https://github.com/okatsn/MagTIP-2022.git
cd ..

git clone https://github.com/okatsn/toolbox.git
cd toolbox
git remote add upstream https://github.com/okatsn/toolbox.git
cd ..

ECHO =======================================================
ECHO MagTIP and dependent toolbox is successfully downloaded.
ECHO This should be done once; don't do this again.
ECHO Please close the command window manually.
PAUSE