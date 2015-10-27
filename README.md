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
