{ pkgs }:

{
  enable = true;

  extraConfig = (builtins.readFile ./config/vim/.vimrc);

  # Vim plugins
  plugins = with pkgs.vimPlugins; [
    # catppuccin-nvim
    # ctrlp
    # editorconfig-vim
    # gruvbox
    # nerdtree
    # tabular
    # vim-cpp-enhanced-highlight
    # vim-nix
  ];
}
