{
    description = "testing flakes";
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
	lanzaboote = {
          url = "github:nix-community/lanzaboote/v0.4.1";
          inputs.nixpkgs.follows = "nixpkgs";
        };
    };
    outputs = inputs@{ nixpkgs, lanzaboote, ... }: {
        nixosConfigurations = {
            rixos = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = {inherit inputs;};
                modules = [
                    ./configuration.nix
		    lanzaboote.nixosModules.lanzaboote
                ];
            };
        };
    };
}
