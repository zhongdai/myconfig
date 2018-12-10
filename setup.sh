#!/usr/local/bin/zsh


# create alias for git command
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.unstage 'reset HEAD --'
git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"


# install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Link the config files to ~
if [ -e ~/.vimrc ]; then
	if [ -L ~/.vimrc ]; then
		echo "Delete the link file ~/.vimrc"
		rm ~/.vimrc
	else
		echo "Backup the file to ~/.vimrc.backup"	
		mv ~/.vimrc ~/.vimrc.backup
	fi
	echo "Create the new link file"
	ln -s $(pwd)/_vimrc ~/.vimrc
else
	echo "Create the new link file"
	ln -s $(pwd)/_vimrc ~/.vimrc
fi

if [ -e ~/.tmux.conf ]; then
	if [ -L ~/.tmux.conf ]; then
		echo "Delete the link file ~/.tmux.conf"
		rm ~/.tmux.conf
	else
		echo "Backup the file to ~/.tmux.conf.backup"	
		mv ~/.tmux.conf ~/.tmux.conf.backup
	fi
	echo "Create the new link file"
	ln -s $(pwd)/_tmux.conf ~/.tmux.conf
else
	echo "Create the new link file"
	ln -s $(pwd)/_tmux.conf ~/.tumx.conf
fi


# Mac special handling 

if [ $(uname) = "Darwin" ]; then
	# enable holding the key
	defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
fi
