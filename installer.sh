#!/bin/bash
echo "Welcome to Photoshop installer"
echo "Would you like to install Camera Raw with photoshop ? (This will prompt the camera raw installer at the end)"
echo "1 = yes 0 = no"
cameraraw=1
read cameraraw

mkdir -p ~/.WineApps/Adobe-Photoshop

curl -L https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks > winetricks
chmod +x winetricks

WINEPREFIX=~/.WineApps/Adobe-Photoshop wineboot

WINEPREFIX=~/.WineApps/Adobe-Photoshop ./winetricks win10

curl -L "https://drive.google.com/uc?export=download&id=1qcmyHzWerZ39OhW0y4VQ-hOy7639bJPO" > allredist.tar.xz
tar -xf allredist.tar.xz
rm -rf allredist.tar.xz
curl -L "https://download854.mediafire.com/kj7h8gkorsvg/dhvztovo7gj738e/AdobePhotoshop2021.tar.xz" > AdobePhotoshop2021.tar.xz
tar -xf AdobePhotoshop2021.tar.xz
rm -rf AdobePhotoshop2021.tar.xz


WINEPREFIX=~/.WineApps/Adobe-Photoshop ./winetricks fontsmooth=rgb gdiplus msxml3 msxml6 atmlib corefonts dxvk
WINEPREFIX=~/.WineApps/Adobe-Photoshop wine redist/2010/vcredist_x64.exe /q /norestart
WINEPREFIX=~/.WineApps/Adobe-Photoshop wine redist/2010/vcredist_x86.exe /q /norestart

WINEPREFIX=~/.WineApps/Adobe-Photoshop wine redist/2012/vcredist_x86.exe /install /quiet /norestart
WINEPREFIX=~/.WineApps/Adobe-Photoshop wine redist/2012/vcredist_x64.exe /install /quiet /norestart

WINEPREFIX=~/.WineApps/Adobe-Photoshop wine redist/2013/vcredist_x86.exe /install /quiet /norestart
WINEPREFIX=~/.WineApps/Adobe-Photoshop wine redist/2013/vcredist_x64.exe /install /quiet /norestart

WINEPREFIX=~/.WineApps/Adobe-Photoshop wine redist/2019/VC_redist.x64.exe /install /quiet /norestart
WINEPREFIX=~/.WineApps/Adobe-Photoshop wine redist/2019/VC_redist.x86.exe /install /quiet /norestart

WINEPREFIX=~/.WineApps/Adobe-Photoshop sh setup_vkd3d_proton.sh install
mkdir ~/.WineApps/Adobe-Photoshop/drive_c/Program\ Files/Adobe
mv Adobe\ Photoshop\ 2021 ~/.WineApps/Adobe-Photoshop/drive_c/Program\ Files/Adobe/Adobe\ Photoshop\ 2021
mv launcher.sh ~/.WineApps/Adobe-Photoshop/drive_c
mv photoshop.png ~/.local/share/icons
mv photoshop.desktop ~/.local/share/applications

rm -rf redist
rm -rf winetricks
rm -rf winetricks.1
rm -rf x86
rm -rf x64
rm -rf setup_vkd3d_proton.sh
if [ $cameraraw = "1" ]
then
echo "Just follow the setup from Camera Raw."
curl -L "https://download.adobe.com/pub/adobe/photoshop/cameraraw/win/12.x/CameraRaw_12_2_1.exe" > CameraRaw_12_2_1.exe
WINEPREFIX=~/.WineApps/Adobe-Photoshop wine CameraRaw_12_2_1.exe
rm -rf CameraRaw_12_2_1.exe
else
	echo ""
fi
zenity --info --text="Installation finished, Have fun with Photoshop !"
