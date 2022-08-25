if status is-interactive
    # PATH setting
    if command -qv nvim
        set -gx EDITOR nvim
        alias vim nvim
    end
    if command -qv zoxide 
        zoxide init fish | source
    end
    set -gx JAVA_HOME "/Library/Java/JavaVirtualMachines/graalvm-ce-java17-22.2.0/Contents/Home"
    set -g fish_user_paths $JAVA_HOME/bin $fish_user_paths
    set -g fish_user_paths /usr/local/opt/llvm/bin $fish_user_paths
    set -g fish_user_paths $HOME/.jbang/bin $fish_user_paths
    set -g fish_user_paths $HOME/Library/Python/3.10/bin $fish_user_paths
    set -g fish_user_paths $HOME/.cargo/bin $fish_user_paths
    set -g fish_user_paths $HOME/go/bin $fish_user_paths
    set -g fish_user_paths $HOME/.rustup/toolchains/nightly-x86_64-apple-darwin/bin $fish_user_paths
    # pnpm
    set -gx PNPM_HOME /Users/bytedance/Library/pnpm
    set -gx PATH "$PNPM_HOME" $PATH
    # Bun
    set -Ux BUN_INSTALL "$HOME/.bun"
    set -px --path PATH "$HOME/.bun/bin"

    zoxide init fish | source

    # ALIAS setting
    alias g git
    alias ls lsd

    set local_config (dirname (status --current-filename))/config.local.fish
    test -f $local_config && source $local_config
end
