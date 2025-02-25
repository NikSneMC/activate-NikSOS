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
  cargoHash = "sha256-geUy5xjmM9kOrl+Z10rV15GsAlWruMdbLjAujRTFQGY=";
  buildInputs = [libxkbcommon];
  nativeBuildInputs = [pkg-config];
  useFetchCargoVendor = true;

  meta = with lib; {
    description = ''Windows' "Active Windows" watermark for NikSOS'';
    homepage = "https://github.com/NikSneMC/activate-niksos";
    mainProgram = "activate-niksos";
    platforms = platforms.linux;
    license = licenses.mit;
  };
}
