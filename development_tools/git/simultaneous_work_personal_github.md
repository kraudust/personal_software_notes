# Personal github use on work machine
- Setup ssh key for work account
- Then setup global git configs with work credentials using the following:
```
git config --global user.name "User Name"
git config --global user.email "user.email@company.com"
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=3600'
```

- Edit the ~/.gitconfig file by adding the following lines:
```
[includeIf "gitdir/i:~/git/personal/"]
	path = ~/git/personal/.gitconfig-personal
```

- Make a folder in ~/git/ called `personal`
- Add a `.gitconfig-personal` file to the `personal` folder with the following contents (after generating a personal ssh key and adding it to the personal github repo ssh keys).

```
[user]
email = user.name@personalemail.com
name = User Name

[github]
user = "github_username"

[core]
sshCommand = "ssh -i ~/.ssh/id_ed25519_personal"
```

If you haven't generated the personal ssh key on the work machine, use the following:
```
ssh-keygen -t ed25519 -C "user.name@personalemail.com"
When prompted enter the following:
Enter file in which to save the key (/home/username/.ssh/id_ed25519): /home/username/.ssh/id_ed25519_personal
```

# Example config files:
.gitconfig
```bash
[user]  
    name = Dustan Kraus  
[credential]  
    helper = cache --timeout=3600  
[includeIf "gitdir/i:~/git/personal/"]  
    path = ~/git/personal/.gitconfig-personal  
[includeIf "gitdir/i:~/.config/nvim/"]  
    path = ~/git/personal/.gitconfig-personal  
[includeIf "gitdir/i:~/git/gitlab/"]  
    path = ~/.gitconfig-gitlab  
[filter "lfs"]  
  process = git-lfs filter-process  
  required = true  
  clean = git-lfs clean -- %f  
  smudge = git-lfs smudge -- %f
```

.gitconfig-personal
```bash
[user]
email = user.name@personalemail.com
name = Dustan Kraus

[github]
user = "kraudust"

[core]
sshCommand = "ssh -i ~/.ssh/id_ed25519_personal"
```

.gitconfig-gitlab
```bash
[user]  
    email = workemail@workemail.com
    signingkey = KEY HERE  
[commit]  
    gpgsign = true
```