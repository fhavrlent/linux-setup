# Linux distro setup scripts

## Manjaro XFCE

```bash
bash -c "`curl -L https://raw.githubusercontent.com/fhavrlent/linux-setup/main/manjaro-xfce.sh`"
```

1. Edit `/etc/lightdm/lightdm.conf`

```
greeter-session=lightdm-webkit2-greeter
display-setup-script=xrandr --output DP-0 --primary
greeter-setup-script=/usr/bin/numlockx on
```
2. Set `Nordic` Theme (Appearance and Windows Manager)
3. Set `Flatery Blue Dark` icons
4. Set Window button layout
   ![Window manager](assets/buttonLayout.jpg)
5. Set `Roboto Regular` as Default font and `Roboto Mono Light` as Default Monospace font
6. Windows Manager Tweaks -> Untick Show shadows under dock windows
7. Add Plank, ULauncher, Discord into startup
8. Set VPN client to start at startup
9.  Set `mcOS-BS-iMacM1-DarkBlue` in Plank
10. Set `Nord` theme in Tilix
11. Set Tilix -> Quake -> Hide toolbar
12. Keyboard settings -> Shortcuts -> F12 `tilix --quake`
13. Turn on Firefall
14. Sync VS Code setting
15. Add en-US keyboard
16. Set Whisker menu
    
    ![Whisker 1](assets/whisker1.png)![Whisker 2](assets/whisker2.png)![Whisker 3](assets/whisker3.png)
17. Update kernel and language packages

## Manjaro KDE

```bash
bash -c "`curl -L https://raw.githubusercontent.com/fhavrlent/linux-setup/main/manjaro-kde.sh`"
```

## Linux Mint

```bash
bash -c "`curl -L https://raw.githubusercontent.com/fhavrlent/linux-setup/main/mint.sh`"
```

1. Add English (US) keyboard layout
2. Change theme
   1. Mint-Y-Dark
   2. Mint-Y-Dark
   3. Mint-Y-Dark
   4. DMZ-White
   5. Mint-Y-Dark
