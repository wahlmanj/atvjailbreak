#!/bin/bash

## update sources & install dependencies
apt-get -y update
apt-get -y upgrade
apt-get -y install cydia
apt-get -y install python

## trash PlexConnect Folder if exists to avoid database errors
if [ -s /Applications/PlexConnect ]
then
rm -rf /Applications/PlexConnect
fi
cd /Applications

## clone desired theme
echo "Which theme would you like to install? Press 1 for iBaa or 2 for Wahlmanj"
select yn in "iBaa" "Wahlmanj"; do
    case $yn in
        iBaa ) git clone git://github.com/iBaa/PlexConnect.git; break;;
        Wahlmanj ) git clone git://github.com/Wahlmanj3/PlexConnect.git; break;;
    esac
done

## create Certs
cd /Applications/PlexConnect
openssl req -new -nodes -newkey rsa:2048 -outform pem -out ./assets/certificates/trailers.cer -keyout ./assets/certificates/trailers.key -x509 -days 3650 -subj "/C=US/CN=trailers.apple.com"
cat ./assets/certificates/trailers.cer ./assets/certificates/trailers.key >> ./assets/certificates/trailers.pem

## install requirements from atvjailbreak github
cd /Applications/atvjailbreak
if [ -f /usr/bin/python2.7 ];
then
   echo "Python already installed, skipping"
else
  wget --no-check-certificate https://github.com/linusyang/python-for-ios/releases/download/v2.7.6-3/python_2.7.6-3_iphoneos-arm.deb; dpkg -i python_2.7.6-3_iphoneos-arm.deb; rm -R python_2.7.6-3_iphoneos-arm.deb
fi
rm -R /Applications/PlexConnect/Settings.cfg
cp -R /Applications/atvjailbreak/Settings.cfg /Applications/PlexConnect

## prevent aTV updates
cp -rf hosts /

## install easy systemwide PlexConnect updates
cp update.bash /usr/bin
cp updatebash.bash /usr/bin
cp restart.bash /usr/bin
cp status.bash /usr/bin
chmod +x /usr/bin/update.bash
chmod +x /usr/bin/updatebash.bash
chmod +x /usr/bin/restart.bash
chmod +x /usr/bin/status.bash

## install autoupdate plist if desired
echo "Do you wish to install this autoupdates? Press 1 for Yes or 2 for No"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) cp com.plex.plexconnect.auto.plist /Library/LaunchDaemons; chown root /Library/LaunchDaemons/com.plex.plexconnect.auto.plist; chmod 644 /Library/LaunchDaemons/com.plex.plexconnect.auto.plist; launchctl load /Library/LaunchDaemons/com.plex.plexconnect.auto.plist; break;;
        No ) break;;
    esac
done

## install launchctl bash plist
chmod +x /Applications/PlexConnect/support/aTV_jailbreak/install.bash
/Applications/PlexConnect/support/aTV_jailbreak/install.bash

## install button
chmod +x /Applications/PlexConnect/support/aTV_jailbreak/install_button.bash
/Applications/PlexConnect/support/aTV_jailbreak/install_button.bash

## ask to reboot to load new button if needed
echo "Do you need to reboot your aTV? If this is your fist time installing PlexConnect on your aTV then press 1 to install new PlexConnect app if not press 2. Press 1 for Yes or 2 for No"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) reboot; break;;
        No ) echo "PlexConnect installed and running!"; break;;
    esac
done
