{ pkgs, ... }:

{
  programs.lazyvim = {
    enable = true;

    ignoreBuildNotifications = true;

    extras = {
      lang.nix.enable = true;
      lang.python = {
        enable = true;
        installDependencies = true;        # Install ruff
        installRuntimeDependencies = true; # Install python3
      };
    };

    extraPackages = with pkgs; [
      nixd       # Nix LSP
      alejandra  # Nix formatter
      tree-sitter
    ];
  };
}
