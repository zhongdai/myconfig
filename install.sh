#!/usr/bin/env bash

#=============================================================================
# install.sh --- bootstrap script for myconfig
#=============================================================================

Color_off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Underline
UBlack='\033[4;30m'       # Black
URed='\033[4;31m'         # Red
UGreen='\033[4;32m'       # Green
UYellow='\033[4;33m'      # Yellow
UBlue='\033[4;34m'        # Blue
UPurple='\033[4;35m'      # Purple
UCyan='\033[4;36m'        # Cyan
UWhite='\033[4;37m'       # White

# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[42m'       # Green
On_Yellow='\033[43m'      # Yellow
On_Blue='\033[44m'        # Blue
On_Purple='\033[45m'      # Purple
On_Cyan='\033[46m'        # Cyan
On_White='\033[47m'       # White

# High Intensity
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White

# Bold High Intensity
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\033[0;100m'   # Black
On_IRed='\033[0;101m'     # Red
On_IGreen='\033[0;102m'   # Green
On_IYellow='\033[0;103m'  # Yellow
On_IBlue='\033[0;104m'    # Blue
On_IPurple='\033[0;105m'  # Purple
On_ICyan='\033[0;106m'    # Cyan
On_IWhite='\033[0;107m'   # White

# version
Version='0.1'
#System name
System="$(uname -s)"

need_cmd () {
  if ! hash "$1" &>/dev/null; then
    error "Need '$1' (command not found)"
    exit 1
  fi
}

msg() {
  printf '%b\n' "$1" >&2
}

success() {
  msg "${Green}[✔]${Color_off} ${1}${2}"
}

info() {
  msg "${Blue}[➭]${Color_off} ${1}${2}"
}

error() {
  msg "${Red}[✘]${Color_off} ${1}${2}"
  exit 1
}

warn () {
  msg "${Yellow}[⚠]${Color_off} ${1}${2}"
}

echo_with_color () {
  printf '%b\n' "$1$2$Color_off" >&2
}


usage () {
  echo "MyConfig install script : V ${Version}"
  echo ""
  echo "Usage : curl -sLf https://raw.githubusercontent.com/zhongdai/myconfig/master/install.sh | bash -s -- [option]" 
  echo ""
  echo "  This is bootstrap script for MyConfig."
  echo ""
  echo "OPTIONS"
  echo ""
  echo " -i, --install            install spacevim for vim or neovim"
  echo " -v, --version            Show version information and exit"
  echo " -u, --uninstall          Uninstall SpaceVim"
  echo " -c, --checkRequirements  checkRequirements for SpaceVim"
  echo ""
  echo "EXAMPLE"
  echo ""
  echo "    Install MyConfig"
  echo ""
  echo "        curl -sLf https://raw.githubusercontent.com/zhongdai/myconfig/master/install.sh | bash"
  echo ""
  echo "    Uninstall MyConfig"
  echo ""
  echo "        curl -sLf https://raw.githubusercontent.com/zhongdai/myconfig/master/install.sh | bash -s -- --uninstall"
}

check_requirements () {
  info "Checking Requirements for MyConfig"
  # check git
  if hash "git" &>/dev/null; then
    git_version=$(git --version)
    success "Check Requirements: ${git_version}"
  else
    warn "Check Requirements : git"
  fi
  # check zsh
  if ! command -v zsh >/dev/null 2>&1; then
    warn "Check Requirements: Zsh"
  else
    success "Check Requirements: Zsh"
  fi

  if hash "tmux" &>/dev/null; then
    tmux_version=$(tmux -V)
    success "Check Requirements: ${tmux_version}"
  else
    warn "Check Requirements : git"
  fi

  if hash "vim" &>/dev/null; then
    is_vim8=$(vim --version | grep "Vi IMproved 8")
    is_vim74=$(vim --version | grep "Vi IMproved 7.4")
    if [ -n "$is_vim8" ]; then
      success "Check Requirements: vim 8.0"
    elif [ -n "$is_vim74" ]; then
      success "Check Requirements: vim 7.4"
    else
      if hash "nvim" &>/dev/null; then
        success "Check Requirements: nvim"
      else
        warn "Myconfig need vim 7.4 or above"
      fi
    fi
    if hash "nvim" &>/dev/null; then
      success "Check Requirements: nvim"
    fi
  else
    if hash "nvim" &>/dev/null; then
      success "Check Requirements: nvim"
    else
      warn "Check Requirements : vim or nvim"
    fi
  fi

  # check oh my zsh
  if [[ -d "$HOME/.oh-my-zsh" ]]; then
    success "Check Requirements: Oh My Zsh"
  else
    warn "Check Requirements: Oh My Zsh"
    info "sh -c \"$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)\""
  fi

  # check vundle 
  if [[ -d "$HOME/.vim/bundle/Vundle.vim" ]]; then
    success "Check Requirements: Vundle"
  else
    warn "Check Requirements: Vundle"
    info "git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim"
  fi

}

install_done () {
  echo_with_color ${Yellow} ""
  echo_with_color ${Yellow} "Installed Completed for MyConfig ${Version}"
  echo_with_color ${Yellow} "=============================================================================="
  echo_with_color ${Yellow} "==    Update the ~/.myconfig/secret/alias.sh for sensitive information      =="
  echo_with_color ${Yellow} "=============================================================================="
  echo_with_color ${Yellow} ""
  echo_with_color ${Yellow} ""
}

download_font () {
  url="https://raw.githubusercontent.com/wsdjeg/DotFiles/master/local/share/fonts/$1"
  path="$HOME/.local/share/fonts/$1"
  if [[ -f "$path" ]]
  then
    success "Downloaded $1"
  else
    info "Downloading $1"
    curl -s -o "$path" "$url"
    success "Downloaded $1"
  fi
}

install_fonts () {
  if [[ ! -d "$HOME/.local/share/fonts" ]]; then
    mkdir -p $HOME/.local/share/fonts
  fi
  download_font "DejaVu Sans Mono Bold Oblique for Powerline.ttf"
  download_font "DejaVu Sans Mono Bold for Powerline.ttf"
  download_font "DejaVu Sans Mono Oblique for Powerline.ttf"
  download_font "DejaVu Sans Mono for Powerline.ttf"
  download_font "DroidSansMonoForPowerlinePlusNerdFileTypesMono.otf"
  download_font "Ubuntu Mono derivative Powerline Nerd Font Complete.ttf"
  download_font "WEBDINGS.TTF"
  download_font "WINGDNG2.ttf"
  download_font "WINGDNG3.ttf"
  download_font "devicons.ttf"
  download_font "mtextra.ttf"
  download_font "symbol.ttf"
  download_font "wingding.ttf"
  info "Updating font cache, please wait ..."
  if [ $System == "Darwin" ];then
    if [ ! -e "$HOME/Library/Fonts" ];then
      mkdir "$HOME/Library/Fonts"
    fi
    cp $HOME/.local/share/fonts/* $HOME/Library/Fonts/
  else
    fc-cache -fv > /dev/null
    mkfontdir "$HOME/.local/share/fonts" > /dev/null
    mkfontscale "$HOME/.local/share/fonts" > /dev/null
  fi
  success "font cache done!"
}

config_vim() {
  info "Update vim config"
  success "Successfully Update vim config"
}

config_vim_snippets() {
  info "Update vim snippets"
  success "Successfully Update vim snippets"
}

config_tmux() {
  info "Update tmux config"
  success "Successfully update tmux config"
}

config_zsh() {
  info "Update zsh config"
  success "Successfully update zsh config"
}

fetch_repo () {
  if [[ -d "$HOME/.myconfig" ]]; then
    info "Trying to update MyConfig"
    cd "$HOME/.myconfig"
    git pull
    cd - > /dev/null 2>&1
    success "Successfully update MyConfig"
  else
    info "Trying to clone MyConfig"
    git clone git@github.com:zhongdai/myconfig.git "$HOME/.myconfig"
    success "Successfully clone MyConfig"
  fi
}

main () {
  if [ $# -gt 0 ]
  then
    case $1 in
      --uninstall|-u)
        info "Trying to uninstall MyConfig"
        exit 0
        ;;
      --checkRequirements|-c)
        check_requirements
        exit 0
        ;;
      --install|-i)
        need_cmd 'git'
        need_cmd 'tmux'
        fetch_repo
        install_fonts
        config_zsh
        config_vim
        config_vim_snippets
        config_tmux
        install_done
        exit 0
        ;;
      --help|-h)
        usage
        exit 0
        ;;
      --version|-v)
        msg "${Version}"
        exit 0
    esac
  else
    need_cmd 'git'
    need_cmd 'tmux'
    fetch_repo
    install_fonts
    config_zsh
    config_vim
    config_vim_snippets
    config_tmux
    install_done
  fi
}

main $@
