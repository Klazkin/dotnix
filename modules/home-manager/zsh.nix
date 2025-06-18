{ ... }: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    autocd = true;
    syntaxHighlighting.enable = true;

    initContent = ''
      export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$HOME/.nix-profile/lib/pkgconfig
    '';

    shellAliases = {
      l = "ls -l";
      ll = "ls -larh";
      py = "python";
      rr = "yazi";
      mm = "micro";
      rm = "rm -I";
      summ = "sudo micro";
      gg = "lazygit";
      zz = "zeditor";
      update = "(cd ~/dotnix && py update.py)";
      update-nogit = "sudo nixos-rebuild switch --flake ~/dotnix";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      # theme = "agnoster"; theme is managed by oh-my-posh
    };
  };
}
