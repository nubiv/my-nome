rec {
  nix = {
    path = ./nix;
    description = "Nix template";
  };

  vs = vscode;

  vscode = {
    path = ./vscode;
    description = "VS Code settings template";
  };
}
