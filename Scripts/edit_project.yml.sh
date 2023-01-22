#!/bin/bash
# Script to open terminal and edit project.yml file

pwd=$(pwd)
osascript  <<EOF
tell app "Terminal"
 if not (exists window 1) then reopen
 activate
 do script "cd '$pwd'; open -a Xcode project.yml" in window 1
end tell
EOF


