{ config, pkgs, inputs, lib,  ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "matpac";
  home.homeDirectory = "/home/matpac";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  fonts.fontconfig.enable = true;  
  
  # Add Firefox GNOME theme directory
  # home.file.".mozilla/firefox/default/chrome/firefox-gnome-theme".source = inputs.firefox-gnome-theme;
  
  programs.firefox = {
        enable = true;
  #       profiles.default = {
  #          name = "Default";
  #          settings = {
  #             "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
  # 
  #             # For Firefox GNOME theme:
  #             "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
  #             "browser.tabs.drawInTitlebar" = true;
  #             "svg.context-properties.content.enabled" = true;
  #          };
  #          userChrome = ''
  #             @import "firefox-gnome-theme/userChrome.css";
  #             @import "firefox-gnome-theme/theme/colors/dark.css"; 
  #          '';
  #       };
  };

  stylix.targets.firefox.firefoxGnomeTheme.enable = true;

  nixpkgs = {
      config = {
        allowUnfree = true;
        allowUnfreePredicate = (_: true);
      };
  };

  programs.git = {
    enable = true;
    userName  = "matpac";
    userEmail = "matvei.matpac@gmail.com";
  };

  home.packages = with pkgs; [
  		# noto-fonts enabled through stylix
  		fastfetch
  		lazygit
  		modrinth-app
  		# zulu23 - java 
    	# (pkgs.nerdfonts.override { fonts = [ "Noto" "JetBrainsMono" ]; })
    	gnome-tweaks
    	dconf-editor
    	gnome-settings-daemon
    #	everforest-gtk-theme
    	# gruvbox-gtk-theme
    	adwsteamgtk
    	# tokyonight-gtk-theme
    	jetbrains.webstorm
    	jetbrains.rust-rover
    	discord
    	gimp
        # steam, enabled in configuration.nix
    	spotify-player
		# vscode
		# Development deps
    	godot_4
		# rustc
    	# rustup
    	# cargo-outdated
    	# pkg-config
    	# gcc
    	# openssl
    	# openssl.dev
    	# clang
    	# llvmPackages.bintools
    	lutris
    	
    	] ++ (with pkgs.gnomeExtensions; [
    	  user-themes
    	  appindicator
    	  vitals
    	  blur-my-shell
    	  open-bar
    	  just-perfection
    	  burn-my-windows
    	  dash-to-dock
    	  date-menu-formatter
    	  desktop-cube
    	  accent-directories
  ]);

  # symbolic links for custom gtk css
  # xdg.configFile = {
  #   "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
  #   "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
  #   "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  # };
  # 
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.thefuck.enable = true;
  programs.ghostty = {
  	enable = true;
  	settings = {
  	      font-size = 14;
  	      # font-family = "JetBrainsMonoNL Nerd Font";
  	      background-opacity = 0.70;
  	      background-blur-radius = 20;
  	      theme = "GruvboxDarkHard";
  	      # theme = "Ayu Mirage";
  	      # window-decoration = none;
  	
  	      # The default is a bit intense for my liking
  	      # but it looks good with some themes
  	      unfocused-split-opacity = 1.0;
  	
  	      # Some macOS settings
  	      window-theme = "dark";
  	
  	      # # Disables ligatures
  	      # font-feature = ["-liga" "-dlig" "-calt"]; 
  	    };
  };
    # Zsh
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    autocd = true;
	syntaxHighlighting.enable = true;

	initExtra = ''
	          export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$HOME/.nix-profile/lib/pkgconfig
	'';
  	
    shellAliases = {
      l = "ls -l";
      ll = "ls -larh";
      py = "python";
      rr = "ranger";
      mm = "micro";
      gg = "lazygit";
      summ = "sudo micro";
      sfy = "spotify_player";
      update = "sudo nixos-rebuild switch";
    };
  };
  
  programs.zsh.oh-my-zsh = {
  	enable = true;
  	plugins = [ "git" "thefuck" ];
  	# theme = "agnoster"; theme is configured via oh-my-posh
  };

  programs.oh-my-posh = {
  	enable = true;
  	enableZshIntegration = true;
  	# useTheme = "aliens";
  	settings = {
  		version = 3;
  		final_space = true;
  		shell_integration = true;
  		upgrade = false;

		"$schema" =  "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json";

  	    console_title_template =  "{{ .Folder }}";
  		
  		transient_prompt = {
  		    background = "transparent";
  		    foreground = "gray";
  		    template = "{{ now | date \"15:04:05\" }} \\ue285 ";
  		};
  		
  		blocks = [
  			{
  				type =  "prompt";
  				alignment = "left";
				trailing_diamond = "\\ue0b0";
  				segments = [
  					{
  					 	foreground = "black";
				     	background = "lightGreen";
				     	leading_diamond =  "\\ue0b6";
				     	trailing_diamond = "\\ue0b0";
				     	background_templates = [
				     		"{{ if eq .Type \"impure\" }}lightCyan{{ end }}"
				     	];
			          	style = "diamond";
			          	type =  "nix-shell";
			          	template = "\\uF313 {{ if eq .Type \"impure\" }}devshell{{else}}{{ .UserName }}{{ end }} ";
			        }
  					{
  						type = "path";
  						style = "diamond";
  						# powerline_symbol = "\\ue0b0";
  						leading_diamond = "\\ue0d7";
				        foreground = "black";
				        background = "white";
				        properties = {
				        	style = "mixed";	
				        };
				        template =  "{{ if ne .Path \"~\" }} {{ .Path }} {{ end }}";
				        # exclude_folders = [ "/home/matpac" ];
					}
					{
  						type = "rust";
  						style = "powerline";
  						powerline_symbol = "\\ue0b0";
				        foreground = "default";
				        background = "red";
				        display_mode = "context";
				        template = " \\ue68b {{ .Full }} ";
					}
					{
  						type = "git";
  						style = "powerline";
  						powerline_symbol = "\\ue0b0";
				        foreground = "default";
				        background = "blue";
				        background_templates = [
				            "{{ if or (.Working.Changed) (.Staging.Changed) }}yellow{{ end }}"
				            "{{ if and (gt .Ahead 0) (gt .Behind 0) }}red{{ end }}"
				        ];
				        template = " {{ .UpstreamIcon }}{{ .HEAD }}{{if .BranchStatus }} {{ .BranchStatus }}{{ end }}{{ if .Working.Changed }}  {{ .Working.String }}{{ end }}{{ if and (.Working.Changed) (.Staging.Changed) }} |{{ end }}{{ if .Staging.Changed }}  {{ .Staging.String }}{{ end }}{{ if gt .StashCount 0 }}  {{ .StashCount }}{{ end }} ";
				        properties = {
				            fetch_status = true;
				            fetch_upstream_icon = true;
				            untracked_modes = {
				              "/Users/user/Projects/oh-my-posh/" = "no";
				            };
				            source = "cli";
				       };
					}
  				];
  			}
  			{
  				type = "rprompt";
  				alignment = "right";
  				segments = [
			        {
			         background = "red";
                     foreground = "default";
                     trailing_diamond = "\\ue0b4";
                     leading_diamond =  "\\ue0b6";
                     properties = {
                       always_enabled = false;
                     };
                     style = "diamond";
                     template =  "{{ if gt .Code 0 }}\\uf00d {{ reason .Code }}{{ end }}";
                     type = "status";
                   }
  				];
  			}	
  		];

  	};
  };


  services.spotifyd = {
  	enable = true;
  	# settings = {
  	# 	global = {
  	# 		username = "";
  	#		password = "";
  	# 	}
  	# }
  };

  
	# /org/gnome/shell/extensions/openbar/winbcolor ['0.812', '0.631', '0.435']
  dconf = {
      enable = true;
      settings = {
          "org/gnome/shell" = {
	           disable-user-extensions = false;
	           disabled-extensions= [
	           	   "Vitals@CoreCoding.com"
	           	   "desktop-cube@schneegans.github.com"
	           	   ###
                   "openbar@neuromorph"
                   "user-theme@gnome-shell-extensions.gcampax.github.com"
                   "just-perfection-desktop@just-perfection" # crashes stylix on startup
	           ];
	           
	           enabled-extensions = [
                   "trayIconsReloaded@selfmade.pl"
                   "appindicatorsupport@rgcjonas.gmail.com"
                   "blur-my-shell@aunetx"
                   "dash-to-dock@micxgx.gmail.com"
                   "accent-directories@taiwbi.com"
                   "system-monitor@gnome-shell-extensions.gcampax.github.com"
	           ];
	           
	           favorite-apps = [
	                   "firefox.desktop"
	                   "rust-rover.desktop"
	                   "webstorm.desktop"
	                   # "code.desktop"
	                   # "org.gnome.Terminal.desktop"
	                   "spotify.desktop"
	                   "discord.desktop"
	                   "steam.desktop"
	           ];
	           
	      };

	      "org/gnome/shell/extensions/openbar" = {
	      		dark-bgcolor-wmax = ["0.0" "0.0" "1.0"];
	      };
	      	# lib.mkForce "${config.stylix.base16Scheme.base0E}";
	      
          "org/gnome/desktop/interface" = {
          		# color-scheme = "prefer-dark"; # handeled by stylx
          		cursor-size = 32;
          		show-battery-percentage = true;
          };
          
          "org/gnome/desktop/wm/preferences" = {
            workspace-names = [ "Main" ];
          };

          # handled by stylix
		  # "org/gnome/desktop/background" = {
		  #       picture-uri = "file:///home/matpac/.local/share/backgrounds/2025-01-23-21-05-42-wallpaper.jpg";
		  #       picture-uri-dark = "file:///home/matpac/.local/share/backgrounds/2025-01-23-21-05-42-wallpaper.jpg";
		  # };
		  
		  "org/gnome/desktop/screensaver" = {
		        picture-uri = "file:///home/matpac/.local/share/backgrounds/2025-01-23-21-05-42-wallpaper.jpg";
		        primary-color = "#3465a4";
		        secondary-color = "#000000";
		  };
		  
		  "org/gnome/settings-daemon/plugins/media-keys" = {
		          next = [ "<Shift><Control>n" ];
		          previous = [ "<Shift><Control>p" ];
		          play = [ "<Shift><Control>space" ];
		          custom-keybindings = [
		            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"		          ];
		  };
		       
		  "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
		          name = "ghostty";
		          command = "ghostty";
		          binding = "<Super>t";
		 };

		 # "org/gnome/shell/extensions/user-theme" = {
		 #   name = "gruvbox";
		 # };
		 
      };
    };

  gtk = {
    enable = true;

    # theme = {
    # 	name = "Tokyonight-Dark";
    # 	package = pkgs.tokyonight-gtk-theme;
    # };
         
    # iconTheme = {
    #	name = "Tokyonight-Dark";
    #	package = pkgs.tokyo-night-gtk;
    # };

    # iconTheme = {
    #   name = "GruvboxPlus";
    #   package = gruvboxPlus;
    # };
     
    # theme = {
    #   name = "gruvbox";
    #   package = pkgs.gruvbox-gtk-theme;
    # };

    # theme = {
    #	name = "adw-gtk3";
    #	package = pkgs.adw-gtk3;
    # };

    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
    };

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  home.activation.postConfigHook = lib.hm.dag.entryAfter ["writeBoundary"] ''
    /run/current-system/sw/bin/python3 /etc/nixos/json_fix.py
  '';

  home.activation.removeOhMyPoshConfig = lib.hm.dag.entryBefore ["checkLinkTargets"] ''
    rm -f ~/.config/oh-my-posh/config.json
  '';
  
  
   # xdg.configFile."oh-my-posh/config.json".source = lib.mkForce("/home/matpac/.config/oh-my-posh/config-fixed.json");
   # xdg.configFile."oh-my-posh/config.json".force = true;

  # home.sessionVariables.GTK_THEME = config.gtk.theme.name;
}
