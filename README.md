# Dotfiles

## 下载 dotfiles
```
git clone https://github.com/moonwalker12138/dotfiles.git ~/.dotfiles
```

## zsh 配置
- 安装 oh-my-zsh
``` 
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

- 安装 zsh-syntax-highlighting
```
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

- 安装 zsh-autosuggestions
```
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

- zshrc
```
cp ~/.dotfiles/.zshrc ~/.zshrc
```
```
source ~/.zshrc
```

- 设置 zsh 为默认 shell（Optional）
```
chsh -s $(which zsh)
```

## vim 配置

- 安装 neovim
```
curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
```
```
chmod u+x nvim.appimage
```

- 安装 vim-plug
```
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

- vimrc
```
cp ~/.dotfiles/.vimrc ~/.vimrc
```
```
ln -s ~/.vimrc ~/.config/nvim/init.vim
```
```
neovim +PlugInstall
```

## tmux 配置

- tmux.conf
```
cp ~/.dotfiles/.tmux.conf ~/.tmux.conf
```
```
tmux source ~/.tmux.conf
```

# git 配置

- gitconfig
```
cp ~/.dotfiles/.gitconfig ~/.gitconfig
```