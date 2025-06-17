{ lib, ... }: {

  # runs python script to fix \\ escapes to work as intended
  # home.activation.postConfigHook = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
  #   /run/current-system/sw/bin/python3 ~/dotnix/utils/oh-my-posh-fixer.py
  # '';

  # removes old config for oh-my-posh
  # home.activation.removeOhMyPoshConfig =
  #   lib.hm.dag.entryBefore [ "checkLinkTargets" ] ''
  #     rm -f ~/.config/oh-my-posh/config.json
  #   '';

  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      version = 3;
      final_space = true;
      shell_integration = true;
      upgrade = false;

      "$schema" =
        "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json";

      console_title_template = "{{ .Folder }}";

      transient_prompt = {
        background = "transparent";
        foreground = "gray";
        template = ''{{ now | date "15:04:05" }} \ue285 '';
      };

      blocks = [
        {
          type = "prompt";
          alignment = "left";
          trailing_diamond = "\\ue0b0";
          segments = [
            {
              foreground = "black";
              background = "lightGreen";
              leading_diamond = "\\ue0b6";
              trailing_diamond = "\\ue0b0";
              background_templates =
                [ ''{{ if eq .Type "impure" }}lightCyan{{ end }}'' ];
              style = "diamond";
              type = "nix-shell";
              template = ''
                \uF313 {{ if eq .Type "impure" }}devshell{{else}}{{ .UserName }}{{ end }} '';
            }
            {
              type = "path";
              style = "diamond";
              leading_diamond = "\\ue0d7";
              foreground = "black";
              background = "white";
              properties = { style = "mixed"; };
              template = ''{{ if ne .Path "~" }} {{ .Path }} {{ end }}'';
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
              template =
                " {{ .UpstreamIcon }}{{ .HEAD }}{{if .BranchStatus }} {{ .BranchStatus }}{{ end }}{{ if .Working.Changed }}  {{ .Working.String }}{{ end }}{{ if and (.Working.Changed) (.Staging.Changed) }} |{{ end }}{{ if .Staging.Changed }}  {{ .Staging.String }}{{ end }}{{ if gt .StashCount 0 }}  {{ .StashCount }}{{ end }} ";
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
          segments = [{
            background = "red";
            foreground = "default";
            trailing_diamond = "\\ue0b4";
            leading_diamond = "\\ue0b6";
            properties = { always_enabled = false; };
            style = "diamond";
            template = "{{ if gt .Code 0 }}\\uf00d {{ reason .Code }}{{ end }}";
            type = "status";
          }];
        }
      ];
    };
  };
}
