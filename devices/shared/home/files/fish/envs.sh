# My Term
set -gx TERM st-256color

#
set -gx EDITOR /usr/bin/vim
# set -gx EDITOR /home/yuri/.bin/e
set -gx XDG_DATA_HOME "$HOME/.local/share"

#
set -gx HISTTIMEFORMAT "%d/%m/%y %T "

# For lynx
set -gx WWW_HOME "https://google.com"

# Helm
set -gx HELM_HOME "$HOME/.helm"

#
set -gx MYVIMRC "$HOME/.vimrc"

#
set -gx CTRLP_IGNORE "*/tmp/*,*/git/*,*/node_modules/*,*/bower_components/*,*.so,*.swp,*.zip,*/deps,*/_build,*/_site,*/.deploy,*/.sass-cache,*/.pygments-cache,*/_deploy,*/cover,*/coverage"

# BIN
set -gx LOCAL_BIN "$HOME/.bin"
set -gx SYSTEM_BIN "/usr/local/bin"

# GO
set -gx GOPATH "$HOME/Workspace"
set -gx GOPATH "$HOME/.go" $GOPATH
set -gx GO111MODULE "on"

# PATH
set -gx PATH "$GEMS_PATH" $PATH
set -gx PATH "$HOME/.go/bin" $PATH
set -gx PATH "$HOME/Workspace/bin" $PATH
set -gx PATH "$LOCAL_BIN" $PATH
set -gx PATH "/var/lib/flatpak/exports/bin" $PATH
set -gx PATH "/var/lib/snapd/snap/bin" $PATH
set -gx PATH "$SYSTEM_BIN" $PATH
set -gx PATH "$NODE_BIN" $PATH

# Go Envs
set -gx GOOS linux
set -gx CGO_ENABLED 0

# Load Secrets
set -gx KEYBASE_ENVS "/keybase/private/yurifrl/envs"

if test -e $KEYBASE_ENVS
   ev -q $KEYBASE_ENVS
end
