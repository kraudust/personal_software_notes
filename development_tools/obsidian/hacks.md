Problem: obsidan opens links in firefox despite chrome being the default browser in Ubuntu 22

Solution:
If xdg-open works fine from console, but obsidan still opens wrong browser, and you are using snap, you can use the following hack to fix it:

Create a xdg-open file somewhere in your path (can find path using echo $PATH) with the following contents:
```
#!/bin/bash

# fix for obsidian opening URLs in wrong browser
if [[ $SNAP_INSTANCE_NAME == "obsidian" && $1 =~ ^(https?://) ]]; then
        unset XDG_DATA_HOME
        unset XDG_CONFIG_HOME
fi

exec /usr/bin/xdg-open "$@"
```
Save the script and make it executable with `chmod +x`