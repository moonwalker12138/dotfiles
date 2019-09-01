#!/bin/bash

DOTFILES=$HOME/.dotfiles
git stash
git fetch

if [ "$1" = "zsh" ]; then
    git checkout origin/master -- $dotfiles/zsh/zshrc
elif [ "$1" = "vim" ]; then
    git checkout origin/master -- $dotfiles/vim/vimrc
elif [ "$1" = "tmux" ]; then
    git checkout origin/master -- $dotfiles/tmux/tmux.conf
elif [ "$1" = "git" ]; then
    git checkout origin/master -- $dotfiles/git
fi
