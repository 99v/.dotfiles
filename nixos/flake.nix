{
  description = "NixOS Flake Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    stylix.url = "github:danth/stylix";
    vortix.url = "github:Harry-kp/vortix";
    vortix.inputs.nixpkgs.follows = "nixpkgs";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #    sysc-greet = {
    #      url = "github:Nomadcxx/sysc-greet";
    #      inputs.nixpkgs.follows = "nixpkgs";
    #    };
  };

  outputs =
    {
      self,
      nixpkgs,
      vortix,
      nixvim,
      stylix,
      ...
    }@inputs:
    {
      nixosConfigurations.system = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          nixvim.nixosModules.nixvim
          stylix.nixosModules.stylix
          #sysc-greet.nixosModules.default
        ];
      };
    };
}
