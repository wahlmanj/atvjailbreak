plexconnect-app
===============

# ios devices

SSH into your JB iOS device (install OpenSSH from the BB repo if needed) then paste this easy one liner or fire up mobile terminal on your iOS device and paste it using that instead. "APT 0.7 Strict" or higher required (a simple search in cydia will allow you to install it, required for apt-get function).

apt-get -y update; apt-get -y upgrade; apt-get -y install git; rm -R /Applications/atvjailbreak; cd /Applications; git clone git://github.com/wahlmanj/atvjailbreak.git; cd /Applications/atvjailbreak; ./installios.bash

# aTV only

apt-get -y install git; rm -R /Applications/atvjailbreak; cd /Applications; git clone git://github.com/wahlmanj/atvjailbreak.git; cd /Applications/atvjailbreak; chmod +x installatv.bash; ./installatv.bash

# How to build a .deb

change dir to the latest plexconnect from ibaa e.g. cd /Users/user/desktop/PlexConnect
tar -czf /users/user/desktop/PlexConnect.tar.gz *

or create a folder then put your files in it

if expanding existing debs use this for an example:

ar vx plexconnect.deb

make sure to clear all .DS_Store files in all directories before building deb

e.g. cd /Users/user/desktop/PlexConnect

rm .DS_Store

cd Applications

rm .DS_Store

cd DEBIAN

rm .DS_Store

change dir to folder that has that includes the deb file structure e.g. cd /Users/user/desktop
dpkg-deb -b plexconnect

* where plexconnect is the folder that has the deb structure Applications and DEBIAN
