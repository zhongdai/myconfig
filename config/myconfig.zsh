# The custom file for zsh to override setting in .zshrc
plugins=(git docker)
TERM="xterm-256color"
export LANG=en_US.UTF-8
export UPDATE_ZSH_DAYS=30

### Alias ###
alias zshconfig="vi $HOME/.zshrc"
alias ohmyzsh="vi $HOME/.oh-my-zsh"


### Source ###

# The entry of myconfig
source $HOME/.myconfig/init.sh