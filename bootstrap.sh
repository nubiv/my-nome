#!/bin/sh

set -e

HOSTNAME="nubiv"

while getopts "h:" opt; do
  case $opt in
    h)
      HOSTNAME="$OPTARG"
      ;;
    *)
      echo "Usage: $0 [-h hostname]"
      exit 1
      ;;
  esac
done

nix develop \
  --extra-experimental-features 'flakes nix-command' \
  --command "reload" \

cp -r ./home-manager/config/vim/.vim ~/.vim
cp ./home-manager/config/vim/.vimrc ~/.vimrc