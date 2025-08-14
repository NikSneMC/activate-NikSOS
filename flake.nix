{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    naersk = {
      url = "github:nix-community/naersk";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        fenix.follows = "fenix";
      };
    };
  };

  outputs = {
    nixpkgs,
    fenix,
    naersk,
    ...
  }: let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      overlays = [fenix.overlays.default];
    };

    naersk' = pkgs.callPackage naersk {};
  in {
    devShells.${system}.default = import ./shell.nix {inherit pkgs;};

    packages.${system} = rec {
      default = activate-niksos;

      activate-niksos = naersk'.buildPackage {
        src = ./.;

        buildInputs = with pkgs; [libxkbcommon];
        nativeBuildInputs = with pkgs; [pkg-config];

        meta.mainProgram = "activate-niksos";
      };
    };
  };
}
