# The custom file for zsh to override setting in .zshrc
plugins=(git docker)
TERM="xterm-256color"
export LANG=en_US.UTF-8
export UPDATE_ZSH_DAYS=30

### Alias ###
alias zshconfig="vi $HOME/.zshrc"
alias ohmyzsh="vi $HOME/.oh-my-zsh"
alias sourceit="source $HOME/.zshrc"


alias updatecfg="curl -sLf https://raw.githubusercontent.com/zhongdai/myconfig/master/install.sh | bash"


### Source ###

# load separate modules from the utils folder
source $HOME/.myconfig/utils/m.sh
