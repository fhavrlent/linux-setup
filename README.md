# Manjaro XFCE setup 🚀

Script to quicly setup new install of Manjaro Linux XFCE version. Personalised for my needs and files, but easy to customize for your needs ✨.

### Setup script and steps 🚛

1. Install pswd manager to get passwords to use later
2.  Run the script, `source .zshrc` after done
```bash
bash -c "`curl -L https://raw.githubusercontent.com/fhavrlent/manjaro-xfce-setup/main/manjaro-xfce.sh`"
```
3. Edit `/etc/lightdm/lightdm.conf`
```
greeter-session=lightdm-webkit2-greeter
display-setup-script=xrandr --output DP-0 --primary
greeter-setup-script=/usr/bin/numlockx on
```
4. Add Plank, ULauncher, Discord into startup
5. Set VPN client to start at startup
6.  Set `mcOS-BS-iMacM1-DarkBlue` in Plank
7.  Set `Nord` theme in Tilix
8.  Set Tilix -> Quake -> Hide toolbar
9.  Keyboard settings -> Shortcuts -> F12 `tilix --quake`
10.   Turn on Firefall
11.   Sync VS Code setting
12.   Add en-US keyboard
13. Set Whisker menu
    
    ![Whisker 1](assets/whisker1.png)![Whisker 2](assets/whisker2.png)![Whisker 3](assets/whisker3.png)
14. Update kernel and language packages
15. Reboot and hope for the best 
