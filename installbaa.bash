#!/bin/bash

# Update sources
apt-get -y update
apt-get -y upgrade
apt-get -y install cydia
apt-get -y install python
# Trash PlexConnect Folder if exists to avoid database errors
if [ -s /Applications/PlexConnect ]
then
rm -rf /Applications/PlexConnect
fi
# Clone Theme
cd /Applications
git clone git://github.com/iBaa/PlexConnect.git
# Create Certs
cd /Applications/PlexConnect
openssl req -new -nodes -newkey rsa:2048 -outform pem -out ./assets/certificates/trailers.cer -keyout ./assets/certificates/trailers.key -x509 -days 3650 -subj "/C=US/CN=trailers.apple.com"
cat ./assets/certificates/trailers.cer ./assets/certificates/trailers.key >> ./assets/certificates/trailers.pem
# install requirements from atvjailbreak github
cd /Applications/atvjailbreak
dpkg -i python_2.7.3-3_iphoneos-arm.deb
rm -R /Applications/PlexConnect/Settings.cfg
cp /Applications/PlexConnect/Settings.cfg /Applications/PlexConnect
cp -rf hosts /
# install autoupdate plist
cp update.bash /usr/bin
cp updatebash.bash /usr/bin
chmod +x /usr/bin/update.bash
chmod +x /usr/bin/updatebash.bash
cp com.plex.plexconnect.auto.plist /Library/LaunchDaemons
chown root /Library/LaunchDaemons/com.plex.plexconnect.auto.plist
chmod 644 /Library/LaunchDaemons/com.plex.plexconnect.auto.plist
launchctl load /Library/LaunchDaemons/com.plex.plexconnect.auto.plist
# Install launchctl bash plist
chmod +x /Applications/PlexConnect/support/aTV_jailbreak/install.bash
/Applications/PlexConnect/support/aTV_jailbreak/install.bash
# Install button
chmod +x /Applications/PlexConnect/support/aTV_jailbreak/install_button.bash
/Applications/PlexConnect/support/aTV_jailbreak/install_button.bash
# Reboot to load new button
reboot