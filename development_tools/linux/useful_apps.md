# Xournal++
- Use this to sign pdfs
```bash
sudo apt update
sudo apt install xournalpp
```
- Open Xournal
- Select "Annotate PDF" from the File menu and select your PDF file to be signed.
- Click the "Image" button in the toolbar (it looks like a silhouette of a person).
- Click on document. A file browser dialog will open.
- Select a PNG image of your signature.
- Resize and position the image on the PDF.
- Select "Export to PDF" from the File menu.

# Bluetooth headphone issues
- Often have issues with disconnecting between A2DP and HFP profiles
    - Use pipewire instead of pusleaudio
```
sudo apt update
sudo apt install -y pipewire pipewire-audio-client-libraries libspa-0.2-bluetooth wireplumber
sudo apt install -y pipewire-pulse
systemctl --user --now enable pipewire pipewire-pulse
sudo apt install blueman
systemctl --user daemon-reexec
systemctl --user restart pipewire pipewire-pulse
```
Verify that pipewire is managing audio:
```
pactl info | grep 'Server Name'
Output should say:
Server Name: PulseAudio (on PipeWire ...)
```
Should be able to switch profiles now in ubuntu settings, but can also use blueman manager: `blueman-manager`