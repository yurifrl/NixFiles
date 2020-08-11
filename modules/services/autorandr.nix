{ config, pkgs, ... }:

# https://github.com/kalbasit/shabka/blob/master/modules/home/workstation/autorandr.nix
{
  config.programs.autorandr = {
    enable = true;

    hooks = {
      postswitch = mkMerge [
        {
          "move-workspaces-to-main" = ''
            set -euo pipefail

            # Make sure that i3 is running
            if [[ "$( ${getBin pkgs.i3}/bin/i3-msg -t get_outputs | ${getBin pkgs.jq}/bin/jq -r '.[] | select(.active == true) | .name' | wc -l )" -eq 1 ]]; then
              echo "no other monitor, bailing out"
              exit 0
            fi

            # Figure out the identifier of the main monitor
            readonly main_monitor="$( ${getBin pkgs.i3}/bin/i3-msg -t get_outputs | ${getBin pkgs.jq}/bin/jq -r '.[] | select(.active == true and .primary == true) | .name' )"

            # Get the list of workspaces that are not on the main monitor
            readonly workspaces=( $(${getBin pkgs.i3}/bin/i3-msg -t get_workspaces | ${getBin pkgs.jq}/bin/jq -r '.[] | select(.output != "''${main_monitor}") | .name') )
          '';
        }
      ];
    };
  };

}