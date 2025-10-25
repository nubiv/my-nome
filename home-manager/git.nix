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
    user = {
      signingkey =
        let
          hostname = pkgs.constants.username;
          keys = {
            nubiv = "125C140B6EE4E618";
            horus = "D2EC05A229F95E48";
          };
        in
        builtins.getAttr hostname keys;
    };
  };
  userName = pkgs.constants.username;
  userEmail = "h.horace0921@gmail.com";
  package = pkgs.gitAndTools.gitFull;
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
}
