{
  pkgs ? import <nixpkgs> { },
}:
let
  inherit (pkgs) stdenv lib;

  releases = import ./releases.nix;
  srcAttrs = releases.sources.${stdenv.hostPlatform.system};
in
stdenv.mkDerivation {
  pname = "huffc";
  version = releases.version;

  src = pkgs.fetchurl {
    inherit (srcAttrs) url hash;
  };

  sourceRoot = ".";

  nativeBuildInputs = lib.optionals stdenv.hostPlatform.isLinux [
    pkgs.autoPatchelfHook
  ];

  installPhase = ''
    install -Dm755 huffc $out/bin/huffc
  '';

  installCheckPhase = ''
    $out/bin/huffc --version
  '';

  doInstallCheck = true;

  meta = with lib; {
    description = "Huff language compiler";
    homepage = "https://github.com/huff-language/huff-rs";
    license = licenses.asl20;
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
    mainProgram = "huffc";
  };
}
