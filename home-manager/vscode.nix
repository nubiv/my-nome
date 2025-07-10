{ pkgs }:

let
  # Helper function
  vsce = publisher: name: version: sha256: pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = { inherit name publisher sha256 version; };
  };
in
{
  enable = false;

  profiles.default = {
    enableExtensionUpdateCheck = true;

    extensions =
      (with pkgs.vscode-extensions; [
        b4dm4n.vscode-nixpkgs-fmt
        bbenoist.nix
        esbenp.prettier-vscode
        mkhl.direnv
        ms-python.python
        rust-lang.rust-analyzer
        tamasfe.even-better-toml
        thenuprojectcontributors.vscode-nushell-lang
        yzhang.markdown-all-in-one
        vscodevim.vim
      ]) ++ [
        # Extensions not in Nixpkgs
        # (vsce
        #   "github"
        #   "github-copilot"
        #   "1.341.0"
        #   "")
        # (vsce
        #   "github"
        #   "github-copilot-chat"
        #   "0.28.5"
        #   "")
        # (vsce "binaryify" "one-dark-pro" "3.19.0" "")
      ];

    globalSnippets = { };

    keybindings = [ ];

    userSettings = {
      "[markdown]" = {
        "editor.defaultFormatter" = "yzhang.markdown-all-in-one";
        "editor.formatOnSave" = true;
      };
      "[nix]" = {
        "editor.defaultFormatter" = "B4dM4n.nixpkgs-fmt";
        "editor.formatOnSave" = true;
      };
      "[rust]" = {
        "editor.defaultFormatter" = "rust-lang.rust-analyzer";
        "editor.formatOnSave" = true;
      };
      "[toml]" = {
        "editor.defaultFormatter" = "tamasfe.even-better-toml";
        "editor.formatOnSave" = true;
      };
      "editor.wordWrap" = "wordWrapColumn";
      "editor.wordWrapColumn" = 120;
      "search.exclude" = {
        "**/.direnv" = true;
        "**/.git" = true;
        "**/node_modules" = true;
        "*.lock" = true;
        "dist" = true;
        "tmp" = true;
      };
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
      "rust-analyzer.server.path" = "rust-analyzer";
      #   "terminal.integrated.fontFamily" = pkgs.fonts.vscode.terminal;
      "window.autoDetectColorScheme" = true;
      #   "workbench.iconTheme" = pkgs.themes.vscode.icon;
      #   "workbench.preferredLightColorTheme" = pkgs.themes.vscode.light;
      #   "workbench.preferredDarkColorTheme" = pkgs.themes.vscode.dark;
      # Vim config
      "editor.cursorBlinking" = "smooth";
      "vim.leader" = "<space>";
      "vim.normalModeKeyBindings" = [
        {
          "before" = [ "leader" "w" ];
          "commands" = [ "workbench.action.files.save" ];
        }
        {
          "before" = [ "leader" "e" ];
          "commands" = [ "workbench.action.toggleSidebarVisibility" ];
        }
        {
          "before" = [ "leader" "f" ];
          "commands" = [
            {
              "command" = "workbench.action.toggleFullScreen";
            }
          ];
        }
        {
          "before" = [ "leader" "m" ];
          "commands" = [
            "workbench.action.togglertatusbarVisibility"
            "workbench.action.toggleActivityBarVisibility"
          ];
        }
      ];
      "vim.insertModeKeyBindings" = [
        {
          "before" = [ "j" "k" ];
          "after" = [ "<Esc>" ];
        }
      ];
      "vim.visualModeKeyBindings" = [
        {
          "before" = [ ">" ];
          "commands" = [ "editor.action.indentLines" ];
        }
        {
          "before" = [ "<" ];
          "commands" = [ "editor.action.outdentLines" ];
        }
      ];
    };
  };

  mutableExtensionsDir = false;
}
