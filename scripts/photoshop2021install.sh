#!/bin/bash

# Show help menu if no path is given
if [[ -z $1 ]]; then
  printf "\nUsage: photoshop2021install.sh [INSTALL PATH] [OPTION]"
  printf "\n\nOptions:"
  printf "\n  --camera-raw:\tInstalls Photoshop 2021 and Camera Raw\n"
  exit 1
fi

INSTALL_PATH=$(echo "$1" | sed -e 's/\/$//') # Remove trailing slash
mkdir -p "$INSTALL_PATH"
export WINEPREFIX="$INSTALL_PATH/prefix"

cd "$INSTALL_PATH"

# Winetricks
wget  https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
chmod +x winetricks
./winetricks -q vcrun2010 vcrun2012 vcrun2013 vcrun2019 fontsmooth=rgb gdiplus msxml3 msxml6 atmlib corefonts dxvk win10 vkd3d
rm winetricks

echo "25" > progress.mimifile

# Adobe Photoshop 2021
curl -L "https://lulucloud.mywire.org/FileHosting/GithubProjects/AdobePhotoshop2021.tar.xz" > AdobePhotoshop2021.tar.xz
echo "50" > progress.mimifile
tar -xf AdobePhotoshop2021.tar.xz
rm AdobePhotoshop2021.tar.xz
echo "70" > progress.mimifile
mkdir "prefix/drive_c/Program Files/Adobe"
mv "Adobe Photoshop 2021" "prefix/drive_c/Program Files/Adobe/Adobe Photoshop 2021"

# Create launcher.sh
touch "launcher.sh"
cat <<EOF > "launcher.sh"
#!/usr/bin/env bash

cd "$INSTALL_PATH"

export SCR_PATH="pspath"
export CACHE_PATH="pscache"
export RESOURCES_PATH="\$SCR_PATH/resources"
export WINE_PREFIX="\$SCR_PATH/prefix"
export WINEPREFIX="$WINEPREFIX"
export DXVK_LOG_PATH='\$WINEPREFIX'
export DXVK_STATE_CACHE_PATH='\$WINEPREFIX'

FILE_PATH=\$(winepath -w "\$1")

wine64  "prefix/drive_c/Program Files/Adobe/Adobe Photoshop 2021/photoshop.exe" "\$FILE_PATH"
EOF
chmod +x "launcher.sh"

echo "90" > progress.mimifile

# Icon
curl -L https://raw.githubusercontent.com/LinSoftWin/Photoshop-CC2022-Linux/main/Adobe-Photoshop-Gui-Installer/src/Assets/photoshop.png > photoshop.png
mv photoshop.png "$HOME/.local/share/icons/photoshop.png"

# Create photoshop2021.desktop
touch "$HOME/.local/share/applications/photoshop2021.desktop"
cat <<EOF > "$HOME/.local/share/applications/photoshop2021.desktop"
[Desktop Entry]
Name=Photoshop CC 2021
Exec=bash -c "'$INSTALL_PATH/launcher.sh' %F"
Type=Application
Comment=Photoshop CC 2021 (Wine)
Categories=Graphics;
Icon=photoshop
StartupWMClass=photoshop.exe
EOF


# Camera Raw

if [[ -n $2 ]] && [[ $2 == "--camera-raw" ]]; then
    echo "95" > progress.mimifile

    curl -L "https://download.adobe.com/pub/adobe/photoshop/cameraraw/win/12.x/CameraRaw_12_2_1.exe" > CameraRaw_12_2_1.exe
    wine CameraRaw_12_2_1.exe
    rm CameraRaw_12_2_1.exe
fi

echo "100" > progress.mimifile

echo "Installation complete!"

rm progress.mimifile
