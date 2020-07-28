# NixFiles

Yuri`s Nix DotFiles

## Usage

- curl http://yurifrl.com/linux/install.sh > install.sh
- chmod +x install.sh
- this will FORMAT your hardrive and download the dotfiles

## Non automated steps

- Loging on keybase
- Loging on chrome
- cachix use ghcide-nix
- krew install --manifest=$HOME/NixFiles/pkgs/krew/krew.yaml
- k krew install ctx
- k krew install ns

## Nixos

Some nix usefull commands

```bash
# Check nix option
nixos-option services.xserve

# Delete old generations
sudo nix-env --delete-generations old

# Garbage collect
nix-collect-garbage -d

# After you garbage collect it clear's cache run search to setup things up
nix search -u

# Open nix repl
nix repl
:l <nixpkgs>

# Tets a single derivation
nix-build -E 'with import <nixpkgs> { };  callPackage ./default.nix {}'
```

## Reference
- Nix Cheat Sheet https://nixos.wiki/wiki/Cheatsheet
- Nix options https://nixos.org/nixos/options.html#
- https://nixos.wiki/wiki/FAQ#How_can_I_install_a_package_from_unstable_while_remaining_on_the_stable_channel.3F
- https://github.com/yrashk/nix-home/blob/master/home.nix
- https://github.com/srid/nix-config/tree/master/nix/home
- nix overlays https://thomashartmann.dev/blog/nix-override-packages-with-overlays/
- https://git.sr.ht/~dcao/dotfiles/tree/72958d2a6dc3e6626a2aa66bbfdd86d2c5f010a9/configuration.nix
- https://git.sr.ht/~euandreh/dotfiles/tree/fff54cb3eb4398a56990ca3d29d658b267718556/nixos/configuration.nix
- Side channel example https://github.com/openlab-aux/vuizvui
- Private nix package with ssh
    - https://www.mpscholten.de/nixos/2016/07/07/private-github-repositories-and-nixos.html
    - https://gist.github.com/cleverca22/ef075e5dfe092fa6b08cec0ae1dfde66
    - https://gist.github.com/dhess/6bbb00100b0fe9b8e17472c0c62bfb10
- SOmething about nix packages http://gfxmonk.net/2018/05/12/a-journey-towards-better-nix-package-development.html
- [Reference nixfiles](https://github.com/sondr3/dotfiles)
- [Nix reference thread](https://discourse.nixos.org/t/how-do-you-organize-your-configuration/7306)
- [Fetch url implementation](https://github.com/NixOS/nixpkgs/blob/master/pkgs/build-support/fetchurl/default.nix)
- [Binaries in nixos](https://nixos.wiki/wiki/Packaging/Binaries)
- [Binaries in nixos 2](https://discourse.nixos.org/t/how-to-install-github-released-binary/1328)

## Licencing

MIT license.
