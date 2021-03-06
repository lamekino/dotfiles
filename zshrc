#================================================================#
#                                                                #
#                            ██                                  #
#                            ██                                  #
#                            ██                                  #
#        ████████   ▒█████░  ██░████    ██░████    ▓████▒        #
#        ████████  ████████  ███████▓   ███████   ███████        #
#            ▒██▒  ██▒  ░▒█  ███  ▒██   ███░     ▓██▒  ▒█        #
#           ▒██▒   █████▓░   ██    ██   ██       ██░             #
#          ▒██▒    ░██████▒  ██    ██   ██       ██              #
#         ▒██▒        ░▒▓██  ██    ██   ██       ██░             #
#        ▒██▒      █▒░  ▒██  ██    ██   ██       ▓██▒  ░█        #
#        ████████  ████████  ██    ██   ██        ███████        #
#        ████████  ░▓████▓   ██    ██   ██         ▓████▒        #
#                                                                #
#================================================================#
# * Github repo: https://github.com/lamekino/dotfiles            #
# * ZSHDocs: http://zsh.sourceforge.net/Doc/Release/zsh_toc.html #
# * ArchWiki: https://wiki.archlinux.org/index.php/Zsh           #
#================================================================#

# ZSH options {{{
bindkey -v                  # Vi keybinds
bindkey '^R' history-incremental-search-backward
setopt INTERACTIVE_COMMENTS # Comments in shell
setopt COMPLETE_ALIASES     # Preserves aliases in autocomplete
setopt PROMPT_SUBST         # Allow variables in prompt
setopt INC_APPEND_HISTORY   # Append to ~/.zhistory as soon as command is entered
setopt HIST_IGNORE_ALL_DUPS # ignore duplicate commands in history
setopt SHARE_HISTORY        # Share history among terminals
# }}}
# Imports {{{
# files to source
source_files()
{
	! [ -d ~/.zsources.d ] \
		&& unfunction source_files \
		&& return

	local file
	for file in ~/.zsources.d/*
	do
		[ -r $file ] && builtin source $file
	done
	unfunction source_files
}; source_files

# this makes comments *actually* readable in Alacritty
[ -n ZSH_HIGHLIGHT_STYLES ] \
	&& ZSH_HIGHLIGHT_STYLES[comment]=fg=white

[ -e $HOME/.dircolors ] && eval $(dircolors -b $HOME/.dircolors)

# Use ZSH tab completion
# -u fixes an issue specific to WSL
autoload -Uz compinit && compinit -u || echo "[$0] compinit failed" 1>&2

# Documentation
autoload run-help
alias help="run-help"
# }}}
# Aliases/Functions {{{
# Functions
function j() # jump up n directories
{
	if [ -z $1 ]; then
		cd ..
	elif [ $1 -gt 1 ]; then
		cd $(printf "../%.0s" {1.."$1"})
	fi
}
function hgrep() # search history
{
	args=".*$@.*"
	args="${args// /.*}"
	history 1 | grep -E "$args"
}
function touchx() # touch and make executable
{
	touch $1 && chmod +x $1
}
# Shadowing
alias sudo='sudo ' # so aliases can be run with sudo
alias dirs='dirs -v'
alias jobs='jobs -l'
alias pgrep='pgrep -l'
alias vi='vim'
alias info="info --vi-keys"
alias veracrypt="veracrypt -t"
alias vim="vim -X" # fixes slow startup time
# Short hand
alias cite="source ~/.zshrc && source ~/.zshenv" # cite your sources!
alias xres="xrdb ~/.Xresources"
alias bulkdl='wget -np -nd -r --reject html'
alias stop='kill -STOP'
alias deps='gcc -MM'
alias deps++='g++ -MM' # is this necessary?
alias ppath='sed "s/:/\n/g" <<< $PATH'
alias rln='ln -r' # GNU only
alias fr='rm -frIv'
alias screen='TERM=xterm-256color screen'
alias py="PAGER=less bpython"
# Python
alias python="python3"
alias pip="pip3"
# Curl Utils
alias wttr='curl -s http://wttr.in'
alias ipecho='curl http://ipecho.net/plain; printf "\n"'
# }}}
# OS Specifics {{{
case "$(uname -s)" in
	"Linux")
		# Windows Subsystem for Linux
		if grep -qi Microsoft /proc/version
		then
			export DISPLAY=:0 # for xorg applications FIXME: broken in WSL2
			export USERPROFILE=/mnt/c/Users/`whoami`
			alias wsl-explorer="explorer.exe"
			alias mpv="mpv.exe"
			alias wsl-ahk="cmd.exe /c start AutoHotKey"
			alias wsl-cmd="cmd.exe /c"
			alias wsl-env="cmd.exe /c set"
			alias wsl-ipconfig="ipconfig.exe"
			alias wsl-posh="powershell.exe"
			alias wsl-ps1="powershell.exe -File"
		fi

		# Distro specific
		# https://unix.stackexchange.com/a/25131
		case `lsb_release -is` in
			'Arch')
				# https://fosskers.github.io/aura/usage.html
				# https://github.com/fosskers/aura
				if command -v aura &>/dev/null
				then
					alias pacman="aura --hotedit --unsuppress"
					alias aura="aura --hotedit --unsuppress"
				fi
				alias hd="hexdump -C"
				alias pacpurge='pacman -Rncs'
				;;
			'Ubuntu'|'Debian')
				alias aptup="sudo apt update && sudo apt upgrade"
				;;
		esac

		alias grep='grep --color=auto'
		alias lablk="lsblk -o name,label,size,ro,type,mountpoint,uuid"
		alias l='ls -pk --color=auto --group-directories-first'
		alias ls='ls -pk --color=auto --group-directories-first'
		alias ll='ls -pklh --color=auto --group-directories-first'
		alias la='ls -pklah --color=auto --group-directories-first'
		alias feh='feh -x --scale-down'
		alias feh-svg="feh --magick-timeout 1 $1"
		;;
	"Darwin")
		# For macOS. I don't use macs very often, so this is quite barren
		# and maybe even out of date.
		export CLICOLOR=1
		alias ls='ls -pk'
		alias ll='ls -pkl'
		alias la='ls -pkla'
		alias lsblk='diskutil list'
		;;
esac
# }}}
# Setting the prompt {{{
function promptstr() { local var=$1 rgb=$2 str=$3; eval "$var='%F{$rgb}$str%f'" }
promptstr ZP_SEP  243 "\\"

function precmd_errorcode()
{
	local fmt=`printf "x%02X" $?`
	# $[x] converts hex to decimal in the format $[0xN]
	[ $[0${fmt}] -ne 0 ] && promptstr ZP_ERR 202 $fmt
}

# TODO: Make this less hacky
function precmd_dircount()
{
	local dircount=`dirs -v | wc -l`
	promptstr ZP_DIRS 225 "~$(( dircount - 1 ))"

	[ $dircount -gt 1 ] && \
		# there's no way (that i know of) to check
		# dircount with the ternary operator, so the
		# separator has to be concatenated here
		ZP_DIRS="$ZP_SEP$ZP_DIRS" || \
		ZP_DIRS=
}


promptstr ZP_JOBS 172 "%%%j"
promptstr ZP_HIST 068 "!%h"
promptstr ZP_TIME 060 "%D{%H:%M:%S}"
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ] # ssh hostname
then
	promptstr ZP_HOST 214 "@%m"
fi
if grep -q vim /proc/$PPID/comm # if shell opened from vim :shell
then
	promptstr ZP_VIM 002 "* "
fi

if [ `id -u` -ne 0 ]
then
	promptstr ZP_USER 183 "%n"
	promptstr ZP_CWD  159 "%~"
else
	promptstr ZP_USER 001 "*%n*"
	promptstr ZP_CWD  009 "%/"
fi

function precmd_reloadprompt()
{
	ZP_PROMPT="$ZP_VIM$ZP_USER$ZP_HOST:<$ZP_CWD$ZP_DIRS%(1j.$ZP_SEP$ZP_JOBS.)%(?..$ZP_SEP$ZP_ERR)>"
	RPROMPT="$ZP_HIST $ZP_TIME"
}

# make the function run before prompt redraw
precmd_functions=(
	precmd_dircount
	precmd_errorcode
	precmd_reloadprompt
)
# if z is installed add it to precmd_functions
# $_Z_RESOLVE_SYMLINKS is defined by z.sh
[ -n $_Z_RESOLVE_SYMLINKS ] && precmd_functions+=_z_precmd

# and... here is where the actual prompt is set
function zle-line-init zle-keymap-select {
	case $KEYMAP in
		vicmd) # normal mode
			PROMPT="${ZP_PROMPT}| "
			;;
		viins|main) # insert mode
			PROMPT="${ZP_PROMPT}%# "
			;;
	esac
	zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
# }}}
# and finally...
[ -z $TMUX ] && [ -z $VIM ] \
	&& command -v fortune cowsay &> /dev/null \
	&& fortune | cowsay -n -f dragon \
	|| true
