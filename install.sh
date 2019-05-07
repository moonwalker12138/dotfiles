echo "==> install dotfiles"
git clone https://github.com/moonwalker12138/dotfiles.git $HOME/.dotfiles

echo "==> install oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "==> install zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "==> install zsh-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "==> zsh configuration"
if [ -f $HOME/.zshrc ]; then
    mv $HOME/.zshrc $HOME/.zshrc.backup
fi
ln -s $HOME/.dotfiles/zsh/zshrc $HOME/.zshrc
source $HOME/.zshrc

echo "==> vim configuration"
curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
if [ -f $HOME/.vimrc ]; then
	mv $HOME/.vimrc $HOME/.vimrc_backup
fi
ln -s $HOME/.dotfiles/vim/vimrc $HOME/.vimrc
ln -s $HOME/.dotfiles/vim/colors $HOME/.vim/colors
vim +PlugInstall

echo "==> git configuration"
if [ -f $HOME/.gitconfig ]; then 
	mv $HOME/.gitconfig $HOME/.gitconfig_backup
fi
ln -s $HOME/.dotfiles/git/gitconfig $HOME/.gitconfig
if [ -f $HOME/.gitignore ]; then
	mv $HOME/.gitignore $HOME/.gitignore_backup
fi
ln -s $HOME/.dotfiles/git/gitignore $HOME/.gitignore

echo "bye!"
