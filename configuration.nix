{ config, pkgs, ... }:

{
  imports = [
    ./sys-modules/hardware-configuration.nix
    ./sys-modules/librewolf-conf.nix
    # ./sys-modules/gp-conf.nix
    ./sys-modules/nvidia-conf.nix
    # ./sys-modules/mediawiki-conf.nix
    ./sys-modules/office-conf.nix
    ./sys-modules/steam-conf.nix
    ./sys-modules/coding-tools-conf.nix
  ];

  # --- Nix Package Manager & Store ---
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "26.05";

  # --- Bootloader & Kernel ---
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelParams = [
      "acpi_osi=!"
      "acpi_osi=\"Windows 2013\""
    ];
  };

  # --- Networking & Host ---
  networking = {
    hostName = "ryan-nixos";
    networkmanager.enable = true;
  };

  # --- Localization & Time ---
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";

  # --- Desktop Environment & Display Manager ---
  services = {
    xserver.enable = false;
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    desktopManager.plasma6.enable = true;
    xserver.xkb = {
      layout = "us";
      variant = "";
    };
  };

  # --- Hardware & Firmware ---
  hardware = {
    enableAllFirmware = true;
    logitech.wireless = {
      enable = true;
      enableGraphical = true;
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings.Policy.AutoEnable = "true";
    };
  };

  powerManagement.cpuFreqGovernor = "performance";

  # Via / Vial keyboard rules
  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial**:f64c2b3c*", MODE="0660", TAG+="uaccess"
  '';

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
  programs = {
    firefox.enable = true;
    kdeconnect.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        openssl
        libX11
        libXcursor
        libXrandr
        libXi
        libGL
      ];
    };
  };

  # System-wide Packages
  environment.systemPackages = with pkgs; [
    wget
    git
    spotify
    slack
    cifs-utils
    sbctl
    localsend
    direnv
    (python3.withPackages (ps: with ps; [
      pandas
      requests
    ]))
  ];
}
