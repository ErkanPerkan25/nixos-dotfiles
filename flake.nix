{
    description = "A very basic NixOS flake";
    
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };
    
    outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
        nixosConfigurations.erkan-nixos = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [ 
                ./configuration.nix 
                
                home-manager.nixosModules.home-manager
                {
                    home-manager = {
                        useGlobalPkgs = true;
                        useUserPackages = true;
                        users.erkanperkan = import ./home-manager.nix;
                        backupFileExtension = "backup";
                    };
                }
            ];
        };
    };
}
