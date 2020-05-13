#!/usr/bin/env fish

# My Term
set -gx TERM st-256color

#
set -gx EDITOR vim
# set -gx EDITOR /home/yuri/.bin/e
set -gx XDG_DATA_HOME "$HOME/.local/share"

#
set -gx HISTTIMEFORMAT "%d/%m/%y %T "

# Disable rename for tmux
set -gx DISABLE_AUTO_TITLE "true"

# For lynx
set -gx WWW_HOME "https://google.com"

# Helm
set -gx HELM_HOME "$HOME/.helm"

#
set -gx MYVIMRC "$HOME/.vimrc"

#
set -gx CTRLP_IGNORE "*/tmp/*,*/git/*,*/node_modules/*,*/bower_components/*,*.so,*.swp,*.zip,*/deps,*/_build,*/_site,*/.deploy,*/.sass-cache,*/.pygments-cache,*/_deploy,*/cover,*/coverage"#

# BIN
set -gx LOCAL_BIN "$HOME/.bin"
set -gx SYSTEM_BIN "/usr/local/bin"

# GO
set -gx GOPATH "$HOME/.go:$HOME/Workdir"
set -gx GOBIN "$HOME/.go/bin"

set -gx GO111MODULE "on"

# Java
# set -gx JAVA_HOME (readlink -e (type -p java) | sed  -e 's/\/bin\/java//g')
set -gx JDK_HOME /nix/store/0j92w9fh2kg5r48m0ymz2p6ji1f02ka4-openjdk-8u242-b08/

# PATH
set -gx PATH "/usr/local/go/bin" $PATH
#set -gx PATH "$GEMS_PATH" $PATH
set -gx PATH "$HOME/.go/bin" $PATH
set -gx PATH "$HOME/Workdir/bin" $PATH
set -gx PATH "$HOME/.local/bin" $PATH
set -gx PATH "$LOCAL_BIN" $PATH
set -gx PATH "$SYSTEM_BIN" $PATH
#set -gx PATH "$NODE_BIN" $PATH
# https://github.com/haskell/ghcup/tree/ad91509d28af967b48e667f07cc690c21b707742#installation
set -gx PATH "$HOME/.cabal/bin" $PATH
set -gx PATH "$HOME/.ghcup/bin" $PATH
# Krew
set -gx PATH "$HOME/.krew/bin" $PATH
# Kubebuilder
set -gx PATH "/usr/local/kubebuilder/bin" $PATH

# Go Envs
set -gx GOOS linux
set -gx CGO_ENABLED 0

# Use local helm
#set -gx HELM_HOST "localhost:44134"

# Load Secrets
#set -gx KEYBASE_ENVS "$HOME/Keybase/private/yurifrl/envs"

if test -e $KEYBASE_ENVS
   ev -q "$HOME/Keybase/private/yurifrl/envs"
   ev -q "$HOME/Keybase/private/yurifrl/envs/dafiti"
   ev -q "$HOME/Keybase/private/yurifrl/envs/dafiti/mobileapi"
end
