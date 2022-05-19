#!/bin/bash
export WINEPREFIX=~/.WineApps/Adobe-Photoshop
echo "Welcome to Photoshop installer"
echo "Would you like to install Camera Raw with photoshop? (This will prompt the camera raw installer at the end)"
echo "1 - Yes, 0 - No"
cameraraw=1
read cameraraw

mkdir ~/.WineApps
mkdir ~/.WineApps/Adobe-Photoshop

wget  https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
chmod +x winetricks

wineboot

./winetricks win10

curl -L "https://drive.google.com/uc?export=download&id=1qcmyHzWerZ39OhW0y4VQ-hOy7639bJPO" > allredist.tar.xz
mkdir allredist
tar -xf allredist.tar.xz
rm -rf allredist.tar.xz
curl -L "https://lulucloud.mywire.org/FileHosting/GithubProjects/AdobePhotoshop2021.tar.xz" > AdobePhotoshop2021.tar.xz
tar -xf AdobePhotoshop2021.tar.xz
rm -rf AdobePhotoshop2021.tar.xz


./winetricks fontsmooth=rgb gdiplus msxml3 msxml6 atmlib corefonts dxvk
wine allredist/redist/2010/vcredist_x64.exe /q /norestart
wine allredist/redist/2010/vcredist_x86.exe /q /norestart

wine allredist/redist/2012/vcredist_x86.exe /install /quiet /norestart
wine allredist/redist/2012/vcredist_x64.exe /install /quiet /norestart

wine allredist/redist/2013/vcredist_x86.exe /install /quiet /norestart
wine allredist/redist/2013/vcredist_x64.exe /install /quiet /norestart

wine allredist/redist/2019/VC_redist.x64.exe /install /quiet /norestart
wine allredist/redist/2019/VC_redist.x86.exe /install /quiet /norestart

sh allredist/setup_vkd3d_proton.sh install
mkdir ~/.WineApps/Adobe-Photoshop/drive_c/Program\ Files/Adobe
mv Adobe\ Photoshop\ 2021 ~/.WineApps/Adobe-Photoshop/drive_c/Program\ Files/Adobe/Adobe\ Photoshop\ 2021
mv allredist/launcher.sh ~/.WineApps/Adobe-Photoshop/drive_c
mv allredist/photoshop.png ~/.local/share/icons
mv allredist/photoshop.desktop ~/.local/share/applications

rm -rf allredist
rm -rf winetricks
if [ $cameraraw = "1" ]
then
echo "Just follow the setup from Camera Raw..."
curl -L "https://download.adobe.com/pub/adobe/photoshop/cameraraw/win/12.x/CameraRaw_12_2_1.exe" > CameraRaw_12_2_1.exe
wine CameraRaw_12_2_1.exe
rm -rf CameraRaw_12_2_1.exe
else
	echo ""
fi

zenity --info --text="Installation finished, Have fun with Photoshop!"
