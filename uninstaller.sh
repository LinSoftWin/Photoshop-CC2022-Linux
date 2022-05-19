#!/bin/bash
export WINEPREFIX=~/.WineApps/Adobe-Photoshop

rm -rf "$WINEPREFIX"
rm -rf ~/.local/share/icons/photoshop.png
rm -rf  ~/.local/share/applications/photoshop.desktop

zenity --info --text="Photoshop uninstalled."
