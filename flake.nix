{
    description = "A very basic NixOS flake";
    
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        # flake-parts.url = "github:hercules-ci/flake-parts";
    };
    
    outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
        nixosConfigurations.erkan-nixos = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [ 
                ./configuration.nix 
                
                home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    users.erkanperkan = import ./home-manager.nix;
                    backUpFileExtenstion = "backup";
                };
            ];
        };
    };
}
