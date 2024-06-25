# .bash_aliases
Add the following lines to the .bash_aliases file
``` bash
alias b='cd ..'

# Switches cd to cd and then ls automatically
function cd() { builtin cd "$@" && ll; }
```