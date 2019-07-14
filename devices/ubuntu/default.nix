{ pkgs ? import <nixpkgs> {}
, stdenv ? pkgs.stdenv
, config ? pkgs.config
}:

let
  # These are the actual dotfiles. They can be patched with Nix variables
  # home = import ../../core/home/default.nix {
  #   inherit (pkgs) pkgs config;
  # };

  #
  core = import ../../core/default.nix {
    inherit pkgs config;
  };
in stdenv.mkDerivation rec {
  name = "install";
  buildInputs = [ core ];
}
