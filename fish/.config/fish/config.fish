export HTTP_PROXY=http://localhost:3128
export HTTPS_PROXY=http://localhost:3128
export NO_PROXY=127.0.0.1,localhost
export http_proxy={$HTTP_PROXY}
export https_proxy={$HTTPS_PROXY}
export no_proxy={$NO_PROXY}

function fish_greeting
end
# Add /root/bin to PATH if not already included
if not contains /root/bin $PATH
    set -gx PATH /root/bin $PATH
end

# Add ~/bin to PATH if not already included
if not contains ~/bin $PATH
    set -gx PATH ~/bin $PATH
end

set -gx PATH ~/bin/nvim/bin $PATH
set -x NVIM_CONFIG_HOME ~/.config/nvim
set -x XDG_CONFIG_HOME ~/.config

if status is-interactive

    set -gx PATH /root/.cache/rebar3/bin $PATH
    # Commands to run in interactive sessions can go here
end

starship init fish | source
