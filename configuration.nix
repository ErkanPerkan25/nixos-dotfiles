# NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];


  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "erkan-nixos"; # Define your hostname.
  # Enable networking
  networking.networkmanager.enable = true;

  # Enables flakes and nix-command
  nix.settings.experimental-features  = [ "nix-command" "flakes" ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Set your time zone.
  time.timeZone = "America/Indiana/Indianapolis";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  # Enable the Wayland windowing system.
  #services.wayland.enable = true;

  # Enable the SDDM Environment for login screen
  services.displayManager.sddm = {
  	enable = true;
  };
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.wayland.compositor = "weston";

  # Configure keymap in X11
  #services.xserver.xkb = {
  #  layout = "se";
  #  variant = "";
  #};

  # Configure console keymap
  console.keyMap = "sv-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;


  # Enables Hyprland
  programs.hyprland.enable = true;

  # Enables zsh and Oh-my-zsh
  programs.zsh = {
      enable = true;
      ohMyZsh = {
      	enable = true;
	    theme = "robbyrussell";
      };
  };

  # Fonts set for system
  fonts.packages = with pkgs; [
      nerd-fonts.roboto-mono
      nerd-fonts.symbols-only
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.erkanperkan = {
    isNormalUser = true;
    description = "Eric Hansson";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [

    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     wget
     brave  	# Browser
     neovim 	# Text Editor
     git 	    # Vertison Control
     waybar 	# Hyprland Bar
     rofi 	    # Application Launcher
     ghostty	# Terminal
     swww	# Wallpaper
     wl-clipboard # Clipboard functionality
     zsh	    # Terminal Shell
     gh 	    # Github CLI
     tmux 	    # Terminal multiplexer
     zip        # Zip folder
     unzip      # Unzip zip files
     gcc        # C/C++ compiler
     python3    # Python3 
  ];

  programs.neovim = {
     defaultEditor = true;
     viAlias = true;
     vimAlias = true;
     withPython3 = true;
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  system.stateVersion = "25.05"; # Did you read the comment?
}
