{ pkgs, inputs, ... }: {

  # User-specific module imports
  imports = [
    inputs.plasma-manager.homeModules.plasma-manager
    inputs.lazyvim.homeManagerModules.default
    #./nvim.nix
    ./rust.nix
    ./discord.nix
    ./ghostty.nix
    ./lazyvim.nix
    ./starship.nix
    # ./plasma.nix
  ];

  # Home Manager identity and state version
  home = {
    username = "ryanson";
    homeDirectory = "/home/ryanson";
    stateVersion = "26.05";

    packages = with pkgs; [
      fetch
      starship
    ];
  };

  # Git configuration
  programs.git = {
    enable = true;
    userName = "Rawleo";
    userEmail = "sonryan50@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      safe.directory = "/etc/nixos";
    };
  };

  # Desktop autostart applications
  xdg.autostart = {
    enable = true;
    entries = [ "${pkgs.solaar}/share/applications/solaar.desktop" ];
  };
}
