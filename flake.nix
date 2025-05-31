{
    description = "testing flakes";
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    };
    outputs = inputs@{ nixpkgs, ... }: {
        nixosConfigurations = {
            rixos = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = {inherit inputs;};
                modules = [
                    ./configuration.nix
                ];
            };
        };
    };
}