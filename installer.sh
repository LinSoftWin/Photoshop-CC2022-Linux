#!/bin/bash
ALLREDIST_FILE = "./allredist.tar.xz"
ALLREDIST_MD5 = "8bfab2e4a4682d9bcf79926544053b76"
PHOTOSHOP_FILE = "./AdobePhotoshop2021.tar.xz"
PHOTOSHOP_MD5 = "cccb6715180b86e1eb8c1d7bd4a8a4e8"

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


if [ ! -f "$ALLREDIST_FILE" ]; then
	curl -L "https://drive.google.com/uc?export=download&id=1qcmyHzWerZ39OhW0y4VQ-hOy7639bJPO" > $ALLREDIST_FILE
fi

if [ ! -f "$PHOTOSHOP_FILE" ]; then
	curl -L "https://download854.mediafire.com/kj7h8gkorsvg/dhvztovo7gj738e/AdobePhotoshop2021.tar.xz" > $PHOTOSHOP_FILE
fi

if ! md5sum --status -c <(echo $ALLREDIST_MD5 $ALLREDIST_FILE); then
	echo "ERROR: md5sum of $ALLREDIST_FILE did not match! Please download the file again."
	exit 1
fi

if ! md5sum --status -c <(echo $PHOTOSHOP_MD5 $PHOTOSHOP_FILE); then
	echo "ERROR: md5sum of $PHOTOSHOP_FILE did not match! Please download the file again."
	exit 1
fi

tar -xf $ALLREDIST_FILE
tar -xf $PHOTOSHOP_FILE

WINEPREFIX=~/.WineApps/Adobe-Photoshop ./winetricks fontsmooth=rgb gdiplus msxml3 msxml6 atmlib corefonts dxvk
WINEPREFIX=~/.WineApps/Adobe-Photoshop wine allredist/redist/2010/vcredist_x64.exe /q /norestart
WINEPREFIX=~/.WineApps/Adobe-Photoshop wine allredist/redist/2010/vcredist_x86.exe /q /norestart

WINEPREFIX=~/.WineApps/Adobe-Photoshop wine allredist/redist/2012/vcredist_x86.exe /install /quiet /norestart
WINEPREFIX=~/.WineApps/Adobe-Photoshop wine allredist/redist/2012/vcredist_x64.exe /install /quiet /norestart

WINEPREFIX=~/.WineApps/Adobe-Photoshop wine allredist/redist/2013/vcredist_x86.exe /install /quiet /norestart
WINEPREFIX=~/.WineApps/Adobe-Photoshop wine allredist/redist/2013/vcredist_x64.exe /install /quiet /norestart

WINEPREFIX=~/.WineApps/Adobe-Photoshop wine allredist/redist/2019/VC_redist.x64.exe /install /quiet /norestart
WINEPREFIX=~/.WineApps/Adobe-Photoshop wine allredist/redist/2019/VC_redist.x86.exe /install /quiet /norestart

WINEPREFIX=~/.WineApps/Adobe-Photoshop sh allredist/setup_vkd3d_proton.sh install

mkdir ~/.WineApps/Adobe-Photoshop/drive_c/Program\ Files/Adobe
mv Adobe\ Photoshop\ 2021 ~/.WineApps/Adobe-Photoshop/drive_c/Program\ Files/Adobe/Adobe\ Photoshop\ 2021
mv allredist/launcher.sh ~/.WineApps/Adobe-Photoshop/drive_c
mv allredist/photoshop.png ~/.local/share/icons
mv allredist/photoshop.desktop ~/.local/share/applications

if [ $cameraraw = "1" ]
then
echo "Just follow the setup from Camera Raw."
curl -L "https://download.adobe.com/pub/adobe/photoshop/cameraraw/win/12.x/CameraRaw_12_2_1.exe" > CameraRaw_12_2_1.exe
WINEPREFIX=~/.WineApps/Adobe-Photoshop wine CameraRaw_12_2_1.exe
else
	echo ""
fi
zenity --info --text="Installation finished, Have fun with Photoshop !"
