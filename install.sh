#!/bin/bash

user-install(){
    read -p "[user-install]install $1? (Y/N): " confirm
    if [[ $confirm =~ ^[Yy]$ ]]; then
        if [ $2 ]; then
            read -p "[user-install]$1 has already been installed, reinstall? (Y/N): " confirm
            if [[ $confirm =~ ^[Yy]$ ]]; then
                rm -rf $2
                eval $3
            fi
        else
            eval $3
        fi
        if [ $? -ne 0 ]; then
            echo "[user-install]$1 installation failed!"
            exit 1
        else
            echo "[user-install]$1 installation succeeded!"
        fi
    fi 
}

user-link(){
    echo $1 $2
    read -p "create a symbolic link '$2' to '$1'? (Y/N): " confirm
    if [[ $confirm =~ ^[Yy]$ ]]; then
        if [ -f $2 ]; then
            mv $2 $2.backup
        fi
        ln -fs $1 $2
        if [ $? -ne 0 ]; then
            echo "[user-link]create a symbolic link '$2' to '$1' failed!"
            exit 1
        else
            echo "[user-link]create a symbolic link '$2' to '$1' succeeded!"
        fi
    fi
}

DOTFILES=$HOME/.dotfiles
# ==> zsh conifg ------------------------------------------------
echo "==> zsh config ---------------------------------------"
user-install "oh-my-zsh" "-d $HOME/.oh-my-zsh" 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"'
user-install "zsh-syntax-highlighting" "-d $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" "git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
user-install "zsh-autosuggestions" "-d $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" "git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
user-link "$DOTFILES/zsh/zshrc" "$HOME/.zshrc"

==> vim config -----------------------------------------------
echo "==> vim config ----------------------------------------"
user-install "vim-plug" "-f $HOME/.vim/autoload/plug.vim" "curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
user-link "$DOTFILES/vim/vimrc" "$HOME/.vimrc"
vim +PlugInstall

# # ==> dotfiles settings ----------------------------------------------------
# for file in `find $HOME/.dotfiles -name '*.symlink'`
# do
#     target=$(basename $file)
#     target=${HOME}/.dotfiles/.${target/.symlink/}
#     # target=$(basename $file)
#     # target=./.${target/.symlink/}
#     if [ -f $target ]; then
#         mv $target ${target}.backup
#     fi
#     ln -s $file $target
# done
# VIMCOLORS=$HOME/.vim/colors
# if [ -d $VIMCOLORS ]; then
#     mv $VIMCOLORS ${VIMCOLORS}.backup
# fi
# ln -s $HOME/.dotfiles/vim/colors $VIMCOLORS
# echo "dotfiles settings succeeded!"


# read -p "continue? (Y/N): " confirm

# if [ $confirm = "yes" ]; then
#     echo install
# else
#     echo fine
# fi

# if [ -d "$HOME/.dotfiles" ]; then
#     echo success
# else
#     echo fail
# fi

# if [ -d "$HOME/.oh-my-zsh" ]; then
#     echo already install oh-my-zsh
# fi






# echo "==> install dotfiles"
# git clone https://github.com/moonwalker12138/dotfiles.git $HOME/.dotfiles

# echo "==> install oh-my-zsh"
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# echo "==> install zsh-autosuggestions"
# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# echo "==> install zsh-syntax-highlighting"
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# echo "==> zsh configuration"
# if [ -f $HOME/.zshrc ]; then
#     mv $HOME/.zshrc $HOME/.zshrc.backup
# fi
# ln -s $HOME/.dotfiles/zsh/zshrc $HOME/.zshrc
# source $HOME/.zshrc

# echo "==> vim configuration"
# curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# if [ -f $HOME/.vimrc ]; then
# 	mv $HOME/.vimrc $HOME/.vimrc_backup
# fi
# ln -s $HOME/.dotfiles/vim/vimrc $HOME/.vimrc
# ln -s $HOME/.dotfiles/vim/colors $HOME/.vim/colors
# vim +PlugInstall

# echo "==> git configuration"
# if [ -f $HOME/.gitconfig ]; then 
# 	mv $HOME/.gitconfig $HOME/.gitconfig_backup
# fi
# ln -s $HOME/.dotfiles/git/gitconfig $HOME/.gitconfig
# if [ -f $HOME/.gitignore ]; then
# 	mv $HOME/.gitignore $HOME/.gitignore_backup
# fi
# ln -s $HOME/.dotfiles/git/gitignore $HOME/.gitignore

# echo "bye!"
