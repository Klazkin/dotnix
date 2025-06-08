# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, ... }: {
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  stylix = {
    enable = true;
    autoEnable = true;

    polarity = "dark";
    base16Scheme =
      "${pkgs.base16-schemes}/share/themes/gruvbox-light-hard.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/ayu-mirage.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest-dark-hard.yaml";
    image = ./wallpaper.jpg;

    cursor = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
    };

    fonts = {
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };

      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };

      monospace = {
        package = (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; });
        name = "JetBrainsMono Nerd Font";
      };

      emoji = config.stylix.fonts.monospace;
    };
  };

  nix.settings = {
    experimental-features = "nix-command flakes";

    # enables caching for hyprland, no longer needed
    # substituters = ["https://hyprland.cachix.org"];
    # trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  # Bootloader
  boot = {
    plymouth = {
      enable = false;
      theme = "bgrt"; # handeled by stylix
      themePackages = with pkgs;
        [
          # By default we would install all themes
          (adi1090x-plymouth-themes.override {
            selected_themes = [ "loader_2" ];
          })
        ];
    };

    # Enable "Silent Boot"
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
    # Hide the OS choice for bootloaders.
    # It's still possible to open the bootloader list by pressing any key
    # It will just not appear on screen unless a key is pressed
    loader.timeout = 3;
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Tallinn";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "et_EE.UTF-8";
    LC_IDENTIFICATION = "et_EE.UTF-8";
    LC_MEASUREMENT = "et_EE.UTF-8";
    LC_MONETARY = "et_EE.UTF-8";
    LC_NAME = "et_EE.UTF-8";
    LC_NUMERIC = "et_EE.UTF-8";
    LC_PAPER = "et_EE.UTF-8";
    LC_TELEPHONE = "et_EE.UTF-8";
    LC_TIME = "et_EE.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
    enable = true;
  };

  # Gnome
  services.xserver = {
    displayManager.gdm.enable = true;
    desktopManager.gnome = {
      enable = true;
      extraGSettingsOverridePackages = [ pkgs.mutter ];
      extraGSettingsOverrides =
        "  [org.gnome.desktop.peripherals.touchpad]\n  click-method='default'\n  # [org.gnome.mutter]\n  # experimental-features=['scale-monitor-framebuffer']\n";
    };
  };

  environment.gnome.excludePackages = (with pkgs; [
    atomix # puzzle game
    cheese # webcam tool
    epiphany # web browser
    evince # document viewer
    geary # email reader
    gedit # text editor
    gnome-characters
    gnome-music
    gnome-photos
    gnome-terminal
    gnome-tour
    xterm # xterm..
    hitori # sudoku game
    iagno # go game
    tali # poker game
    totem # video player
  ]);

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.matpac = {
    isNormalUser = true;
    description = "Matthew";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ ];
    shell = pkgs.zsh;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Allow auto-upgrade
  # system.autoUpgrade.enable = true;
  # system.autoUpgrade.allowReboot = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    micro
    wget
    python313
    yazi
    bottom
    zellij
    # noto-fonts
    # (pkgs.nerdfonts.override { fonts = [ "Noto" "JetBrainsMono" ]; })
    # greetd.tuigreet
    # npins
  ];

  programs.htop.enable = true;
  programs.zsh.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall =
      true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall =
      true; # Open ports in the firewall for Source Dedicated Server
  };

  # services.greetd = {
  # enable = true;
  # settings = {
  # default_session = {
  # command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --time-format '%I:%M %p | %a • %h | %F' --cmd Hyprland";
  # user = "matpac";
  # };
  # };
  # };

  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.hyprland.enable = true;
  #
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

  # hardware accel
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # amd graphics, use default mesa driver instead!!
  #   hardware.graphics.extraPackages = with pkgs; [
  #     amdvlk
  #   ];
  #
  #   hardware.graphics.extraPackages32 = with pkgs; [
  #     driversi686Linux.amdvlk
  #   ];

  # manjaro mount

  fileSystems."/mnt/manjaro" = {
    device = "/dev/nvme0n1p2";
    # options = [ "uid=1000" "gid=100" "dmask=007" "fmask=117" "nofail" ];
    options = [ "nofail" ];
  };

  # lower boot time by skipping the wait for network
  systemd.services.NetworkManager-wait-online.enable = false;
}
