#!/bin/bash
# creates a basic desktop file

printf "Name of application: " 1>&2
read name
printf "Path to executable: " 1>&2
read path
path="${path/#\~/$HOME}"

cat << EOF
[Desktop Entry]
Encoding=UTF-8
Version=1.0
Type=Application
Terminal=false
Exec=$path
Name=$name
EOF
