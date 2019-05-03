# The entry of my own .zshrc config
# supposed to be source at the end of ~/.zshrc

if [ -z "$_INIT_SH_LOADED" ]; then
    _INIT_SH_LOADED=1
else
    return
fi

# add personal bins to the PATH
if [ -d "$HOME/.myconfig/bin" ]; then
    export PATH="$HOME/.myconfig/bin:$PATH"
fi


# Source utils
source $HOME/.myconfig/utils/m.sh