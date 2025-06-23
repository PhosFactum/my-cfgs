#####   SYSTEM INFO   #####

# Use powerline
USE_POWERLINE="true"

# Use widesymbols in terminal
HAS_WIDECHARS="false"

# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi

# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi



#####   EXPORTS   #####

# System
export EDITOR=/usr/bin/vim
export PATH=${PATH}:~/.bin

# Python
export PIP_REQUIRE_VIRTUALENV=false
export PYTHONPATH="$PYTHONPATH:$(pwd)/src"

# Golang
export GOROOT="$HOME/.go/go"
export GOPATH="$HOME/.go"
export GOMODCACHE="$HOME/.go/pkg/mod"
export PATH="$PATH:$GOROOT/bin:$GOPATH/bin"



#####   ALIASES   #####

# Commands
alias rmrf="rm -rf"
alias rd="rmdir"
alias lla="ls -la"
alias ll="ls -l"
alias la="ls -a"
alias l="ls"
alias cd="cd"
alias cd..="cd .."
alias cd-="cd -"
alias cpr="cp -r"
alias md="mkdir"
alias s!!="sudo !!"
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
alias dstop="sudo systemctl stop"
alias dstatus="sudo systemctl status"
alias denable="sudo systemctl enable"
alias ddisable="sudo systemctl disable"
alias dunmask="sudo systemctl unmask"
alias drestart="sudo systemctl restart"

# VPN (Adguard)
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
alias lsof="sudo lsof -i"

# Pomodoro
alias p="pomodoro"
alias pstart="pomodoro start --duration"
alias pstop="pomodoro finish"
alias pcan="pomodoro cancel"
alias pstatus="pomodoro status"
alias pbreak="pomodoro break"
alias prepeat="pomodoro repeat"

# LibreOffice
alias writer="loffice"
alias impress="loimpress"
alias calc="localc"
alias math="lomath"
alias base="lobase"
alias draw="lodraw"
alias pdf="zathura"

# Git
alias gita="git add"
alias gita.="git add ."
alias gitb="git branch"
alias gitc="git commit"
alias gitc-m="git commit -m"
alias gitc--amend="git commit --amend"
alias gits="git status"
alias gitlog="git log"
alias gitrm="git rm"
alias gitmv="git mv"
alias gitclean="git clean"
alias gitpush="git push"
alias gitpushf="git push -f"
alias gitpushfwl="git push --force-with-lease"
alias gitpull="git pull"
alias gitsw="git switch"
alias gitch="git checkout"

# Python
alias py="python3"
alias pipu="python3 -m pip install --upgrade pip"
alias venv="python -m venv .venv && source .venv/bin/activate && pip install --upgrade pip"
alias newvenv="python3 -m venv .venv"
alias actvenv="source .venv/bin/activate"
alias deact="deactivate"
alias pipl="pip list"
alias nrun="nodemon"
alias poetrun="poetry run python"
alias reqs="pip install -r requirements.txt"

# System utilities
alias targz="tar -czvf"  # better speed
alias tarxz="tar -cJvf"  # better compress
alias untar="tar -xvf"   # universal
alias 7zip="7z a -t7z -m0=lzma2 -mx=9 -mfb=64 -md=32m -ms=on"
alias wifi="nmcli dev wifi connect"

# Compilation
alias makeclean="make; make clean"
alias clean="make clean"
alias compose="docker compose up --build"
alias decompose="docker compose down"
alias recompose="docker compose down; docker compose up --build"

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
alias book_postgres="zathura $book_dir/postgres-docs.pdf"

# PostgreSQL
alias psqlu="psql -U postgres"

# Golang
alias grun="go run ./cmd/main.go"
alias reswag="swag init -g ./cmd/main.go"

# OrangePi
alias orange="ssh orange -t /usr/bin/bash"



#####   FUNCTIONS   #####

# Pomodoro function
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
