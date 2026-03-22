{
  version = "0.3.2";

  sources = {
    "x86_64-linux" = {
      url = "https://github.com/huff-language/huff-rs/releases/download/nightly/huff_nightly_linux_amd64.tar.gz";
      hash = "sha256-XQB++ZkF8MvPC2UD13ZwrgmSk8+Lw4lPQI8gDB3AidM=";
    };
    "aarch64-linux" = {
      url = "https://github.com/huff-language/huff-rs/releases/download/nightly/huff_nightly_linux_arm64.tar.gz";
      hash = "sha256-+hBQPWr4XvFyzNncudbuXuRFiFSTzomyFoLZ/C1NfkQ=";
    };
    "x86_64-darwin" = {
      url = "https://github.com/huff-language/huff-rs/releases/download/nightly/huff_nightly_darwin_amd64.tar.gz";
      hash = "sha256-UzsO6PG8oL2Y+Go868NlerUp8YPqCociSQNQHenwThk=";
    };
    "aarch64-darwin" = {
      url = "https://github.com/huff-language/huff-rs/releases/download/nightly/huff_nightly_darwin_arm64.tar.gz";
      hash = "sha256-Uo+DL89VZnPnw0DiVQV21ti51ejlE8zjlZBsrfQKY8Y=";
    };
  };
}
