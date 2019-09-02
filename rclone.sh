#!/bin/bash

for FOLDER in "0_Lin Family docs" "Apartment" "Arduino" "Car" "CV_Ilia" "CV_Alyssa" "Genealogy" "Ilia Bills" "International_Trips" "Israel trips" "ORG" "PhoneRecord" "Ringtones" "RPG" "tech" "kernel" "work"
do
rclone dedupe --dedupe-mode rename "gdrive:$FOLDER"
rclone sync "gdrive:$FOLDER" "dropbox:$FOLDER" -P
done
