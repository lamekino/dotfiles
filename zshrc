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
bindkey -e
setopt INTERACTIVE_COMMENTS # Comments in shell
setopt COMPLETE_ALIASES     # Preserves aliases in autocomplete
setopt PROMPT_SUBST         # Allow variables &c in prompt
setopt INC_APPEND_HISTORY   # Append to ~/.zhistory as soon as command is entered
setopt HIST_IGNORE_ALL_DUPS # ignore duplicate commands in history
setopt SHARE_HISTORY        # Share history among terminals
# }}}
# Imports {{{
[ -e $HOME/.dircolors ] && eval $(dircolors -b $HOME/.dircolors)

# Use ZSH tab completion
# -u fixes an issue specific to WSL
autoload -Uz compinit && compinit -u || echo "[$0] compinit failed" 1>&2

# Documentation
autoload run-help
alias help="run-help"
# }}}
# Aliases {{{
# ZSH functions
alias todo="zf_todo"
# Shadowing
alias sudo='sudo ' # so aliases can be run with sudo
alias dirs='dirs -v'
alias jobs='jobs -l'
alias pgrep='pgrep -l'
alias vi='vim'
alias info="info --vi-keys"
alias hgrep="history 1 | egrep --color=never"
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
alias rln='ln -r'
alias fr='rm -frIv'
alias screen='TERM=xterm-256color screen'
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
				alias autoremove='pacman -Rncs `pacman -Qdtq`'
				alias pacpurge='pacman -Rncs'
				;;
			'Ubuntu')
				;;
			'Debian')
				;;
			*)
				;;
		esac

		alias grep='grep --color=auto'
		alias lablk="lsblk -o name,label,size,ro,type,mountpoint,uuid"
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
function zf_promptstr()
{
	local var="$1"
	local rgb="$2"
	local sym="$3"
	eval "$var='%F{$rgb}$sym%f'"
}

zf_promptstr ZP_SEP  243 "\\"

function zfpre_dircount()
{
	local dircount=$(( `dirs -v | wc -l` - 1))
	if [ $dircount -gt 0 ]
	then
		zf_promptstr ZP_DIRS 177 "~$dircount"
		ZP_DIRS="$ZP_SEP$ZP_DIRS"
	else
		ZP_DIRS=
	fi
}

function zfpre_errorcode()
{
	local c=$?
	if [ $c -ne 0 ]
	then
		local code=`printf "%02X" $c`
		zf_promptstr ZP_ERR  202 "0x$code"
	fi
}

if [ `id -u` -ne 0 ]
then
	# zf_promptstr ZP_USER 110 "%n"
	# zf_promptstr ZP_CWD  172 "%~"
	zf_promptstr ZP_CWD  110 "%~"
else
	# zf_promptstr ZP_USER 001 "*%n*"
	zf_promptstr ZP_CWD  001 "%/"
fi

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]
then
	ZP_SSH="@%F{172}%m%f"
fi

# if shell opened from vim :shell
if grep -q vim /proc/$PPID/comm
then
	zf_promptstr ZP_VIM 002 "* "
else
	ZP_VIM=
fi

# zf_promptstr ZP_JOBS 118 "%%%j"
zf_promptstr ZP_JOBS 172 "%%%j"
zf_promptstr ZP_HIST 060 "!%h"

function zfpre_reloadprompt()
{
	PROMPT="$ZP_VIM$ZP_USER$ZP_SSH<$ZP_CWD$ZP_DIRS%(1j.$ZP_SEP$ZP_JOBS.)%(?..$ZP_SEP$ZP_ERR)>%# "
	RPROMPT=$ZP_HIST
}

# make the function run before prompt redraw
precmd_functions=(
	zfpre_dircount
	zfpre_errorcode
	zfpre_reloadprompt
)
# }}}
# and finally...
[ -z $TMUX ] && [ -z $VIM ] && \
	command -v fortune &> /dev/null && fortune || true