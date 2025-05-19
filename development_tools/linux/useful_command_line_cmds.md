# File cleanup
- To find biggest files taking up space: `du -h --max-depth=1 / | sort -h`

# Internet issues
Every once in a while, my ubuntu desktop has issues with connecting to the internet, but this seems to fix it
```
sudo systemctl restart NetworkManager
sudo dhclient -r
sudo dhclient
```
Other things to try if the above doesn't fix it:
```
nmcli con mod "YOUR_WIFI_PROFILE" ipv4.method auto
nmcli con mod "YOUR_WIFI_PROFILE" ipv4.ignore-auto-dns no
nmcli con mod "YOUR_WIFI_PROFILE"
sudo systemctl restart NetworkManager
sudo systemctl restart systemd-resolved
```