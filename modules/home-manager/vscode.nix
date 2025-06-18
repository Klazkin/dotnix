{ pkgs, lib, theme, ... }: {

  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions;
      [
        teabyii.ayu
        eamodio.gitlens
        usernamehw.errorlens
        rust-lang.rust-analyzer
        mkhl.direnv
        esbenp.prettier-vscode
        ms-azuretools.vscode-docker
        sainnhe.gruvbox-material
        jnoortheen.nix-ide
        aaron-bond.better-comments
        tamasfe.even-better-toml
        continue.continue
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "godot-tools";
          publisher = "geequlim";
          version = "2.5.1";
          sha256 = "sha256-kAzRSNZw1zaECblJv7NzXnE2JXSy9hzdT2cGX+uwleY=";
        }
        {
          name = "godot-rust-vscode";
          publisher = "dsobotta";
          version = "0.4.1";
          sha256 = "sha256-fg8dehS6DKe1FuUCkta4P4f7uvkq+lfeCjcnf02m3nE=";
        }
        # todo add rust snippets extensions
      ];

    profiles.default.userSettings = {
      "editor.formatOnSave" = true;
      "workbench.colorTheme" = lib.mkForce theme.vscode;
      "editor.cursorSmoothCaretAnimation" = "on";
      "workbench.iconTheme" = "ayu";
      "window.titleBarStyle" = "custom";
      "editor.fontLigatures" = true;
      "godotTools.editorPath.godot4" =
        "/etc/profiles/per-user/matpac/bin/godot4";
      "editor.smoothScrolling" = true;
    };
  };

}
