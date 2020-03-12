# Base16 Shell
#
# Automatically install fundle if not installed
if not functions -q fundle; eval (curl -sfL https://git.io/fundle-install); end

# Plugins
fundle plugin 'yurifrl/fish-theme-afowler'
fundle plugin 'joehillen/ev-fish'
fundle plugin 'edc/bass'

# Init Fundle
fundle init

# Envs
set -gx DOT_FILES ~/NixFiles

source "$HOME/.config/fish/config/envs.fish"
source "$HOME/.config/fish/config/aliases.fish"
