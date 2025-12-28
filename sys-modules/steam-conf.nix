{ config, lib, pkgs, modulesPath, ... }:

{ 
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; 
    dedicatedServer.openFirewall = true; 
  };
}

