{
  description = "My Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    templ.url = "github:a-h/templ";
    tuxedo-nixos = {
      url = "github:blitz/tuxedo-nixos";
    };

    nix-citizen.url = "github:LovingMelody/nix-citizen";
  };

  outputs = { self, nixpkgs, home-manager, templ, tuxedo-nixos, ... }@inputs:
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages.${system};
  in 
  {
    nixosConfigurations = {
      cerberus = lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs;};
        modules = [ ./hardware/cerberus-hardware.nix ./config/cerberus.nix ];
      };

      ares = lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs;};
        modules = [ 
        ./hardware/ares-hardware.nix 
        ./config/ares.nix
        ];
      };

      apollo = lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs;};
        modules = [ 
        ./hardware/apollo-hardware.nix 
        ./config/apollo.nix
        tuxedo-nixos.nixosModules.default
         { 
            hardware.tuxedo-control-center = {
             enable = true;
             package = tuxedo-nixos.packages.x86_64-linux.default;
            }; 
         }

        ];
      };
    };
    homeConfigurations = {
      pldcanfly = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {inherit inputs;};
        modules = [ ./home/pldcanfly.nix ];
      };
      tst = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {inherit inputs;};
        modules = [ ./home/tst.nix ];
      };
    };
  };
}
