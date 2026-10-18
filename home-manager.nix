{config, pkgs, ...}:

let
    dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
    create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
    configs = {
    	nvim = "nvim";
        dunst = "dunst";
        waybar = "waybar";
        rofi = "rofi";
        ghostty = "ghostty";
        hypr = "hypr";
    };
in

{
    home.username = "erkanperkan";
    home.homeDirectory = "/home/erkanperkan";
    programs.git.enable = true;
    home.stateVersion = "26.05";


    xdg.configFile = builtins.mapAttrs (name: subpath:{
    	source = create_symlink "${dotfiles}/${subpath}";
	    recursive = true;
    }) configs;

    home.packages = with pkgs; [
        # Tools, Compilers, and more ...
        ripgrep
        nil
        nixpkgs-fmt
        nodejs
        cargo
        gcc
        lua-language-server
        fd
        fzf
        luaPackages.tree-sitter-cli

        # Programs ...
        brave  	    # Browser
        waybar 	    # Hyprland Bar
        rofi 	    # Application Launcher
        ghostty	    # Terminal
        kitty       # Terminal
        awww	    # Wallpaper
        tmux 	    # Terminal multiplexer
        pcmanfm     # File Manager
        blueman     # Bluetooth Manager
        spotify     # Spotify
        fuzzel      # Fuzzel
    ];

    programs.neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
        sideloadInitLua = true;
    };
}
