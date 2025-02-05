#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		# We have color support; assume it's compliant with Ecma-48
		# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
		# a case would tend to support setf rather than setaf.)
		color_prompt=yes
	else
		color_prompt=
	fi
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	#alias dir='dir --color=auto'
	#alias vdir='vdir --color=auto'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

## man colors: https://www.2daygeek.com/get-display-view-colored-colorized-man-pages-linux/, https://www.tecmint.com/view-colored-man-pages-in-linux/
man() {
	LESS_TERMCAP_mb=$'\e[1;32m' \
		LESS_TERMCAP_md=$'\e[1;32m' \
		LESS_TERMCAP_me=$'\e[0m' \
		LESS_TERMCAP_se=$'\e[0m' \
		LESS_TERMCAP_so=$'\e[01;33m' \
		LESS_TERMCAP_ue=$'\e[0m' \
		LESS_TERMCAP_us=$'\e[1;4;31m' \
		command man "$@"
	}

function git_color()
{
	local BRED="\033[1;31m"
	local BYELLOW="\033[1;33m"
	local BGREEN="\033[1;32m"

	local git_status=$(git status --porcelain 2>/dev/null)
	if [ "$git_status" != "" ]
	then
		echo -e "${BRED}"
	else
		local git_status=$(git status 2>/dev/null | grep "Your branch is ahead" 2>/dev/null)
		if [ "$git_status" != "" ]
		then
			echo -e "${BYELLOW}"
		else
			echo -e "${BGREEN}"
		fi
	fi
}

function git_branch() {
	local NOCOLOR="\033[0m"
	local git_br=$(git branch --show-current 2>/dev/null)
	if [ "$git_br" != "" ];
	then
		echo -e " $(git_color)($git_br)${NOCOLOR}"
	fi
}

PS1='\[\033[1;95m\]\u\[\033[0m\]:\[\033[1;34m\]\w\[\033[0m\]$(git_branch) > '

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.aliases ]; then
	. ~/.aliases
fi

export EDITOR='nvim'
export VISUAL='nvim'

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
	PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Short press of ctrl key (dn, up again) --> Esc
#pgrep -x xcape >/dev/null || xcape -e "Control_L=Escape"

## [ -z "$DISPLAY" -a "$(fgconsole)" -eq 1 ] && exec startx
if [ -z "$DISPLAY" ]; then
	if [ "$(fgconsole)" -eq 1 ]; then
		#        true
		exec startx
	fi
fi

# for prboom music:
export SDL_SOUNDFONTS=/usr/share/soundfonts/FluidR3_GM.sf2

# fzf
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash

# screenfetch
# fortune | cowsay -f $(ls /usr/share/cows/*.cow | shuf -n 1)


# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION

# . "$HOME/.cargo/env"

## Set default nvim config
## if not set, default is simply ~/.config/nvim
# export NVIM_APPNAME="nvim-kickstart"
export NVIM_APPNAME="nvim"

