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
read -p "zsh config, continue? (Y/N): " confirm
if [[ $confirm =~ ^[Yy]$ ]]; then
    echo "==> zsh config ---------------------------------------"
    user-install "oh-my-zsh" "-d $HOME/.oh-my-zsh" 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"'
    user-install "zsh-syntax-highlighting" "-d $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" "git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
    user-install "zsh-autosuggestions" "-d $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" "git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
    user-link "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
fi

# # ==> vim config -----------------------------------------------
# read -p "vim config, continue? (Y/N): " confirm
# if [[ $confirm =~ ^[Yy]$ ]]; then
#     echo "==> vim config ----------------------------------------"
#     user-install "vim-plug" "-f $HOME/.vim/autoload/plug.vim" "curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
#     user-link "$DOTFILES/vim/vimrc" "$HOME/.vimrc"
# fi

# ==> neovim config -----------------------------------------------
read -p "neovim config, continue? (Y/N): " confirm
if [[ $confirm =~ ^[Yy]$ ]]; then
    echo "==> neovim config ----------------------------------------"
    export PATH=$DOTFILES:$PATH
    mkdir -p $HOME/.config/nvim
    user-install "vim-plug" "-f $HOME/.local/share/nvim/site/autoload/plug.vim" " curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim "
    user-link "$DOTFILES/vim/.vimrc" "$HOME/.config/nvim/init.vim"
fi

# ==> tmux config -----------------------------------------------
read -p "tmux config, continue? (Y/N): " confirm
if [[ $confirm =~ ^[Yy]$ ]]; then
    echo "==> tmux config ---------------------------------------"
    user-link "$DOTFILES/tmux/.tmux.conf" "$HOME/.tmux.conf"
fi

# ==> git config -----------------------------------------------
read -p "git config, continue? (Y/N): " confirm
if [[ $confirm =~ ^[Yy]$ ]]; then
    echo "==> git config -----------------------------------------"
    user-link "$DOTFILES/git/.gitignore" "$HOME/.gitignore"
    user-link "$DOTFILES/git/.gitconfig" "$HOME/.gitconfig"
fi

echo "done!"
exit 0
