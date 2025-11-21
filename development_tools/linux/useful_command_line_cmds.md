# File cleanup
To find biggest files taking up space: 
```bash
df -h
sudo du -h --max-depth=1 / | sort -hr | head -n 20
Running this lists like so:
[04:03 PM]~ $ df -h
Filesystem                 Size  Used Avail Use% Mounted on
tmpfs                      3.2G  3.2M  3.1G   1% /run
/dev/mapper/vgubuntu-root  914G  819G   50G  95% /
tmpfs                       16G  520M   16G   4% /dev/shm
tmpfs                      5.0M  4.0K  5.0M   1% /run/lock
efivarfs                   438K  241K  193K  56% /sys/firmware/efi/efivars
/dev/nvme0n1p2             1.7G  306M  1.3G  20% /boot
/dev/nvme0n1p1             511M   58M  454M  12% /boot/efi
tmpfs                      3.2G  240K  3.2G   1% /run/user/1001
/dev/sda                    16M   84K   16M   1% /media/dustan-kraus/L4T-README
[04:04 PM]~ $ sudo du -h --max-depth=1 / | sort -hr | head -n 20
[sudo] password for dustan-kraus: 
du: cannot access '/run/user/1001/gvfs': Permission denied
du: cannot access '/run/user/1001/doc': Permission denied
du: cannot access '/proc/1883747/task/1883747/fd/4': No such file or directory
du: cannot access '/proc/1883747/task/1883747/fdinfo/4': No such file or directory
du: cannot access '/proc/1883747/fd/3': No such file or directory
du: cannot access '/proc/1883747/fdinfo/3': No such file or directory
du: cannot access '/proc/1884880': No such file or directory
829G	/
404G	/home
362G	/var
16G	/usr
11G	/snap
5.2G	/opt
363M	/boot
136M	/tmp
22M	/etc
9.5M	/dev
8.6M	/root
3.4M	/run
112K	/media
16K	/lost+found
16K	/data
12K	/.local
8.0K	/mnt
4.0K	/srv
4.0K	/cdrom
0	/sys
```
Then drill down like so, inspect /var:
```bash
sudo du -h --max-depth=1 /var | sort -hr | head -n 20
sudo du -h --max-depth=1 /var/lib | sort -hr | head -n 20
Shows the following:
[04:07 PM]~ $ sudo du -h --max-depth=1 /var/lib | sort -hr | head -n 20
353G	/var/lib
347G	/var/lib/docker
5.9G	/var/lib/snapd
344M	/var/lib/apt
80M	/var/lib/dpkg
22M	/var/lib/swcatalog
5.1M	/var/lib/microsoft-identity-device-broker
4.1M	/var/lib/aspell
3.5M	/var/lib/command-not-found
3.2M	/var/lib/ubuntu-advantage
3.2M	/var/lib/gdm3
784K	/var/lib/systemd
704K	/var/lib/usbutils
396K	/var/lib/containerd
388K	/var/lib/fwupd
340K	/var/lib/bluetooth
176K	/var/lib/NetworkManager
152K	/var/lib/forticlient
144K	/var/lib/ucf
124K	/var/lib/binfmts
```
Clean up docker:
```bash
sudo docker system prune -f
sudo docker builder prune -a -f
```


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