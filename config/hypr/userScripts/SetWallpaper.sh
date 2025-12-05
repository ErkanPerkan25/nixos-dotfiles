#!/usr/bin/env bash

wallpaperDirectory="$HOME/Pictures/wallpapers"
SCRIPTS_DIR="$HOME/.config/hypr/scripts"

# Variable
focused_monitor=$(hyprctl monitors | awk '/^Monitor/{name=$2} /focused: yes/{print name}')

# Set SWWW transition config
FPS=60
TYPE="any"
DURATION=2
BEZIER=".43,1.9,1,.4"
SWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION"

# Retrive files
mapfile -d '' PICS < <(find "$wallpaperDirectory" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) -print0)

RANDOM_PIC="${PICS[$((RANDOM % ${#PICS[@]}))]}"
RANDOM_PIC_NAME=". random"

# Rofi command
rofi_commmand="rofi -i -show -dmenu -config ~/.config/rofi/config-wallpaper.rasi"

# Sorting Wallpapers
menu() {
  # Sort the PICS array
  IFS=$'\n' sorted_options=($(sort <<<"${PICS[*]}"))

  # Place ". random" at the beginning with the random picture as an icon
  printf "%s\x00icon\x1f%s\n" "$RANDOM_PIC_NAME" "$RANDOM_PIC"

  for pic_path in "${sorted_options[@]}"; do
        pic_name=$(basename "$pic_path")

        # Displaying .gif to indicate animated images
        if [[ ! "$pic_name" =~ \.gif$ ]]; then
            printf "%s\x00icon\x1f%s\n" "$(echo "$pic_name" | cut -d. -f1)" "$pic_path"
        else
              printf "%s\n" "$pic_name"
        fi
    done
}

### initiate swww if not running
swww query || swww-daemon --format xrgb


# Choice the wallpaper
main(){
    selectedWall=$(menu | $rofi_commmand)

    # Trim any whitespace or hidden characters
    selectedWall=$(echo "$selectedWall" | xargs)
    RANDOM_PIC_NAME=$(echo "$RANDOM_PIC_NAME" | xargs)
    
    # No choice case
    if [[ -z "selectedWall" ]]; then
        echo "No choice selected. Exiting..."
        exit 0
    fi

    # Random choice case
    if [[ "$selectedWall" == "$RANDOM_PIC_NAME" ]]; then
        swww img -o "$focused_monitor" "$RANDOM_PIC" $SWWW_PARAMS
        sleep 0.5
        #"$SCRIPTSDIR/WallustSwww.sh"
        sleep 0.2
        "$SCRIPTS_DIR/refresh.sh"
        exit 0
    fi

    # Find the index of selected file
    pic_index=-1
    for i in "${!PICS[@]}"; do
        filename=$(basename "${PICS[i]}")
        if [[ "$filename" == "$selectedWall"* ]]; then
            pic_index=$i 
            break
        fi
    done

    if [[ $pic_index -ne -i ]]; then
        swww img -o "$focused_monitor" "${PICS[$pic_index]}" $SWWW_PARAMS
    else
        echo "Image not found."
        exit 0
    fi

}


# Check if rofi is already running
if pidof rofi >/dev/null; then
    pkill rofi
    sleep 1 # Allow some time for rofi to close
fi

main

sleep 0.2
"$SCRIPTS_DIR/refresh.sh"
