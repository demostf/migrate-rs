{
  rustPlatform,
  lib,
}: let
  inherit (lib.sources) sourceByRegex;
  inherit (builtins) fromTOML readFile;
  src = sourceByRegex ../. ["Cargo.*" "(src)(/.*)?"];
  cargoPackage = (fromTOML (readFile ../Cargo.toml)).package;
in
  rustPlatform.buildRustPackage {
    pname = cargoPackage.name;
    inherit (cargoPackage) version;

    inherit src;

    cargoLock = {
      lockFile = ../Cargo.lock;
    };
  }