if status is-interactive
    # PATH setting
    set -g fish_user_paths $HOME/go/bin $fish_user_paths
    set -g fish_user_paths $HOME/.rustup/toolchains/nightly-x86_64-apple-darwin/bin $fish_user_paths
    set -g fish_user_paths $HOME/.cargo/bin $fish_user_paths
    # pnpm
    set -gx PNPM_HOME $HOME/Library/pnpm
    set -gx PATH "$PNPM_HOME" $PATH
    # Bun
    set -Ux BUN_INSTALL "$HOME/.bun"
    set -px --path PATH "$HOME/.bun/bin"

    command -qv zoxide && zoxide init fish | source
    command -qv direnv && direnv hook fish | source
    command -qv starship && starship init fish | source
    # command -qv oh-my-posh && oh-my-posh init fish --config $(brew --prefix oh-my-posh)/themes/gruvbox.omp.json | source
    [ -f "$HOME/.bytebm/config/fish.sh" ]; and source "$HOME/.bytebm/config/fish.sh"
    source (brew --prefix asdf)/libexec/asdf.fish

    # ALIAS setting
    command -qv bat && alias cat bat # https://github.com/sharkdp/bat
    command -qv dust && alias du dust # https://github.com/bootandy/dust
    command -qv git && alias g git # https://github.com/git/git
    command -qv btm && alias top btm # https://github.com/ClementTsang/bottom
    command -qv lsd && alias ls lsd # https://github.com/Peltoche/lsd
    command -qv rg && alias grep rg # https://github.com/BurntSushi/ripgrep
    command -qv procs && alias ps procs # https://github.com/dalance/procs
    command -qv sd && alias sed sd # https://github.com/chmln/sd
    command -qv tmux && alias ta "tmux at"
    if command -qv nvim
        set -gx EDITOR nvim
        alias vim nvim
        if command -qv fzf
            alias vf 'nvim $(fzf)'
        end
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

    # Base16 Shell
    # set BASE16_SHELL_PATH "$HOME/.config/base16-shell"
    # if test -s "$BASE16_SHELL_PATH"
    #     source "$BASE16_SHELL_PATH/profile_helper.fish"
    #     set -gx BASE16_THEME_DEFAULT gruvbox-dark-dark
    #     set -gx BASE16_THEME gruvbox-dark-dark
    # end
end
