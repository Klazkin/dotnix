{ config, pkgs, ...}:

{
	
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
	  
	  home.packages = with pkgs; [
	    	# discord
	    	# steam
	    	# spotify	
	    	dconf
	    	wlogout
	    	pyprland
	    	hyprpicker
	   	   hyprcursor
	   	   hyprlock
	   	   hypridle
	   	   hyprpaper
	   	   waybar
	    	rofi-wayland
	  ];
	
	  # hypr fixes
	  # systemd.user.services.hypridle.Unit.After = lib.mkForce "graphical-session.target";
	  # systemd.user.services.hyprpaper.Unit.After = lib.mkForce "graphical-session.target";
	
	
	programs.kitty.enable = true; # required for the default Hyprland config
	programs.hyprlock.enable = true;
	programs.waybar.enable = true;
	
	home.pointerCursor = {
	      gtk.enable = true;
	      # x11.enable = true;
	      package = pkgs.bibata-cursors;
	      name = "Bibata-Modern-Classic";
	      size = 16;
	    };
	  
	    gtk = {
	      enable = true;
	  
	      theme = {
	        package = pkgs.flat-remix-gtk;
	        name = "Flat-Remix-GTK-Grey-Darkest";
	      };
	  
	      iconTheme = {
	        package = pkgs.gnome.adwaita-icon-theme;
	        name = "Adwaita";
	      };
	  
	      font = {
	        name = "Sans";
	        size = 11;
	      };
	  };
	
	  # Hyprland
	  wayland.windowManager.hyprland.enable = true; # enable Hyprland
	  wayland.windowManager.hyprland.systemd.variables = ["--all"];
	  wayland.windowManager.hyprland.settings = {
		decoration = {
		     rounding = 10;
		     blur = {
		       enabled = true;
		       brightness = 1.0;
		       contrast = 1.0;
		       noise = 0.01;
		
		       vibrancy = 0.2;
		       vibrancy_darkness = 0.5;
		
		       passes = 4;
		       size = 7;
		
		       popups = true;
		       popups_ignorealpha = 0.2;
		     };
		
		     shadow = {
		       enabled = true;
		       color = "rgba(00000055)";
		       ignore_window = true;
		       offset = "0 15";
		       range = 100;
		       render_power = 2;
		       scale = 0.97;
		     };
		};
	
	  
	    "$mod" = "SUPER";
	    "$terminal" = "kitty";
	    monitor = ", preferred, auto, 1.175";
	    input.touchpad.natural_scroll = true;
	    exec-once = [
	     "hyprpaper"
	     "hypridle"
	     "uwsm app -- systemctl start --user hyprctl"
	     "uwsm app --  systemctl start --user hyprpaper"
	    ];
	    bindel =
	      [
	      	",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
	     	",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
	    	",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
	    	",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
	    	",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
	    	",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
	   	];
	    bind =
	      [
	        "$mod, F, exec, firefox"
	        "$mod, T, exec, $terminal"
	        # ", Print, exec, grimblast copy area"
	        "$mod, M, exec, exit"
	        "$mod, C, killactive"
	      ]
	      ++ (
	        # workspaces
	        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
	        builtins.concatLists (builtins.genList (i:
	            let ws = i + 1;
	            in [
	              "$mod, code:1${toString i}, workspace, ${toString ws}"
	              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
	            ]
	          )
	          9)
	      );
	  };
}
