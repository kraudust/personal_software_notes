# Installation
```bash
sudo apt-get install -y terminator
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

![[images/terminator_profile_preferences.png]]

