{ pkgs }:

let
  basic = with pkgs; [
    findutils
    tree
    unzip
    wget
    zstd
  ];

  bin = import ./bin.nix {
    inherit pkgs;
  };

  buildTools = with pkgs; [
    cmake
  ];

  databaseTools = with pkgs; [ ];

  devOpsTools = with pkgs; [ ];

  versionControlTools = (with pkgs; [
    # difftastic
    # git-crypt
  ] ++ (with gitAndTools; [
    # diff-so-fancy
    # gitflow
  ]));

  jsTools = (with pkgs; [
    nodejs
  ] ++ (with nodePackages; [
    pnpm
  ]));

  docsTools = with pkgs; [ ];

  misc = with pkgs; [
    bottom
    ffmpeg
    jq
    protobuf
    uutils-coreutils
  ];

  nixTools = with pkgs; [
    dvt
    #ephemera
    fh
    flake-checker
    flake-iter
    linux-builder
    nixfmt-classic
    nixpkgs-fmt
  ];

  pythonTools = with pkgs; [ rye ];

  rustTools = with pkgs; [
    rustc
    rustfmt
    clippy
    cargo
    rust-analyzer
    just
  ];

  scripts = with pkgs; [
    (writeScriptBin "pk" ''
      if [ $# -eq 0 ]; then
        echo "No process name supplied"
      fi

      for proc in $1; do
        pgrep -f $proc | xargs kill -9
      done
    '')
  ];

  security = with pkgs; [ ];
in
basic
++ bin
++ buildTools
++ databaseTools
++ devOpsTools
++ docsTools
++ jsTools
++ misc
++ nixTools
++ pythonTools
++ rustTools
++ scripts
++ security
++ versionControlTools
++ pkgs.unstable
