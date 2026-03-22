# huff-rs.nix

Nix package for [huffc](https://github.com/huff-language/huff-rs), the Huff language compiler.

Distributes pre-built binaries for:

- `x86_64-linux`
- `aarch64-linux`
- `x86_64-darwin`
- `aarch64-darwin`

## Usage

### Run directly

```sh
nix run github:jezsung/huff-rs.nix -- --version
```

### Add to a flake

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    huff-rs.url = "github:jasg/huff-rs.nix";
  };

  outputs = { nixpkgs, huff-rs, ... }:
    let
      system = "aarch64-darwin"; # or your target system
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ huff-rs.overlays.default ];
      };
    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = [ pkgs.huffc-bin ];
      };
    };
}
```

### Without the overlay

Instead of injecting `huffc-bin` into nixpkgs via an overlay, you can reference the package directly from the flake input:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    huff-rs.url = "github:jezsung/huff-rs.nix";
  };

  outputs = { nixpkgs, huff-rs, ... }:
    let
      system = "aarch64-darwin"; # or your target system
      pkgs = import nixpkgs { inherit system; };
    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = [
          huff-rs.packages.${system}.default
        ];
      };
    };
}
```

This skips the overlay entirely. Use this when you just need the binary and don't need `pkgs.huffc-bin` available throughout your package set.

### With flake-utils

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    huff-rs.url = "github:jezsung/huff-rs.nix";
  };

  outputs = { nixpkgs, flake-utils, huff-rs, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ huff-rs.overlays.default ];
        };
      in {
        devShells.default = pkgs.mkShell {
          packages = [ pkgs.huffc-bin ];
        };
      }
    );
}
```

## License

[MIT](LICENSE). huffc itself is licensed under [Apache 2.0](https://github.com/huff-language/huff-rs/blob/main/LICENSE).
