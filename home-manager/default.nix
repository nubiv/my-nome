{ pkgs
, stateVersion
, username
}:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";
    users.${username} = { pkgs, ... }: {
      home = {
        inherit (pkgs.lib) homeDirectory;
        packages = import ./packages.nix { inherit pkgs; };
        sessionPath = [
          "${pkgs.uutils-coreutils}/bin" # Use Rust coreutils
        ];
        sessionVariables = import ./env.nix { inherit pkgs username; };
        shellAliases = (import ./aliases.nix { inherit pkgs; }).shell;
        file = {
          ".ssh/config" = {
            source = ./config/ssh/config;
            # mode = "0600";
          };
        };
        inherit stateVersion username;
      };
      imports = [ ];
      programs = import ./programs.nix { inherit pkgs; };
    };
  };
}
