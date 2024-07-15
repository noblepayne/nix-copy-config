{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
  in {
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
    nixosConfigurations.copyconfig = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [./configuration.nix];
    };
  };
}
