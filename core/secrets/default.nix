{ config, pkgs, ... }:

with import <nixpkgs> {};
with builtins;
with lib;
let
  home-manager = builtins.fetchGit {
    url = "https://github.com/rycee/home-manager.git";
    ref = "release-19.03";
  };
  dag = import "${home-manager}/modules/lib/dag.nix" {
    inherit lib;
  };
  keybase = "$HOME/Keybase/private/yurifrl";
in {
    # environment = {
    #     etc."NetworkManager/system-connections/some.nmconnection" = {
    #         source = /home/yuri/Keybase/private/yurifrl/home/DFTECH.nmconnection;
    #         mode = "0400";
    #     };
    # };
    home-manager.users.yuri = { pkgs, ... }: {
        home = {
            activation.createLinks = dag.dagEntryAfter ["writeBoundary"] ''
                ln -sfn ${keybase}/home/ssh $HOME/.ssh
                ln -sfn ${keybase}/home/docker $HOME/.docker
                #ln -sfn ${keybase}/home/kube $HOME/.kube
            '';
        };
    };
}
