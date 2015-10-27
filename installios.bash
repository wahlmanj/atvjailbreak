#!/bin/bash

## update sources & install dependencies
apt-get -y update
apt-get -y upgrade
apt-get -y install cydia
apt-get -y install wget
apt-get -y install adv-cmds
# adv-cmds is a alternative for ps for status.bash

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
echo "Which certs would you like to generate? Press 1 for Trailers or 2 for iMovie"
select yn in "Trailers" "iMovie"; do
    case $yn in
        Trailers ) openssl req -new -nodes -newkey rsa:2048 -outform pem -out ./assets/certificates/trailers.cer -keyout ./assets/certificates/trailers.key -x509 -days 3650 -subj "/C=US/CN=trailers.apple.com"
cat ./assets/certificates/trailers.cer ./assets/certificates/trailers.key >> ./assets/certificates/trailers.pem; break;;
        iMovie ) openssl req -new -nodes -newkey rsa:2048 -outform pem -out ./assets/certificates/trailers.cer -keyout ./assets/certificates/trailers.key -x509 -days 3650 -subj "/C=US/CN=www.icloud.com"
cat ./assets/certificates/trailers.cer ./assets/certificates/trailers.key >> ./assets/certificates/trailers.pem; break;;
    esac
done


## use python env for iOS support in PlexConect.py
cd /Applications/atvjailbreak
cp PlexConnect.py /Applications/PlexConnect
cp PlexConnect.bash /Applications/PlexConnect/support/aTV_jailbreak
if [ -f /usr/bin/python2.7 ];
then
   echo "Python already installed, skipping"
else
  wget --no-check-certificate https://yangapp.googlecode.com/files/python_2.7.3-3_iphoneos-arm.deb; dpkg -i python_2.7.3-3_iphoneos-arm.deb; rm -R python_2.7.3-3_iphoneos-arm.deb
fi

## install easy systemwide PlexConnect scripts
cp update.bash /usr/bin
cp updatebash.bash /usr/bin
cp restart.bash /usr/bin
cp status.bash /usr/bin
chmod +x /usr/bin/update.bash
chmod +x /usr/bin/updatebash.bash
chmod +x /usr/bin/restart.bash
chmod +x /usr/bin/status.bash

## install autoupdate plist if desired
echo "Do you wish to install this PlexConnect autoupdates? Press 1 for Yes or 2 for No"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) cp com.plex.plexconnect.auto.plist /Library/LaunchDaemons; chown root /Library/LaunchDaemons/com.plex.plexconnect.auto.plist; chmod 644 /Library/LaunchDaemons/com.plex.plexconnect.auto.plist; launchctl load /Library/LaunchDaemons/com.plex.plexconnect.auto.plist; break;;
        No ) break;;
    esac
done

## install launchctl bash plist
chmod +x /Applications/PlexConnect/support/aTV_jailbreak/install.bash
/Applications/PlexConnect/support/aTV_jailbreak/install.bash
sleep 3
cp /Applications/atvjailbreak/com.plex.plexconnect.bash.plist /Library/LaunchDaemons
launchctl unload /Library/LaunchDaemons/com.plex.plexconnect.bash.plist
launchctl load /Library/LaunchDaemons/com.plex.plexconnect.bash.plist
cd /Applications/PlexConnect
echo "Which app would you like to hijack? Press 1 for Trailers or 2 for iMovie"
select yn in "Trailers" "iMovie"; do
    case $yn in
        Trailers ) sed -i 's/www.icloud.com/trailers.apple.com/g' Settings.cfg; break;;
        iMovie ) sed -i 's/trailers.apple.com/www.icloud.com/g' Settings.cfg; break;;
    esac
done
restart.bash
echo "Installation complete. Point your aTV DNS to your iOS Device and upload your cert from your iOS device to complete the process"
