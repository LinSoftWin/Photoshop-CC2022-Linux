
mkdir $1/Adobe-Photoshop

wget  https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
chmod +x winetricks

WINEPREFIX=$1/Adobe-Photoshop wineboot

rm -rf $1/progress.mimifile
touch $1/progress.mimifile
echo "10" >> $1/progress.mimifile

WINEPREFIX=$1/Adobe-Photoshop ./winetricks win10

curl -L "https://lulucloud.mywire.org/FileHosting/GithubProjects/PS2022/allredist.tar.xz" > allredist.tar.xz
mkdir allredist

rm -rf $1/progress.mimifile
touch $1/progress.mimifile
echo "20" >> $1/progress.mimifile

tar -xf allredist.tar.xz
rm -rf allredist.tar.xz

rm -rf $1/progress.mimifile
touch $1/progress.mimifile
echo "25" >> $1/progress.mimifile

curl -L "https://lulucloud.mywire.org/FileHosting/GithubProjects/PS2022/AdobePhotoshop2022.tar.xz" > AdobePhotoshop2022.tar.xz

curl -L "https://lulucloud.mywire.org/FileHosting/GithubProjects/PS2022/Adobe.tar.xz" > Adobe.tar.xz
tar -xf Adobe.tar.xz
mv Adobe $1/Adobe-Photoshop/drive_c/Program\ Files\ \(x86\)/Common\ Files
rm -rf Adobe.tar.xz
rm -rf Adobe

rm -rf $1/progress.mimifile
touch $1/progress.mimifile
echo "50" >> $1/progress.mimifile

tar -xf AdobePhotoshop2022.tar.xz
rm -rf AdobePhotoshop2022.tar.xz


rm -rf $1/progress.mimifile
touch $1/progress.mimifile
echo "70" >> $1/progress.mimifile


WINEPREFIX=$1/Adobe-Photoshop ./winetricks fontsmooth=rgb gdiplus msxml3 msxml6 atmlib corefonts dxvk win10

rm -rf $1/progress.mimifile
touch $1/progress.mimifile
echo "80" >> $1/progress.mimifile


WINEPREFIX=$1/Adobe-Photoshop wine allredist/redist/2010/vcredist_x64.exe /q /norestart
WINEPREFIX=$1/Adobe-Photoshop wine allredist/redist/2010/vcredist_x86.exe /q /norestart

WINEPREFIX=$1/Adobe-Photoshop wine allredist/redist/2012/vcredist_x86.exe /install /quiet /norestart
WINEPREFIX=$1/Adobe-Photoshop wine allredist/redist/2012/vcredist_x64.exe /install /quiet /norestart

WINEPREFIX=$1/Adobe-Photoshop wine allredist/redist/2013/vcredist_x86.exe /install /quiet /norestart
WINEPREFIX=$1/Adobe-Photoshop wine allredist/redist/2013/vcredist_x64.exe /install /quiet /norestart

WINEPREFIX=$1/Adobe-Photoshop wine allredist/redist/2019/VC_redist.x64.exe /install /quiet /norestart
WINEPREFIX=$1/Adobe-Photoshop wine allredist/redist/2019/VC_redist.x86.exe /install /quiet /norestart


rm -rf $1/progress.mimifile
touch $1/progress.mimifile
echo "90" >> $1/progress.mimifile

mkdir $1/Adobe-Photoshop/drive_c/Program\ Files/Adobe
mv Adobe\ Photoshop\ 2022 $1/Adobe-Photoshop/drive_c/Program\ Files/Adobe/Adobe\ Photoshop\ 2022

touch $1/Adobe-Photoshop/drive_c/launcher.sh
echo '#!/usr/bin/env bash' >> $1/Adobe-Photoshop/drive_c/launcher.sh
echo 'SCR_PATH="pspath"' >> $1/Adobe-Photoshop/drive_c/launcher.sh
echo 'CACHE_PATH="pscache"' >> $1/Adobe-Photoshop/drive_c/launcher.sh
echo 'RESOURCES_PATH="$SCR_PATH/resources"' >> $1/Adobe-Photoshop/drive_c/launcher.sh
echo 'WINE_PREFIX="$SCR_PATH/prefix"' >> $1/Adobe-Photoshop/drive_c/launcher.sh
echo 'FILE_PATH=$(winepath -w "$1")' >> $1/Adobe-Photoshop/drive_c/launcher.sh
echo 'export WINEPREFIX="'$1'/Adobe-Photoshop"' >> $1/Adobe-Photoshop/drive_c/launcher.sh
echo 'WINEPREFIX='$1'/Adobe-Photoshop DXVK_LOG_PATH='$1'/Adobe-Photoshop DXVK_STATE_CACHE_PATH='$1'/Adobe-Photoshop wine64 ' $1'/Adobe-Photoshop/drive_c/Program\ Files/Adobe/Adobe\ Photoshop\ 2022/photoshop.exe $FILE_PATH' >> $1/Adobe-Photoshop/drive_c/launcher.sh

chmod +x $1/Adobe-Photoshop/drive_c/launcher.sh

rm -rf Adobe\ Photoshop\ 2022

WINEPREFIX=$1/Adobe-Photoshop winecfg -v win10


mv allredist/photoshop.png ~/.local/share/icons/photoshop.png


curl -L "https://lulucloud.mywire.org/FileHosting/GithubProjects/PS2022/Adobe_Photoshop_2022_Settings.tar.xz" > Adobe_Photoshop_2022_Settings.tar.xz
tar -xf Adobe_Photoshop_2022_Settings.tar.xz
mkdir $1/Adobe-Photoshop/drive_c/users/$USER/AppData/Roaming/Adobe
mkdir $1/Adobe-Photoshop/drive_c/users/$USER/AppData/Roaming/Adobe/Adobe\ Photoshop\ 2022/
mv Adobe\ Photoshop\ 2022\ Settings $1/Adobe-Photoshop/drive_c/users/$USER/AppData/Roaming/Adobe/Adobe\ Photoshop\ 2022/
rm -rf Adobe_Photoshop_2022_Settings.tar.xz
rm -rf Adobe\ Photoshop\ 2022\ Settings


touch ~/.local/share/applications/photoshop.desktop
echo '[Desktop Entry]' >> ~/.local/share/applications/photoshop.desktop
echo 'Name=Photoshop CC 2022' >> ~/.local/share/applications/photoshop.desktop
echo 'Exec=bash -c "'$1'/Adobe-Photoshop/drive_c/launcher.sh %F"' >> ~/.local/share/applications/photoshop.desktop
echo 'Type=Application' >> ~/.local/share/applications/photoshop.desktop
echo 'Comment=Photoshop CC 2022 (Wine)' >> ~/.local/share/applications/photoshop.desktop
echo 'Categories=Graphics;' >> ~/.local/share/applications/photoshop.desktop
echo 'Icon=photoshop' >> ~/.local/share/applications/photoshop.desktop
echo 'StartupWMClass=photoshop.exe' >> ~/.local/share/applications/photoshop.desktop


rm -rf allredist
rm -rf winetricks

rm -rf $1/progress.mimifile
touch $1/progress.mimifile
echo "100" >> $1/progress.mimifile

sleep 5

rm -rf $1/progress.mimifile
rm -rf $1/photoshop2022install.sh
