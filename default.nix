{ rustPlatform, libxkbcommon, pkg-config }:
rustPlatform.buildRustPackage {
  pname = "activate-linux";
  version = "0.1.0";
  src = ./.;
  cargoHash = "sha256-TtTcYEuNPd25j7raC0uengUNb44O7L52IVBWAYxHAuU=";
  buildInputs = [ libxkbcommon ];
  nativeBuildInputs = [ pkg-config ];
}
