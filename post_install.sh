#!/bin/sh

# Fetch latest release
echo "fetching"
fetch $(curl -s https://api.github.com/repos/theotherp/nzbhydra2/releases/latest | grep browser_download_url | grep 'linux[.]zip' | cut -d '"' -f 4) -o /usr/local/

# Extract
echo "unzipping"
unzip /usr/local/nzbhydra2-*-linux.zip -o -d /usr/local/nzbhydra2

#Remove
echo "removing"
rm /usr/local/nzbhydra2-*-linux.zip

# Add user
echo "add user"
pw user add nzbhydra2 -c nzbhydra2 -u 999 -d /nonexistent -s /usr/bin/nologin

# Change ownership
echo "change owner"
chown -R nzbhydra2:nzbhydra2 /usr/local/nzbhydra2

# Add service
echo "copy for service"
cp /usr/local/nzbhydra2/rc.d/nzbhydra2 /etc/rc.d/nzbhydra2

echo "chmod for service"
chmod u+x /etc/rc.d/nzbhydra2

# Enable the service
echo "enable nzbhydra2 service"
sysrc -f /etc/rc.conf nzbhydra2_enable="YES"

# Start the service
echo "start nzbhydra2 service"
service nzbhydra2 start 2>/dev/null
