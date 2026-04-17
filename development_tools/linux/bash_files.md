# .bash_aliases
Add the following lines to the .bash_aliases file
``` bash
alias b='cd ..'  
  
# Switches cd to cd and then ls automatically  
function cd() { builtin cd "$@" && ll -lh; }  
  
# ROS2 Aliases  
alias sr2='source /opt/ros/humble/setup.bash'  
alias cb='colcon build --symlink-install'  
alias cbps='colcon build --symlink-install --packages-select '  
alias ct='colcon test '  
alias sws='. install/setup.bash' # source workspace  
  
# Docker Aliases  
alias dock='docker exec -it omniscience bash'  
   
# Vector Aliases  
alias sknd='ssh [root@10.41.1.1](mailto:root@10.41.1.1)'  
alias aind='ssh -p 2222 [root@10.41.1.1](mailto:root@10.41.1.1)'  
   
# S Drive  
# alias mnts='sudo mount -t cifs //[192.168.10.7/SDrive](http://192.168.10.7/SDrive) ~/Documents/SDrive -o username="dustan.kraus1",domain=[OKSI-HQ.oksi.ai](http://oksi-hq.oksi.ai/),iocharset=utf8'  
# alias mnts='sudo mount -t cifs //[192.168.10.7/SDrive](http://192.168.10.7/SDrive) ~/Documents/SDrive -o username="dustan.kraus1",domain=[OKSI-HQ.oksi.ai](http://oksi-hq.oksi.ai/),iocharset=utf8,uid=$(id -u),gid=$(id -g),file_mode=0660,dir_mode=0770'  
# alias mnts='sudo mount -t cifs //[10.10.60.3/SDrive](http://10.10.60.3/SDrive) ~/Documents/SDrive -o username=dustan.kraus1,domain=OKSI-HQ,iocharset=utf8,vers=3.0,sec=ntlmssp,uid=$(id -u),gid=$(id -g),file_mode=0664,dir_mode=0775'  
alias mnts='sudo mount -t cifs //[SDrive.oksi.ai/SDrive](http://sdrive.oksi.ai/SDrive) ~/Documents/SDrive -o username=dustan.kraus1,domain=OKSI-HQ,iocharset=utf8,vers=3.0,sec=ntlmssp'  
  
# Check storage  
alias mystorage="df -h | grep -E '/$|/media/dustan-kraus/dustan_linux_ssd'"  
  
# SSH to jetson  
# alias jetson="ssh [jetson@192.168.55.1](mailto:jetson@192.168.55.1)"  
# alias jetson="ssh [jetson@192.168.89.200](mailto:jetson@192.168.89.200)"  
alias jetson="ssh [jetson@192.168.55.2](mailto:jetson@192.168.55.2)" # ethernet
```

# .bashrc
Add the following to the .bashrc file:
``` bash
# Git
# Show what git or hg branch we are in
function parse_vc_branch_and_add_brackets {
    gitbranch=`git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\ \[\1\]/'`
    if [[ "$gitbranch" != '' ]]; then
	echo $gitbranch
    else
	hg branch 2> /dev/null | awk '{print $1 }'
    fi
}

# Set terminal prompt
if [ -n "$SSH_CLIENT" ]; then  
export PS1="\[\033[1;33m\][\u]\[\033[0m\]\[\033[0;34m\]\$(parse_vc_branch_and_add_brackets)\[\033[0m\]\[\033[1;32m\]\W $ \[\033[0m\]"  
else  
export PS1="\[\033[0;34m\]\$(parse_vc_branch_and_add_brackets)\[\033[0m\]\[\033[1;32m\]\W $ \[\033[0m\]"  
fi
```

ls -larth