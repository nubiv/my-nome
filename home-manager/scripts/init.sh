# Run the env.sh script (if it exists). That script is meant to contain secrets, tokens, and
# other things you don't want to put in your Nix config. This is quite "impure" but a
# reasonable workaround.
if [ -e ~/.env.sh ]; then
  . ~/.env.sh
fi

eval "$(ssh-agent -s)"
# ssh-add ~/.ssh/nubiv

# Shell completion for various tools
eval "$(determinate-nixd completion zsh)"

# Specific to FlakeHub dev
export ENVRC_USE_FLAKE="1"

export CARGO_NET_GIT_FETCH_WITH_CLI="true"

export http_proxy='http://127.0.0.1:7891'
export https_proxy='http://127.0.0.1:7891'

# Vi-style keybindings in Zsh
bindkey -v
