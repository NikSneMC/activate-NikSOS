{
  lib,
  rustPlatform,
  libxkbcommon,
  pkg-config,
}:
rustPlatform.buildRustPackage {
  pname = "activate-niksos";
  version = "0.1.0";
  src = ./.;
  cargoHash = "sha256-TuP7p/SuyCEqDTBiYcbdTvH4InRoo/R2RSmmSz7m5zM=";
  buildInputs = [libxkbcommon];
  nativeBuildInputs = [pkg-config];

  meta = with lib; {
    description = ''Windows' "Active Windows" watermark for NikSOS'';
    homepage = "https://github.com/NikSneMC/activate-niksos";
    mainProgram = "activate-niksos";
    platforms = platforms.linux;
    license = licenses.mit;
  };
}
