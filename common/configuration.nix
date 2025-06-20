# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ pkgs, user, hostName, ... }: {

  nix = {
    settings = { experimental-features = "nix-command flakes"; };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 10d";
    };
  };

  networking = {
    hostName = hostName;
    networkmanager.enable = true;
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      80 # http
      443 # https
    ];
    allowedTCPPortRanges = [{ # KDE Connect range
      from = 1716;
      to = 1764;
    }];
    allowedUDPPortRanges = [{ # KDE Connect range
      from = 1716;
      to = 1764;
    }];
  };

  i18n = {
    defaultLocale = "en_GB.UTF-8";

    extraLocaleSettings = {
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

  };

  time.timeZone = "Europe/Tallinn";

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
    enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    description = "Matvei";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    micro
    wget
    python313
    yazi
    bottom
    zellij
    cava
  ];

  programs.htop.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # lower boot time by skipping the wait for network
  systemd.services.NetworkManager-wait-online.enable = false;
}
