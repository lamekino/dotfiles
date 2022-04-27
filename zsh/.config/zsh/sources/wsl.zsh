export DISPLAY=:0 # for xorg applications FIXME: broken in WSL2
export USERPROFILE=/mnt/c/Users/$(whoami)
alias open="/mnt/c/Windows/explorer.exe"
alias winget="$USERPROFILE/AppData/Local/Microsoft/WindowsApps/winget.exe"
alias xclip="/mnt/c/Windows/system32/clip.exe"

# remove c:/windows/system32 from path
# for whatever reason, even adding appendPath = false to wsl.conf doesn't get
# rid of it. wtf mircosoft???
# https://unix.stackexchange.com/a/496050
function path_remove {
    # Delete path by parts so we can never accidentally remove sub paths
    PATH=${PATH//":$1:"/":"} # delete any instances in the middle
    PATH=${PATH/#"$1:"/} # delete any instance at the beginning
    PATH=${PATH/%":$1"/} # delete any instance in the at the end
}

path_remove '/mnt/c/Windows/System32'
unfunction path_remove
