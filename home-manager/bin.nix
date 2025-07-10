{ pkgs }:

let
  inherit (pkgs.lib) fakeHash;

in
[
  (pkgs.writeScriptBin "random-nix-hash" ''
    nix hash convert --hash-algo sha1 --to nix32 $(openssl rand -hex 20 | sha1sum | awk '{print $1}')
  '')

  (pkgs.writeScriptBin "random-sha256-hash" ''
    echo -n "$(head -c 32 /dev/urandom)" | openssl dgst -sha256 -binary | openssl base64 | awk '{print "sha256-" $1}'
  '')
]
