{
  description = "Nix package for huffc (Huff language compiler)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachSystem
      [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ]
      (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ self.overlays.default ];
          };
        in
        {
          packages.default = pkgs.huffc-bin;

          apps.default = {
            type = "app";
            program = "${pkgs.huffc-bin}/bin/huffc";
          };

          devShells.default = pkgs.mkShell {
            packages = [ pkgs.huffc-bin ];
          };
        }
      )
    // {
      overlays.default = final: prev: {
        huffc-bin = final.callPackage ./huffc-bin { };
      };

      # Legacy alias for convenience
      overlay = self.overlays.default;
    };
}
