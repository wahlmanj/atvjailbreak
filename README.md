plexconnect-app
===============

# ios devices

SSH into your JB iOS device (install OpenSSH from the BB repo if needed) then paste this easy one liner or fire up mobile terminal on your iOS device and paste it using that instead. "APT 0.7 Strict" or higher required (a simple search in cydia will allow you to install it, required for apt-get function).

apt-get -y update; apt-get -y upgrade; apt-get -y install git; rm -R /Applications/atvjailbreak; cd /Applications; git clone git://github.com/wahlmanj/atvjailbreak.git; cd /Applications/atvjailbreak; ./installios.bash

# aTV only

apt-get -y install git; rm -R /Applications/atvjailbreak; cd /Applications; git clone git://github.com/wahlmanj/atvjailbreak.git; cd /Applications/atvjailbreak; ./installatv.bash