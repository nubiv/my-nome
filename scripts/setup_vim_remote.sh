#!/bin/bash

set -e

REMOTE="${1:?Usage: $0 user@host}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
VIM_CONFIG="$REPO_ROOT/home-manager/config/vim"

echo "Rsyncing vim config to $REMOTE..."
rsync -av "$VIM_CONFIG/.vimrc" "$REMOTE:~/.vimrc"
rsync -av "$VIM_CONFIG/.vim/colors/" "$REMOTE:~/.vim/colors/"

echo "Cloning plugins on $REMOTE..."
ssh "$REMOTE" bash <<'EOF'
set -e
PACK_DIR="$HOME/.vim/pack/vendor/start"
mkdir -p "$PACK_DIR"

if [ ! -d "$PACK_DIR/nerdtree" ]; then
    git clone https://github.com/preservim/nerdtree.git "$PACK_DIR/nerdtree"
else
    echo "nerdtree already installed, skipping"
fi

if [ ! -d "$PACK_DIR/vim-commentary" ]; then
    git clone https://github.com/tpope/vim-commentary.git "$PACK_DIR/vim-commentary"
else
    echo "vim-commentary already installed, skipping"
fi
EOF

echo "Done."
