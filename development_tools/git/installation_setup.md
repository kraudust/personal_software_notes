# Installation
```bash
sudo apt install git
sudo apt update
sudo apt install git-lfs
git lfs install
```

If getting lfs issues, do this:
```bash
sudo apt remove git-lfs
sudo snap install curl
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
sudo apt install git-lfs=3.5.1
git-lfs version (to verify successful udpate)
```

# SSH Work Keys Setup
```bash
ssh-keygen -t ed25519 -C "company_email@company_domain"
```
- Copy contents of id_ed25519.pub into ssh keys section in gitlab or github and select authentication

# GPG Keys
- gpg --full-gen-key (select RSA and RSA, accept default size 3072, select 0 key does not expire, enter name, and email address and do not need a password, just click okay)
- To list your private GPG key, run this command, replacing `<EMAIL>` with the email address you used when you generated the key: `gpg --list-secret-keys --keyid-format LONG dustan.kraus1@oksi.ai`
- In the output, identify the sec line, and copy the GPG key ID. It begins after the / character. In this example, the key ID is 30F2B65B9246B6CA:
    - sec   rsa4096/30F2B65B9246B6CA 2017-08-18 [SC]
- To show the associated public key, run this command, replacing `<ID>` with the GPG key ID from the previous step: `gpg --armor --export <ID>`, copy this key and use it in the next step
## Add your gpg key to gitlab
- Sign into gitlab
- On the left sidebar select your avatar
- Select edit profile
- Select gpg keys
- Select add new key
- Paste your public key and select add key
## Associate your gpg key with git
- Run this command to list the private GPG key you just created: `gpg --list-secret-keys --keyid-format LONG company_email@company_domain`
- Copy the private key id that starts with sec. In this example the private key id is 30F2B65B9246B6CA (sec   rsa4096/30F2B65B9246B6CA 2017-08-18)
- Run this command to configure git to sing your commits with your key replacing `<KEY ID>` with your GPG key ID
    - `git config --global user.signingkey <KEY ID>`
    - `git config --global commit.gpgsign true`
