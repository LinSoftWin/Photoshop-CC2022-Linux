#!/bin/bash

mkdir ~/.WineApps
mkdir ~/.WineApps/Adobe-Photoshop

curl -L "https://github.com/Kron4ek/Wine-Builds/releases/download/6.19/wine-6.19-amd64.tar.xz" > wine-6.19-amd64.tar.xz

tar -xf wine-6.19-amd64.tar.xz
rm -rf wine-6.19-amd64.tar.xz
mv wine-6.19-amd64 ~/.WineApps/Adobe-Photoshop/

zenity --info --text="Please set the windows version to Windows 10 then Apply and OK"

WINEPREFIX=~/.WineApps/Adobe-Photoshop ~/.WineApps/Adobe-Photoshop/wine-6.19-amd64/bin/winecfg

curl -L "https://drive.google.com/uc?export=download&id=1cmIinNu3AnQw2SeVi1yGFQvPREOR6toz" > allredist.tar.xz
tar -xf allredist.tar.xz
rm -rf allredist.tar.xz
wget  https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
chmod +x winetricks
curl -L "https://www.dropbox.com/s/v9u4g00iy1crl8z/AdobePhotoshop2021.tar.xz?dl=1" > AdobePhotoshop2021.tar.xz
tar -xf AdobePhotoshop2021.tar.xz
rm -rf AdobePhotoshop2021.tar.xz

curl -L "https://drive.google.com/uc?export=download&id=1774Mc8HrEbY_fnX7CaYpZRX11KLa3jNA" > prefs.tar.xz
curl -L "https://drive.google.com/uc?export=download&id=1o9ShXelsabZiiC9XvikpAS0Y8SuEZb1O" > camerarawprefs.tar.xz

curl -L "https://download.adobe.com/pub/adobe/photoshop/cameraraw/win/12.x/CameraRaw_12_2_1.exe" > CameraRaw_12_2_1.exe

WINEPREFIX=~/.WineApps/Adobe-Photoshop ./winetricks fontsmooth=rgb gdiplus msxml3 msxml6 atmlib corefonts dxvk
WINEPREFIX=~/.WineApps/Adobe-Photoshop ~/.WineApps/Adobe-Photoshop/wine-6.19-amd64/bin/wine redist/2010/vcredist_x64.exe /q /norestart
WINEPREFIX=~/.WineApps/Adobe-Photoshop ~/.WineApps/Adobe-Photoshop/wine-6.19-amd64/bin/wine redist/2010/vcredist_x86.exe /q /norestart

WINEPREFIX=~/.WineApps/Adobe-Photoshop ~/.WineApps/Adobe-Photoshop/wine-6.19-amd64/bin/wine redist/2012/vcredist_x86.exe /install /quiet /norestart
WINEPREFIX=~/.WineApps/Adobe-Photoshop ~/.WineApps/Adobe-Photoshop/wine-6.19-amd64/bin/wine redist/2012/vcredist_x64.exe /install /quiet /norestart

WINEPREFIX=~/.WineApps/Adobe-Photoshop ~/.WineApps/Adobe-Photoshop/wine-6.19-amd64/bin/wine redist/2013/vcredist_x86.exe /install /quiet /norestart
WINEPREFIX=~/.WineApps/Adobe-Photoshop ~/.WineApps/Adobe-Photoshop/wine-6.19-amd64/bin/wine redist/2013/vcredist_x64.exe /install /quiet /norestart

WINEPREFIX=~/.WineApps/Adobe-Photoshop ~/.WineApps/Adobe-Photoshop/wine-6.19-amd64/bin/wine redist/2019/VC_redist.x64.exe /install /quiet /norestart
WINEPREFIX=~/.WineApps/Adobe-Photoshop ~/.WineApps/Adobe-Photoshop/wine-6.19-amd64/bin/wine redist/2019/VC_redist.x86.exe /install /quiet /norestart

WINEPREFIX=~/.WineApps/Adobe-Photoshop sh setup_vkd3d_proton.sh install
mkdir ~/.WineApps/Adobe-Photoshop/drive_c/Program\ Files/Adobe
mv Adobe\ Photoshop\ 2021 ~/.WineApps/Adobe-Photoshop/drive_c/Program\ Files/Adobe/Adobe\ Photoshop\ 2021
mv launcher.sh ~/.WineApps/Adobe-Photoshop/drive_c
mv photoshop.png ~/.local/share/icons
mv photoshop.desktop ~/.local/share/applications

WINEPREFIX=~/.WineApps/Adobe-Photoshop ~/.WineApps/Adobe-Photoshop/wine-6.19-amd64/bin/wine CameraRaw_12_2_1.exe /q /norestart

rm -rf ~/.WineApps/Adobe-Photoshop/drive_c/users/mimillie/AppData/Roaming/Adobe
rm -rf ~/.WineApps/Adobe-Photoshop/drive_c/ProgramData/Adobe

user=$(whoami)
tar -xf prefs.tar.xz --directory ~/.WineApps/Adobe-Photoshop/drive_c/users/${user}/AppData/Roaming/
tar -xf camerarawprefs.tar.xz --directory ~/.WineApps/Adobe-Photoshop/drive_c/ProgramData/

rm -rf redist
rm -rf winetricks
rm -rf winetricks.1
rm -rf x86
rm -rf x64
rm -rf setup_vkd3d_proton.sh
rm -rf *.psp
rm -rf Prefs
rm -rf CameraRaw_12_2_1.exe
rm -rf prefs.tar.xz
rm -rf camerarawprefs.tar.xz
zenity --info --text="Installation finished, Have fun with Photoshop !"
