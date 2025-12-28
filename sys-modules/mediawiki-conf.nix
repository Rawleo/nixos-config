{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    php83
    php.packages.composer
  ];
}
