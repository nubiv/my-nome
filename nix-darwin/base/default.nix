{ overlays
, pkgs
, ...
}:

{
  # Disable system-config for fast deploy, mostly used for new machine initial setup
  # system-config = { pkgs, ...}: import ./system.nix {
  #	inherit pkgs;
  #	};

  documentation.enable = true;

  fonts.packages = pkgs.fonts.packages;

  networking.computerName = "${pkgs.constants.username}-${pkgs.constants.system}";

  # Let Determinate Nix handle Nix configuration
  nix.enable = false;

  determinate-nix.customSettings = {
    lazy-trees = true;
  };

  nixpkgs = {
    config = {
      allowBroken = true;
      allowUnfree = true;
      allowUnsupportedSystem = true;
    };
    inherit overlays;
  };

  programs = {
    ssh = {
      knownHosts = {
        # nixbuild = {
        #   hostNames = [ "xxxx" ];
        #   publicKey = "ssh-ed25519 xxxxxx";
        # };
      };
    };

    zsh.enable = true;
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  system.stateVersion = 5;
  system.primaryUser = pkgs.constants.username;

  users.users.${pkgs.constants.username} = {
    name = pkgs.constants.username;
    home = pkgs.lib.homeDirectory;
    shell = pkgs.zsh;
  };

  # homebrew need to be installed manually, see https://brew.sh
  # https://github.com/LnL7/nix-darwin/blob/master/modules/homebrew.nix
  homebrew = {
    enable = false; # disable homebrew for fast deploy

    onActivation = {
      autoUpdate = true;
      # 'zap': uninstalls all formulae(and related files) not listed in the generated Brewfile
      # cleanup = "uninstall";
    };

    # Applications to install from Mac App Store using mas.
    # You need to install all these Apps manually first so that your apple account have records for them.
    # otherwise Apple Store will refuse to install them.
    # For details, see https://github.com/mas-cli/mas
    masApps = { };

    taps = [
      #"homebrew/cask-fonts"
      # "homebrew/services"
      #"homebrew/cask-versions"
      # "shelken/tap" # self tap

      # "hashicorp/tap" # terraform
      # "FelixKratz/formulae" # jankyborders
      # "localsend/localsend" # localsend
      # "gromgit/fuse" # macfuse,mounty
      # "he3-app/he3" # he3
      # "nikitabobko/tap" # aerospace
      # "bigwig-club/brew" # upic
    ];

    brews = [
      # `brew install`
      # "wget" # download tool
      "curl" # no not install curl via nixpkgs, it's not working well on macOS!
      # "aria2" # download tool
      # "httpie" # http client

      # https://github.com/rgcr/m-cli
      # "m-cli" #  Swiss Army Knife for macOS
      # "proxychains-ng"
      # `sudo tailscaled install-system-daemon`
      # "tailscale"

      # commands like `gsed` `gtar` are required by some tools
      # "gnu-sed"
      # "gnu-tar"

      # misc that nix do not have cache for.
      # "git-trim"
      # "terraform"

      # "python@3.12"
      # janky borders; for yabai; need macOS 14+
      # "borders"
    ];

    # `brew install --cask`
    casks = [
      "feishu"
      "chatgpt"
      "wpsoffice"
      # "squirrel" # input method for Chinese, rime-squirrel

      # IM & audio & remote desktop & meeting
      # "discord"
      # "rustdesk"
      "jordanbaird-ice"
      "snipaste"
      "arc"
      "warp"
      "aldente"

      # Misc
      # "raycast" # macOS 12+ (HotKey: alt/option + space)search, calculate and run scripts(with many plugins)
      "stats" # beautiful system status monitor in menu bar
      # "appcleaner" # app uninstall
      # "pearcleaner" # pearcleaner
      # "applite" # homebrew ui; need macOS 13+
      # "hiddenbar" # menubar plugin
      # "picgo" # picbed
      "the-unarchiver" # zip,unzip
      # "localsend"
      # "adrive"  # 阿里云盘
      # "hackintool"  # hackintosh
      # "shortcutdetective"  # 检查快捷键
      # "barrier"  # 跨屏键鼠
      # "cleanmymac"  # 清理

      # read pdf,...
      # "koodo-reader"

      # keyborader
      "karabiner-elements" # 快捷键映射
      # "keyboardholder" # 不同应用自动切输入法
      # "keyclu" # shortcut viewer

      # network
      # "clashx-meta" 
      # "tailscale"
      # "lulu" # firewall

      # sync file
      # "syncthing" # 数据同步
      # "resilio-sync"

      # quicklook
      # "qlmarkdown"
      # "syntax-highlight"

      # Development
      # "iterm2"
      # "kitty"
      # "wezterm"
      # "navicat-premium" mysql...
    ];
  };
}
