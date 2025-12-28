{ pkgs, config, ... }:

let
  # 1. Define the toolchain with the Overlay
  # Ensure your flake inputs have: rust-overlay.url = "github:oxalica/rust-overlay";
  rustToolchain = pkgs.rust-bin.stable.latest.default.override {
    extensions = [ "rust-src" "clippy" "rustfmt" "rust-analyzer" ];
  };
in
{
  home.packages = with pkgs; [
    # The Toolchain
    rustToolchain

    # Build Dependencies (Commonly needed for compiling Rust crates)
    openssl
    pkg-config
    cmake
    gcc
    
    # The IDE
    jetbrains.rust-rover
  ];

  # 2. Environment Variables
  # These guide RustRover to the correct locations without needing symlinks
  home.sessionVariables = {
    # Point to the source code of the standard library (Crucial for Go to Definition)
    RUST_SRC_PATH = "${rustToolchain}/lib/rustlib/src/rust/library";
    
    # Help pkg-config find libraries like OpenSSL
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
  };

  # 3. Direnv Setup (Highly Recommended)
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
