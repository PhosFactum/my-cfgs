#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

colors() {
    local fgc bgc vals seq0

    printf "Color escapes are %s\n" '\e[${value};...;${value}m'
    printf "Values 30..37 are \e[33mforeground colors\e[m\n"
    printf "Values 40..47 are \e[43mbackground colors\e[m\n"
    printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

    # foreground colors
    for fgc in {30..37}; do
        # background colors
        for bgc in {40..47}; do
            fgc=${fgc#37} # white
            bgc=${bgc#40} # black

            vals="${fgc:+$fgc;}${bgc}"
            vals=${vals%%;}

            seq0="${vals:+\e[${vals}m}"
            printf "  %-9s" "${seq0:-(default)}"
            printf " ${seq0}TEXT\e[m"
            printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
        done
        echo
        echo
    done
}

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Change the window title of X terminals
case ${TERM} in
xterm* | rxvt* | Eterm* | aterm | kterm | gnome* | interix | konsole*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
    ;;
screen*)
    PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
    ;;
esac

use_color=true

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?} # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs} ]] &&
    type -P dircolors >/dev/null &&
    match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color}; then
    # Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
    if type dircolors >/dev/null; then
        if [[ -f ~/.dir_colors ]]; then
            eval $(dircolors -b ~/.dir_colors)
        elif [[ -f /etc/DIR_COLORS ]]; then
            eval $(dircolors -b /etc/DIR_COLORS)
        fi
    fi

    if [[ ${EUID} == 0 ]]; then
        PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
    else
        PS1='\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\$\[\033[00m\] '
    fi

    alias ls='ls --color=auto'
    alias grep='grep --colour=auto'
    alias egrep='egrep --colour=auto'
    alias fgrep='fgrep --colour=auto'
else
    if [[ ${EUID} == 0 ]]; then
        # show root@ when we don't have colors
        PS1='\u@\h \W \$ '
    else
        PS1='\u@\h \w \$ '
    fi
fi

unset use_color safe_term match_lhs sh




##### Aliases #####

### Commands

alias rmrf='rm -rf'
alias rd='rmdir'
alias lla='ls -la'
alias ll='ls -l'
alias la='ls -a'
alias l='ls'
alias cd..='cd ..'
alias cd-='cd -'
alias md='mkdir'
alias s!!='sudo !!'
alias cddaemon='cd /etc/systemd/system/; ls'
alias lsdaemon='ls /etc/systemd/system/'


### Configs

alias bashrc='vim ~/.bashrc; source ~/.bashrc'
alias zshrc='vim ~/.zshrc; source ~/.zshrc'
alias tmuxrc='vim ~/.tmux.conf; source ~/.tmux.conf'


### Package managers

alias yays='yay -S'
alias yaysyu='yay -Syu'
alias yayr='yay -R'
alias yayrs='yay -Rs'
alias yayrns='yay -Rns'
alias pacs='sudo pacman -S'
alias pacsyu='sudo pacman -Syu'
alias pacr='sudo pacman -R'
alias pacrs='sudo pacman -Rs'
alias pacrns='sudo pacman -Rns'


### Daemons

alias dreload='sudo systemctl daemon-reload'
alias dstart='sudo systemctl start'
alias dstatus='sudo systemctl status'
alias denable='sudo systemctl enable'
alias ddisable='sudo systemctl disable'
alias drestart='sudo systemctl restart'


### Pomodoro

alias pstart='pomodoro start --duration'
alias pstop='pomodoro finish'
alias pcan='pomodoro cancel'
alias pstatus='pomodoro status'
alias pbreak='pomodoro break'
alias prepeat='pomodoro repeat'


### Office

alias writer='loffice'
alias impress='loimpress'
alias calc='localc'
alias math='lomath'
alias base='lobase'
alias draw='lodraw'
alias pdf='zathura'


### Git

alias gita='git add'
alias gita.='git add .'
alias gitd='git diff'
alias gitb='git branch'
alias gitc='git commit'
alias gitc-m='git commit -m'
alias gitc--amend='git commit --amend'
alias gits='git status'
alias gitlog='git log'
alias gitrm='git rm'
alias gitmv='git mv'
alias gitclean='git clean'
alias gitpush='git push'
alias gitfpush='git push -f'
alias gitpull='git pull'
alias gitsw='git switch'
alias gitch='git checkout'


### Python

alias py='python3'
alias newvenv='python3 -m venv .venv'
alias actvenv='source .venv/bin/activate'


### System utilities

alias chx='chmod +x'   # won't work on local user's cfg
alias du='du -h'
alias free='free -m'
alias untar='tar -zxvf'
alias wifi='nmcli dev wifi connect'


### Hyprland
alias hyprconf='vim ~/.config/hypr/hyprland.conf'
alias hyprkeys='vim ~/.config/hypr/keybind.conf'



##### Exports and Paths #####

### Editor

export EDITOR=/usr/bin/vim


### PATHS

PATH_go=/usr/local/go/bin
PATH_home_bin=~/.bin
PATH_vscode=/usr/local/VSCode/bin

PATH=${PATH}:${PATH_go}:${PATH_home_bin}:${PATH_vscode}
export PATH



##### Utilities #####

### Books

alias book_='book '

book() {
    local dir="$HOME/Education/Books"
    local name="$1"
    local file="$dir/${name}.pdf"

    if [[ -f "$file" ]]; then
	zathura "$file" &
    else
	echo "--- File was not found! ---"
	echo "Available books:"
        ls "$dir" | sed 's/\.pdf$//' | tr ' ' '\n'
    fi
}


### Pomodoro
function pomo() {
    arg1=$1
    shift
    args="$*"

    min=${arg1:?Example: pomo 15 Take a break}
    sec=$((min * 60))
    msg="${args:?Example: pomo 15 Take a break}"

    while true; do
        sleep "${sec:?}" && echo "${msg:?}" && notify-send -u critical -t 0 "${msg:?}"
    done
}
