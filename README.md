# reboot_ubiquiti.sh

Script which reboots Ubiquiti devices in you LAN network.

<p><ol>
<li>Logging via keys is highly recommended.</li>
You can authorise machine running this script (e.g. NAS server in LAN) to logging via SSH and keys to
every Ubiquiti device. Just open Cloud Key and go to Settings > Site > Device Authentication and add
your machine's ~/.ssh/id_dsa.pub key (home dir of user which will be running this script). Also be sure
to previously, manually log into all devices to write them to known_hosts.
<li>Run it e.g. via cron.</li>
</p>
