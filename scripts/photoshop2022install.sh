#!/usr/bin/env bash

# Show help menu if no path is given
if [[ -z $1 ]]; then
  printf "\nUsage: photoshop2021install.sh [INSTALL PATH]"
  printf "\n\nExample:"
  printf '\n  photoshop2021install.sh "/home/user/.WineApps/Photoshop"\n'
  exit 1
fi

INSTALL_PATH=$(echo "$1" | sed -e 's/\/$//') # Remove trailing slash
mkdir -p "$INSTALL_PATH"
export WINEPREFIX="$INSTALL_PATH/prefix"

cd "$INSTALL_PATH"

# Custom Wine
curl -L "https://lulucloud.mywire.org/FileHosting/GithubProjects/PS2022/wine-tkg-staging-pspatch.tar.xz" > wine-tkg-staging-pspatch.tar.xz
tar -xf wine-tkg-staging-pspatch.tar.xz
rm wine-tkg-staging-pspatch.tar.xz
export WINE="$INSTALL_PATH/wine-tkg-staging-pspatch/bin/wine"

echo "10" > progress.mimifile

# Winetricks
wget "https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks"
chmod +x winetricks
./winetricks -q vcrun2010 vcrun2012 vcrun2013 vcrun2019 fontsmooth=rgb gdiplus msxml3 msxml6 atmlib corefonts dxvk win10 vkd3d
rm winetricks


echo "25" > progress.mimifile

# Adobe
curl -L "https://lulucloud.mywire.org/FileHosting/GithubProjects/PS2022/Adobe.tar.xz" > Adobe.tar.xz
tar -xf Adobe.tar.xz
rm Adobe.tar.xz
mv Adobe "prefix/drive_c/Program Files (x86)/Common Files"

echo "50" > progress.mimifile

# Adobe Photoshop 2022
curl -L "https://lulucloud.mywire.org/FileHosting/GithubProjects/PS2022/AdobePhotoshop2022.tar.xz" > AdobePhotoshop2022.tar.xz
tar -xf AdobePhotoshop2022.tar.xz
rm AdobePhotoshop2022.tar.xz
mkdir "prefix/drive_c/Program Files/Adobe"
mv "Adobe Photoshop 2022" "prefix/drive_c/Program Files/Adobe/Adobe Photoshop 2022"

echo "75" > progress.mimifile

# Create launcher.sh
touch "launcher.sh"
cat <<EOF > "launcher.sh"
#!/usr/bin/env bash

cd "$INSTALL_PATH"

export SCR_PATH="pspath"
export CACHE_PATH="pscache"
export RESOURCES_PATH="\$SCR_PATH/resources"
export WINE_PREFIX="\$SCR_PATH/prefix"
export WINEPREFIX='$WINEPREFIX'
export DXVK_LOG_PATH="\$WINEPREFIX"
export DXVK_STATE_CACHE_PATH="\$WINEPREFIX"

FILE_PATH=\$(wine-tkg-staging-pspatch/bin/winepath -w "\$1")

"wine-tkg-staging-pspatch/bin/wine64" "prefix/drive_c/Program Files/Adobe/Adobe Photoshop 2022/photoshop.exe" "\$FILE_PATH"
EOF
chmod +x "launcher.sh"

# Icon
curl -L https://raw.githubusercontent.com/LinSoftWin/Photoshop-CC2022-Linux/main/Adobe-Photoshop-Gui-Installer/src/Assets/photoshop.png > photoshop.png
mv photoshop.png "$HOME/.local/share/icons/photoshop.png"

echo "85" > progress.mimifile

# Adobe Photoshop 2022 Settings
curl -L "https://lulucloud.mywire.org/FileHosting/GithubProjects/PS2022/Adobe_Photoshop_2022_Settings.tar.xz" > Adobe_Photoshop_2022_Settings.tar.xz
tar -xf Adobe_Photoshop_2022_Settings.tar.xz
mkdir -p "prefix/drive_c/users/$USER/AppData/Roaming/Adobe/Adobe Photoshop 2022"
mv "Adobe Photoshop 2022 Settings" "prefix/drive_c/users/$USER/AppData/Roaming/Adobe/Adobe Photoshop 2022"
rm Adobe_Photoshop_2022_Settings.tar.xz

echo "95" > progress.mimifile

# Create photoshop2022.desktop
touch "$HOME/.local/share/applications/photoshop2022.desktop"
cat <<EOF > "$HOME/.local/share/applications/photoshop2022.desktop"
[Desktop Entry]
Name=Photoshop CC 2022
Exec=bash -c "'$INSTALL_PATH/launcher.sh' %F"
Type=Application
Comment=Photoshop CC 2022 (Wine)
Categories=Graphics;
Icon=photoshop
StartupWMClass=photoshop.exe
EOF

echo "100" > progress.mimifile

sleep 5

echo "Installation complete!"

rm progress.mimifile
