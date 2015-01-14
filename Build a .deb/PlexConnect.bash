#!/bin/bash
 
#Package
APPNAME="PlexConnecy.py"
#
# OSX PlexConnect startup script
#

# Run in a loop until successfully connected to the internet
until wget -q -O - http://www.google.com | grep Lucky > /dev/null; do
sleep 10
done
exec $1&

# Start PlexConnect
./${APPNAME}
