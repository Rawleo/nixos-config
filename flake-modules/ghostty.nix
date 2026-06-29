{ pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    package = if pkgs.stdenv.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;

    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;

    settings = {
      theme = "Catppuccin Frappe";
      background-opacity = "0.95";
      font-family = "DejaVu Sans Mono";
     };
  };
}
