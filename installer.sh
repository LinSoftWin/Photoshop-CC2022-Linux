#!/bin/bash
ALLREDIST_URL="https://drive.google.com/uc?export=download&id=1qcmyHzWerZ39OhW0y4VQ-hOy7639bJPO"
ALLREDIST_FILE="./allredist.tar.xz"
ALLREDIST_MD5="8bfab2e4a4682d9bcf79926544053b76"
PHOTOSHOP_URL="https://download854.mediafire.com/kj7h8gkorsvg/dhvztovo7gj738e/AdobePhotoshop2021.tar.xz"
PHOTOSHOP_FILE="./AdobePhotoshop2021.tar.xz"
PHOTOSHOP_MD5="cccb6715180b86e1eb8c1d7bd4a8a4e8"
WINETRICKS_URL="https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks"
WINETRICKS_FILE="./winetricks"
CAMERA_RAW_URL="https://download.adobe.com/pub/adobe/photoshop/cameraraw/win/12.x/CameraRaw_12_2_1.exe"
CAMERA_RAW_FILE="./CameraRaw.exe"

RED="\e[31m"
GREEN="\e[32m"
CYAN="\e[36m"
ENDCOLOR="\e[0m"

echo -e "\n${CYAN}INFO: Welcome! I am going to install Photoshop on your Linux Machine.${ENDCOLOR}"
echo -e "${CYAN}INFO: This will take up to 10 Minutes so pleae be patient.${ENDCOLOR}\n"

mkdir -p ~/.WineApps/Adobe-Photoshop

curl -L $WINETRICKS_URL > $WINETRICKS_FILE
chmod +x $WINETRICKS_FILE

WINEPREFIX=~/.WineApps/Adobe-Photoshop wineboot
WINEPREFIX=~/.WineApps/Adobe-Photoshop $WINETRICKS_FILE win10


if [ ! -f "$ALLREDIST_FILE" ]; then
	curl -L $ALLREDIST_URL > $ALLREDIST_FILE
	if [ 0 -ne $? ]; then
		echo -e "${RED}ERROR: could not download $ALLREDIST_URL. Please check the output above.${ENDCOLOR}"
		exit 1
	fi
else
	echo -e "${CYAN}INFO: $ALLREDIST_FILE already exists. Using it.${ENDCOLOR}"
fi

if [ ! -f "$PHOTOSHOP_FILE" ]; then
	curl -L $PHOTOSHOP_URL > $PHOTOSHOP_FILE
	if [ 0 -ne $? ]; then
		echo -e "${RED}ERROR: could not download $PHOTOSHOP_URL. Please check the output above.${ENDCOLOR}"
		exit 1
	fi
else
	echo -e "${CYAN}INFO: $PHOTOSHOP_FILE already exists. Using it.${ENDCOLOR}"
fi

if ! md5sum --status -c <(echo -e $ALLREDIST_MD5 $ALLREDIST_FILE); then
	echo -e "${RED}ERROR: md5sum of $ALLREDIST_FILE did not match! Please download the file manually.${ENDCOLOR}"
	exit 1
fi

if ! md5sum --status -c <(echo -e $PHOTOSHOP_MD5 $PHOTOSHOP_FILE); then
	echo -e "${RED}ERROR: md5sum of $PHOTOSHOP_FILE did not match! Please download the file manually.${ENDCOLOR}"
	exit 1
fi

tar -xf $ALLREDIST_FILE
tar -xf $PHOTOSHOP_FILE

WINEPREFIX=~/.WineApps/Adobe-Photoshop $WINETRICKS_FILE fontsmooth=rgb gdiplus msxml3 msxml6 atmlib corefonts dxvk
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

echo "\n"
while true; do
	read -p "Do you want to install CameraRaw?" yn
	case $yn in
		[Yy]* ) 
			echo -e "Just follow the setup from CameraRaw."
			curl -L $CAMERA_RAW_URL > $CAMERA_RAW_FILE
			if [ 0 -ne $? ]; then
				echo -e "${RED}ERROR: could not download $CAMERA_RAW_URL. Please check the output above.${ENDCOLOR}"
				echo -e "${CYAN}INFO: You can download CameraRaw manually and install it with:${ENDCOLOR}"
				echo -e "${CYAN}INFO: WINEPREFIX=~/.WineApps/Adobe-Photoshop wine <PATH_TO_CAMERARAW.EXE>${ENDCOLOR}"
			fi
			WINEPREFIX=~/.WineApps/Adobe-Photoshop wine $CAMERA_RAW_FILE
			break;;
		[Nn]* ) break;;
		* ) echo -e "Please answer (y)es or (n)o.${ENDCOLOR}";;
	esac
done

echo "\n"
while true; do
	read -p "Do you want to remove all installation artifacts?" yn
	case $yn in
		[Yy]* )
			rm -rf $ALLREDIST_FILE $PHOTOSHOP_FILE ./allredist $WINETRICKS_FILE $CAMERA_RAW_FILE
			break;;
		[Nn]* ) break;;
		* ) echo -e "Please answer (y)es or (n)o.";;
	esac
done

echo -e "\n${CYAN}INFO: Have fun with Photoshop!${ENDCOLOR}"
