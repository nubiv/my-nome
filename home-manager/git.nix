{ pkgs }:

{
  enable = true;

  aliases = (import ./aliases.nix { inherit pkgs; }).git;
  delta = { enable = true; };
  extraConfig = {
    core = {
      editor = "vim";
      whitespace = "trailing-space,space-before-tab";
    };
    credential.helper = "osxkeychain";
    commit.gpgsign = "true";
    gpg.program = "gpg2";
    init.defaultBranch = "main";
    protocol.keybase.allow = "always";
    pull.rebase = "false";
    user = { signingkey = "D2EC05A229F95E48"; };
  };
  ignores = [
    ".cache/"
    ".DS_Store"
    ".direnv/"
    ".jj/"
    "*.swp"
    "built-in-stubs.jar"
    "dumb.rdb"
    ".vscode/"
    "npm-debug.log"
  ];
  lfs = { enable = true; };
  package = pkgs.gitAndTools.gitFull;
  userEmail = "h.horace0921@gmail.com";
  userName = "nubiv";
}
