{ config, pkgs, ... }:

{
  networking.networkmanager.enable = true;

  # Explicitly add the OpenConnect plugin for NetworkManager
  networking.networkmanager.plugins = [ 
    pkgs.networkmanager-openconnect 
  ];

  # Optional: install the GUI package if you need the specific VPN editor
  environment.systemPackages = with pkgs; [
    networkmanager-openconnect
    pkgs.gp-saml-gui
    pkgs.openconnect
    pkgs.kdePackages.krdc
  ];
}
