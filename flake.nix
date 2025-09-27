{
    description = "A very basic NixOS flake";
    
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    };
    
    outputs = { self, nixpkgs, ... }: {
        nixosConfigurations.erkan-nixos = nixpkgs.lib.nixosSystem {
	    system = "x86_64-linux";
	    modules = [ ./configuration.nix ];
	};
    };
}
