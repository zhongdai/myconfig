# My Config

This is a tool to manage my dotfiles, and help me easy to migrate the toolkit from one computer to
another computer. This is tested only for Mac OS system.

What does it do?

- Check requirements to see if all tools / commands are installed
- Sync `.vimrc` and `.tmux.conf` file
- Added additional config to `.oh-my-zsh/custom` folder and overwrite config of `.zshrc`
- Download fonts and install them
- Sync user settings and snippets for VS Code
- Sync vim snippets (In Progress)
- Install pre-defined VS Code extension (Optional)

## Installation

- Install required Softwares
```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install zsh zsh-completions
brew install tig
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
```

- Check requirements
```bash
curl -sLf https://raw.githubusercontent.com/zhongdai/myconfig/master/install.sh | bash -s -- -c
```

- Install MyConfig
```bash
curl -sLf https://raw.githubusercontent.com/zhongdai/myconfig/master/install.sh | bash
```

- Uninstall MyConfig
```bash
curl -sLf https://raw.githubusercontent.com/zhongdai/myconfig/master/install.sh | bash -s -- --uninstall
```

- Install VS Code Extension
```bash
curl -sLf https://raw.githubusercontent.com/zhongdai/myconfig/master/install.sh | bash -s -- --vscode
```