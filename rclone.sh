#!/bin/bash

lockfile -r 0 /tmp/rclone.sh.lock || exit 1

for FOLDER in "0_Lin Family docs" "Android" "Apartment" "Arduino" "Bike Routes" "Car" "CV_Ilia" "CV_Alyssa" "DND" "Garmin" "Genealogy" "Ilia Bills" "Intel" "International_Trips" "Israel trips" "kernel" "Manuals" "MISC" "ORG" "PhoneRecord" "Ringtones" "RPG" "tech" "Warranty" "Work"
do
rclone dedupe --dedupe-mode rename "gdrive:$FOLDER"
rclone sync "gdrive:$FOLDER" "dropbox:$FOLDER" -P
done

rm -f /tmp/rclone.sh.lock
