# Use powerline
USE_POWERLINE="true"
# Has weird character width
# Example:
#    is not a diamond
HAS_WIDECHARS="false"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi
# Starting tmux
#if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#  exec tmux
#fi

### Exports ###

export EDITOR=/usr/bin/vim
export PIP_REQUIRE_VIRTUALENV=false


##### Aliases #####

# Commands
alias rmrf="rm -rf"
alias rd="rmdir"
alias lla="ls -la"
alias ll="ls -l"
alias la="ls -a"
alias l="ls"
alias cd="cd"
alias cd..="cd .."
alias cd/="cd /"
alias cd-="cd -"
alias cpr="cp -r"
alias s="cat"
alias md="mkdir"
alias m="mv"
alias s!="sudo !!"
alias dcd="cd /etc/systemd/system/; ls"
alias dls="ls /etc/systemd/system/"

# Configs
alias z="vim ~/.zshrc; source ~/.zshrc"
alias tvim="nvim -u ~/.config/tvim/init.lua"
alias diary="tvim"
alias setconf="vim ~/.my-cfgs/setup.sh"
alias tvimconf="nvim ~/.config/tvim/init.lua"
alias tvimcp="cp -r ~/.config/tvim ~/.my-cfgs/Editor/"
alias plan="bat --paging=never ~/Diary/personal/daily/$(date +\%Y)/$(date +\%m)/$(date +\%d).md"
alias today="tvim ~/Diary/personal/daily/$(date +\%Y)/$(date +\%m)/$(date +\%d).md"


# Package managers
alias yi="yay -S"
alias yu="yay -Syu"
alias yd="yay -Rs"
alias ydc="yay -Rns"
alias pi="sudo pacman -S"
alias pu="sudo pacman -Syu"
alias pd="sudo pacman -Rs"
alias pdc="sudo pacman -Rns"

# Daemons
alias dreload="sudo systemctl daemon-reload"
alias dstart="sudo systemctl start"
alias dstatus="sudo systemctl status"
alias denable="sudo systemctl enable"
alias ddisable="sudo systemctl disable"
alias dunmask="sudo systemctl unmask"
alias drestart="sudo systemctl restart"
alias vpnon="adguardvpn-cli connect"
alias vpnoff="adguardvpn-cli disconnect"
alias vpnstatus="adguardvpn-cli status"
alias vpnlogin="adguardvpn-cli login"
alias vpnlogout="adguardvpn-cli logout"

##  Utilities ##
alias ph="viewnior"
alias gdb="gdb -x ~/.gdbinit"
alias g="gdb"
alias nd="nodemon"

# Pomodoro
alias p="pomodoro"
alias pstart="pomodoro start --duration"
alias pstop="pomodoro finish"
alias pcan="pomodoro cancel"
alias pstatus="pomodoro status"
alias pbreak="pomodoro break"
alias prepeat="pomodoro repeat"

################

# Office 
alias writer="loffice"
alias impress="loimpress"
alias calc="localc"
alias math="lomath"
alias base="lobase"
alias draw="lodraw"
alias pdf="zathura"

## Git ##

# Git (short)
alias gita="git add"
alias gita.="git add ."
alias gitd="git diff"
alias gitb="git branch"
alias gitc="git commit"
alias gitc-m="git commit -m"
alias gitc--amend="git commit --amend"
alias gits="git status"

# Git (less short :D)
alias gitlog="git log"
alias gitrm="git rm"
alias gitmv="git mv"
alias gitclean="git clean"
alias gitpush="git push"
alias gitpushf="git push -f"
alias gitpull="git pull"
alias gitsw="git switch"
alias gitch="git checkout"

#########

# Python
alias py="python3"
alias pipu="python3 -m pip install --upgrade pip"
alias venv="python -m venv .venv && source .venv/bin/activate && pip install --upgrade pip"
alias newvenv="python3 -m venv .venv"
alias actvenv="source .venv/bin/activate"
alias deact="deactivate"
alias pipu="pip install --upgrade pip"
alias pipl="pip list"
alias nrun="nodemon"
alias poetrun="poetry run python"
alias poetrunuvi="poetry run uvicorn $1 --reload"alias paste="xsel --clipboard --output > "


# System utilities
alias chx="chmod +x"        # won"t work on local user"s cfg
alias ch37="chmod 777"      # same
alias um="uname -m"
alias du="du -h"
alias free="free -m"
alias untar="tar -xvf"
alias wifi="nmcli dev wifi connect"


# Compilation
alias makeclean="make; make clean"  # makefiles make and clean at one action
alias clean="make clean"       # make only clean

# Other
alias zshcp="cp ~/.zshrc ~/.my-cfgs/Shell/"
alias bashcp="cp ~/.bashrc ~/.my-cfgs/Shell/"
alias shellcp="zshcp; bashcp"
alias cpmake="cp ~/Education/Stolyarov/Pascal/makefile ."
alias saveit="cat >> ~/Education/Materials/Saved_Links"
alias paste="xclip -selection clipboard -o > "
alias pyste="paste main.py; py main.py"

# Books
book_dir="~/Education/Materials/Books"
alias book_stolyarov1="zathura $book_dir/progintro_e2v1.pdf"
alias book_stolyarov2="zathura $book_dir/progintro_e2v2.pdf"
alias book_stolyarov3="zathura $book_dir/progintro_e2v3.pdf"
alias book_swaroop="zathura $book_dir/swaroop-byte_of_python.pdf"
alias book_msu="zathura $book_dir/msu-oop.pdf"
alias book_shotts="zathura $book_dir/shotts-linux_cli.pdf"
alias book_lyubanovich="zathura $book_dir/lyubanovich-python.pdf"
alias book_lott="zathura $book_dir/lott-oop_python.pdf"


### Paths ###

PATH=${PATH}:~/.bin
export PATH


# Pomodoro #
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


