{
  description = "My Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    templ.url = "github:a-h/templ";

    nix-citizen.url = "github:LovingMelody/nix-citizen";
  };

  outputs = { self, nixpkgs, home-manager, templ, ... }@inputs:
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages.${system};
  in 
  {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs;};
        modules = [ ./configuration.nix ];
      };
    };
    homeConfigurations = {
      pldcanfly = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {inherit inputs;};
        modules = [ ./home.nix ];
      };
    };
  };
}
