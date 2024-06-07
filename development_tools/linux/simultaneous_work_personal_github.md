# Personal github use on work machine
- Setup global git configs with work credentials.
- Edit the ~/.gitconfig file by adding the following lines:
```
[includeIf "gitdir/i:~/git/personal/"]
	path = ~/git/personal/.gitconfig-personal
```

- Make a folder in ~/git/ called personal
- Add a .gitconfig-personal to the personal folder with the following contents (after generating a personal ssh key and adding it to the personal github repo ssh keys).

```
[user]
email = dustan.kraus@gmail.com
name = Dustan Kraus

[github]
user = "kraudust"

[core]
sshCommand = "ssh -i ~/.ssh/id_ed25519_personal"
```

If you haven't generated the personal ssh key on the work machine, use the following:
```
ssh-keygen -t ed25519 -C "personal.email@gmail.com"
When prompted enter the following:
Enter file in which to save the key (/home/username/.ssh/id_ed25519): /home/username/.ssh/id_ed25519_personal
```