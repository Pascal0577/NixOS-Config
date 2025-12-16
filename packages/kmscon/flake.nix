{
    inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    outputs = { self, nixpkgs }:
    let
        systems = [ "x86_64-linux" ];
        forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
        packages = forAllSystems (system:
            let
                pkgs = import nixpkgs { inherit system; };
            in {
                kmscon = pkgs.callPackage ./package.nix {};
                default = self.packages.${system}.kmscon;
            }
        );
    };
}
