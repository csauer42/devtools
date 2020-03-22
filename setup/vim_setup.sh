#!/bin/bash

sudo apt install \
    vim \
    vim-addon-manager \
    vim-airline \
    vim-airline-themes \
    vim-asciidoc \
    vim-common \
    vim-fugitive \
    vim-runtime \
    vim-syntastic \
    vim-tiny

if [ -f vimrc ]; then
    cp vimrc ~/.vimrc
fi
