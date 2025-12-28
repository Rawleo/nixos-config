{
  description = "NixOS Home Manager & Plasma Manager Configuration";

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
  };

  outputs = inputs@{ nixpkgs, home-manager, plasma-manager, rust-overlay, ... }:
    let
      # --- Configuration Variables ---
      system = "x86_64-linux";
      hostname = "ryan-nixos";
      username = "ryanson";
    in
    {
      nixosConfigurations."${hostname}" = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };

        modules = [
          # Main NixOS Configuration
          ./configuration.nix

          # Home Manager Module
          home-manager.nixosModules.home-manager
          {
            nixpkgs.overlays = [ rust-overlay.overlays.default ];

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };

            # Home Manager User Configuration
            home-manager.users."${username}" = { pkgs, ... }: {
              
              imports = [
                # Plasma Manager Module
                plasma-manager.homeModules.plasma-manager
                
                # Your Modules
                ./flake-modules/nvim.nix
                ./flake-modules/rust.nix
                # ./flake-modules/plasma.nix
              ];

              home = {
                inherit username;
                homeDirectory = "/home/${username}";
                stateVersion = "26.05";
              };

              programs.git = {
                enable = true;
                settings = {
                  user = {
                    name = "Rawleo";
                    email = "sonryan50@gmail.com";
                  };
                  init = {
                    defaultBranch = "main";
                  };
                  safe = {
                    directory = "/etc/nixos";
                  };
                };
              };

              # Autostart Solaar when your desktop session loads
              xdg.autostart.enable = true;
              xdg.autostart.entries = [
                "${pkgs.solaar}/share/applications/solaar.desktop"
              ];
            };
          }
        ];
      };
    };
}
