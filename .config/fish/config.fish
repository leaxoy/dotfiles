if status is-interactive
    # PATH setting
    set -g fish_user_paths /usr/local/opt/llvm/bin $fish_user_paths
    set JAVA_HOME /usr/local/opt/openjdk
    set -g fish_user_paths $JAVA_HOME/bin $fish_user_paths
    set -g fish_user_paths $HOME/.jbang/bin $fish_user_paths
    set -g fish_user_paths $HOME/Library/Python/3.10/bin $fish_user_paths
    set -g fish_user_paths $HOME/go/bin $fish_user_paths
    set -g fish_user_paths $HOME/.rustup/toolchains/nightly-x86_64-apple-darwin/bin $fish_user_paths
    set -g fish_user_paths $HOME/.cargo/bin $fish_user_paths
    # ghc
    set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME
    set -gx PATH $HOME/.cabal/bin $PATH $HOME/.ghcup/bin # ghcup-env
    # pnpm
    set -gx PNPM_HOME /Users/bytedance/Library/pnpm
    set -gx PATH "$PNPM_HOME" $PATH
    # Bun
    set -Ux BUN_INSTALL "$HOME/.bun"
    set -px --path PATH "$HOME/.bun/bin"

    command -qv goenv && source (goenv init - | psub)
    command -qv oh-my-posh && oh-my-posh init fish | source
    command -qv starship && starship init fish | source
    command -qv zoxide && zoxide init fish | source

    # ALIAS setting
    command -qv bat && alias cat bat # https://github.com/sharkdp/bat
    command -qv dust && alias du dust # https://github.com/bootandy/dust
    command -qv git && alias g git # https://github.com/git/git
    command -qv btm && alias top btm # https://github.com/ClementTsang/bottom
    command -qv lsd && alias ls lsd # https://github.com/Peltoche/lsd
    command -qv rg && alias grep rg # https://github.com/BurntSushi/ripgrep
    command -qv procs && alias ps procs # https://github.com/dalance/procs
    command -qv sd && alias sed sd # https://github.com/chmln/sd
    if command -qv nvim
        set -gx EDITOR nvim
        alias vim nvim
    end

    # Local config
    set local_config (dirname (status --current-filename))/config.local.fish
    test -f $local_config && source $local_config

    # Platform specific config
    switch (uname)
        case Darwin
            set platform_local (dirname (status --current-filename))/config.darwin.fish
        case Linux
            set platform_local (dirname (status --current-filename))/config.linux.fish
        case "*"
            set platform_local (dirname (status --current-filename))/config.windows.fish
    end
    test -f $platform_local && source $platform_local
end
