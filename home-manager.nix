{config, pkgs, ...}:

{
    home.username = "erkanperkan";
    home.homeDirectory = "/home/erkanperkan";
    programs.git.enable = true;
    home.stateVersion = "25.05";


    home.file.".config/nvim".source = .config/nvim;

    home.packages = with pkgs; [
        neovim
        ripgrep
        nil
        nixpkgs-fmt
        nodejs
        gcc
    ];
}
