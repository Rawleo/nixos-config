{ config, pkgs, ... }:

{
  imports = [
    ./sys-modules/hardware-configuration.nix
    ./sys-modules/librewolf-conf.nix
    ./sys-modules/gp-conf.nix
    ./sys-modules/nvidia-conf.nix
    ./sys-modules/mediawiki-conf.nix
    ./sys-modules/office-conf.nix
    ./sys-modules/remove-old-generations.nix # Note: Check if native nix.gc options below overlap with this
    ./sys-modules/steam-conf.nix
    ./sys-modules/coding-tools-conf.nix
  ];

  # --- Nix & System Management ---
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true; # Automatically links identical files to save disk space
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "26.05";

  # --- Bootloader ---
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # --- Networking ---
  networking.hostName = "ryan-nixos";
  networking.networkmanager.enable = true;

  # --- Localization & Time ---
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # --- Desktop Environment & Window Manager ---
  services.xserver.enable = false; # Disabled since you are running Wayland-native Plasma 6
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # --- Hardware & Firmware ---
  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;
  powerManagement.cpuFreqGovernor = "performance";

  # Logitech
  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true;

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings.Policy.AutoEnable = "true";
  };

  # --- Audio & Printing ---
  services.printing.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # --- User Accounts ---
  users.users.ryanson = {
    isNormalUser = true;
    description = "ryanson";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  # --- Programs & Environment ---
  programs.firefox.enable = true;
  programs.kdeconnect.enable = true;
  environment.variables.EDITOR = "nvim";

  # System-wide Packages
  environment.systemPackages = with pkgs; [
    neovim
    vim
    wget
    git
    spotify
    slack
    cifs-utils
    sbctl
    localsend
    direnv
    (python3.withPackages (python-pkgs: with python-pkgs; [
      pandas
      requests
    ]))
  ];

  # Dynamic Linker for non-Nix binaries
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      openssl
      xorg.libX11
      xorg.libXcursor
      xorg.libXrandr
      xorg.libXi
      libGL
    ];
  };
}
