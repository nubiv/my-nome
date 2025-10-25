#!/bin/sh

set -e

nix develop \
  --extra-experimental-features 'flakes nix-command' \
  --command "reload"

cp -r ./home-manager/config/vim/.vim ~/.vim
cp ./home-manager/config/vim/.vimrc ~/.vimrc