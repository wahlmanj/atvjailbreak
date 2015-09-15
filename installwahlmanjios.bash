#!/bin/bash

# Update sources & install dependencies
apt-get -y update
apt-get -y upgrade
apt-get -y install cydia
apt-get -y install wget

# Trash PlexConnect Folder if exists to avoid database errors
if [ -s /Applications/PlexConnect ]
then
rm -rf /Applications/PlexConnect
fi
# Clone Theme
cd /Applications
git clone git://github.com/Wahlmanj3/PlexConnect.git
# Create Certs
cd /Applications/PlexConnect
openssl req -new -nodes -newkey rsa:2048 -outform pem -out ./assets/certificates/trailers.cer -keyout ./assets/certificates/trailers.key -x509 -days 3650 -subj "/C=US/CN=trailers.apple.com"
cat ./assets/certificates/trailers.cer ./assets/certificates/trailers.key >> ./assets/certificates/trailers.pem
# install requirements from atvjailbreak github if neeeded
cd /Applications/atvjailbreak
cp PlexConnect.py /Applications/PlexConnect
cp PlexConnect.bash /Applications/PlexConnect/support/aTV_jailbreak
if [ -f /usr/bin/python2.7 ];
then
   echo "Python already installed, skipping"
else
  dpkg -i python_2.7.3-3_iphoneos-arm.deb
fi
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
sleep 3
launchctl unload /Library/LaunchDaemons/com.plex.plexconnect.bash.plist
launchctl load /Library/LaunchDaemons/com.plex.plexconnect.bash.plist
echo "Installation complete. Point your aTV DNS to your iOS Device and upload your cert from your iOS device to complete the process, Trailers is hijacked by default"
