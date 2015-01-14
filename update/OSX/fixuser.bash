#!/bin/bash

cd /Applications/PlexConnect/update/OSX

if [ -s /Applications/PlexConnect/update/OSX/sudoers3 ]

then
rm /Applications/PlexConnect/update/OSX/sudoers3
sed -e "s/__USERNAME__/user/" "/Applications/PlexConnect/update/OSX/sudoers" > /Applications/PlexConnect/update/OSX/sudoers3

else
sed -e "s/__USERNAME__/user/" "/Applications/PlexConnect/update/OSX/sudoers" > /Applications/PlexConnect/update/OSX/sudoers3

fi

cp /Applications/PlexConnect/update/OSX/sudoers3 /etc/sudoers

chmod 440 /etc/sudoers
