# Installation
```bash
sudo apt-get install -y terminator
```

If after installation, the icon doesn't show up, do the following:
```
Open Settings, => keyboard => Keyboard Shortcuts => Custom ShortCuts, and click '+' to add your new custom shortcut. Here, when the dialog appears it will include 3 sections, name, Command, and Shortcut. For example in my case, Name - "Launch Terminator", Command - "terminator", Shortcut - "Ctrl + Alt + T". After that, you should also disable the original shortcut of the default terminal, "Ctrl + Alt + T" as well.
```

# Keybindings:
Remap as noted below (~/.config/terminator/config)
```
[global_config]
[keybindings]
  go_prev = <Primary><Shift>e
  go_up = <Primary><Shift>k
  go_down = <Primary><Shift>j
  go_left = <Primary><Shift>h
  go_right = <Primary><Shift>l
  split_vert = <Primary><Shift>p
  next_tab = <Shift>Tab
[profiles]
  [[default]]
    cursor_color = "#aaaaaa"
    font = JetBrainsMono Nerd Font Mono 12
    show_titlebar = False
    use_system_font = False
[layouts]
  [[default]]
    [[[window0]]]
      type = Window
      parent = ""
    [[[child1]]]
      type = Terminal
      parent = window0
[plugins]
```

| Ctrl+Shift+T          | New tab                                     |
| --------------------- | ------------------------------------------- |
| Ctrl+Shift+O          | Split terminal horizontally                 |
| Ctrl+Shift+P          | Remap to split terminal vertically          |
| Ctrl+Shift+HJKL       | Vim style motions to move between terminals |
| Ctrl+Shift+arrow keys | Resize terminals in directions indicated    |
| Shift+Tab             | Remap to next tab                           |
# Font setup
Select font and uncheck titlebar as here, except select the mono version of JetBrainsMono: (JetBrainsMono Nerd Font Mono Regular)

- To get font go to: [nerd font](https://www.nerdfonts.com/font-downloads)
    - Download font choice from link above (JetBrains Mono is my top choice right now)
    - extract and copy font folder to /usr/share/fonts/truetype/ folder
    - Will need to select the font for whatever terminal you are using (kitty, [[terminator_setup]], etc.)

![[images/terminator_profile_preferences.png]]

