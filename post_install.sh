#!/bin/sh

# Fetch latest release
fetch $(curl -s https://api.github.com/repos/theotherp/nzbhydra2/releases/latest | grep browser_download_url | grep 'linux[.]zip' | cut -d '"' -f 4) -o /usr/local/

# Extract
unzip /usr/local/nzbhydra2-*-linux.zip -o -d /usr/local/nzbhydra2

#Remove
rm /usr/local/nzbhydra2-*-linux.zip

# Add user
pw user add nzbhydra2 -c nzbhydra2 -u 999 -d /nonexistent -s /usr/bin/nologin

# Change ownership
chown -R nzbhydra2:nzbhydra2 /usr/local/nzbhydra2

# Add service
cp /usr/local/nzbhydra2/rc.d/nzbhydra2 /etc/rc.d/nzbhydra2
chmod u+x /etc/rc.d/nzbhydra2

# Enable the service
sysrc -f /etc/rc.conf nzbhydra2_enable="YES"

# Start the service
service nzbhydra2 start 2>/dev/null
