{
  inputs = {
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = {
    fenix,
    nixpkgs,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [fenix.overlays.default];
    };
    dependencies = with pkgs; [libxkbcommon];

    devDependencies = with pkgs; [pkg-config];
  in {
    packages.${system}.default = pkgs.callPackage ./. {};
    devShells.${system}.default = pkgs.mkShell {
      LD_LIBRARY_PATH = pkgs.lib.strings.makeLibraryPath dependencies;
      packages = with pkgs;
        [
          (fenix.packages.${system}.complete.withComponents [
            "cargo"
            "clippy"
            "rust-src"
            "rustc"
            "rustfmt"
          ])
          alejandra
          bacon
          lldb
          rust-analyzer-nightly
          vscode-extensions.vadimcn.vscode-lldb.adapter
        ]
        ++ dependencies
        ++ devDependencies;
    };
  };
}
