#!/bin/sh
sleep 1
killall -e xdg-desktop-portal-hyprland
killall xdg-desktop-portal
echo "Starting xdg-desktop-portal-hyprland" >> xdg-desktop-portal-hyprland.log
/usr/lib/xdg-desktop-portal-hyprland & 
sleep 2
/usr/lib/xdg-desktop-portal &
