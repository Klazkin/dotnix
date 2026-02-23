{ ... }: {
  fonts.fontconfig = {
    enable = true;
    subpixel = {
      # 'none' disables the RGB/BGR subpixel geometry logic
      # This forces the renderer into Grayscale mode
      rgba = "none";

      # 'lcdnone' removes the software filter used to reduce color fringes
      lcdfilter = "none";
    };

    # Ensure antialiasing is still ON (otherwise text will be jagged)
    antialias = true;

    hinting = {
      enable = true;
      # 'slight' is usually best for grayscale;
      # 'none' is the "cleanest" but can look a bit blurry.
      style = "slight";
    };

    localConf = ''
      <fontconfig>
          <match target="font">
            <edit name="rgba" mode="assign"><const>none</const></edit>
            <edit name="lcdfilter" mode="assign"><const>lcdnone</const></edit>
            <edit name="antialias" mode="assign"><bool>true</bool></edit>
            <edit name="hinting" mode="assign"><bool>true</bool></edit>
            <edit name="hintstyle" mode="assign"><const>hintslight</const></edit>
          </match>
        </fontconfig>
    '';
  };

  environment.variables = {
    "FREETYPE_PROPERTIES" = "truetype:interpreter-version=40";
    "FONTCONFIG_FILE" = "/etc/fonts/fonts.conf";
  };
}
