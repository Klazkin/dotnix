{ pkgs, user, hostName, ... }: {

  nix = {
    settings = { experimental-features = "nix-command flakes"; };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 10d";
    };
  };

  programs.nix-ld.enable = true;

  networking = {
    hostName = hostName;
    networkmanager = {
      enable = true;
      wifi.backend = "iwd"; # "wpa_supplicant";
      unmanaged = [ ]; # Ensure NM isn't explicitly ignoring USB dongles
      wifi.powersave = false; # for desktop and steam frame dongle
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.extraModprobeConfig = ''
    options cfg80211 ieee80211_regdom=EE
  '';

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      80 # http
      443 # https
      25565 # minecraft
      8001 # 3DS local staming
      27036
      27037
    ];
    allowedUDPPorts = [ 25565 27036 10400 10401 ];
    allowedTCPPortRanges = [{ # KDE Connect range
      from = 1716;
      to = 1764;
    }];
    allowedUDPPortRanges = [
      { # KDE Connect range
        from = 1716;
        to = 1764;
      }
      { # steam frame
        from = 27031;
        to = 27036;
      }
      {
        from = 47998;
        to = 48010;
      }
    ];
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";

    extraLocaleSettings = {
      LC_TIME = "en_DK.UTF-8"; # English, European date ordering
      LC_NUMERIC =
        "en_US.UTF-8"; # Decimal point = dot, grouping = none/commas (but no comma decimal)
      LC_MONETARY = "en_US.UTF-8"; # Currency with dot decimals
      LC_MEASUREMENT = "et_EE.UTF-8"; # Metric units
      LC_PAPER = "et_EE.UTF-8"; # A4 paper size
      LC_ADDRESS = "et_EE.UTF-8"; # Estonian-style addresses if needed
      LC_NAME = "et_EE.UTF-8"; # Estonian name order conventions
      LC_TELEPHONE = "et_EE.UTF-8"; # Estonian phone formatting
      LC_IDENTIFICATION = "en_US.UTF-8"; # Keep metadata in English
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
    fastfetch
    lazygit
    micro
    wget
    python313
    yazi
    bottom
    zellij
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

    extraPackages = with pkgs; [ libva mesa libva-utils ];
  };

  boot.kernelPatches = [{
    name = "amdgpu-ignore-ctx-privileges";
    patch = pkgs.fetchpatch {
      name = "cap_sys_nice_begone.patch";
      url =
        "https://github.com/Frogging-Family/community-patches/raw/master/linux61-tkg/cap_sys_nice_begone.mypatch";
      hash = "sha256-Y3a0+x2xvHsfLax/uwycdJf3xLxvVfkfDVqjkxNaYEo=";
    };
  }];

  security.sudo = {
    # set no pwfeedback
    extraConfig = ''
      Defaults pwfeedback
    '';
  };

  # lower boot time by skipping the wait for network
  systemd.services.NetworkManager-wait-online.enable = false;
}
