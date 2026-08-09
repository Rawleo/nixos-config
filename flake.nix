{
  description = "NixOS Home Manager, Plasma Manager & SecureBoot Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nixcord = {
      url = "github:FlameFlag/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lazyvim = {
      url = "github:pfassina/lazyvim-nix/v15.13.0";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, lazyvim, nixcord, plasma-manager, rust-overlay, lanzaboote, ... }:
    let
      # --- Configuration Variables ---
      system = "x86_64-linux";
      hostname = "ryan-nixos";
      username = "ryanson";
    in
    {
      nixosConfigurations."${hostname}" = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs hostname username; };

        modules = [
          # Main NixOS Configuration
          ./configuration.nix

          # SecureBoot (Lanzaboote) Module & Configuration
          lanzaboote.nixosModules.lanzaboote
          ({ pkgs, lib, ... }: {
            environment.systemPackages = [
              pkgs.sbctl
            ];

            boot.loader.systemd-boot.enable = lib.mkForce false;

            boot.lanzaboote = {
              enable = true;
              pkiBundle = "/var/lib/sbctl";
            };
          })

          # Global Nixpkgs & Overlays Configuration
          {
            nixpkgs.overlays = [ rust-overlay.overlays.default ];
          }

          # Home Manager Module
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };

              # Import home.nix
              users."${username}" = import ./flake-modules/home.nix;
            };
          }
        ];
      };
    };
}
