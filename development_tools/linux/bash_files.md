# .bash_aliases
Add the following lines to the .bash_aliases file
``` bash
alias b='cd ..'

# Switches cd to cd and then ls automatically
function cd() { builtin cd "$@" && ll; }

# ROS2 Aliases
alias cb='colcon build --symlink-install'
alias cbps='colcon build --symlink-install --packages-select '
alias ct='colcon test '
alias sws='. install/setup.bash' # source workspace
```

# .bashrc
Add the following to the .bashrc file:
``` bash
#!/usr/bin/env bash

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
    export PS1="\[\033[1;33m\][\u]\[\033[0m\]\[\033[1;30m\][\@]\[\033[0m\]\[\033[0;34m\]\$(parse_vc_branch_and_add_brackets)\[\033[0m\]\[\033[1;32m\]\W $ \[\033[0m\]"
else
    export PS1="\[\033[1;30m\][\@]\[\033[0m\]\[\033[0;34m\]\$(parse_vc_branch_and_add_brackets)\[\033[0m\]\[\033[1;32m\]\W $ \[\033[0m\]"
fi
```