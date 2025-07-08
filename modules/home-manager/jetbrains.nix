{ pkgs, ... }: {
  home.packages = with pkgs.jetbrains; [
    rust-rover
    pycharm-community-bin
    webstorm
    idea-community-bin
  ];
}
