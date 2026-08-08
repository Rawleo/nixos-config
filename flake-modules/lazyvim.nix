{ pkgs, ... }:

{
  programs.lazyvim = {
    enable = true;

    ignoreBuildNotifications = true;

    extras = {
      lang.nix.enable = true;
      lang.python = {
        enable = true;
        installDependencies = true;
        installRuntimeDependencies = true;
      };
    };

    extraPackages = with pkgs; [
      nixd
      alejandra
      tree-sitter
      statix
    ];
  };
}
