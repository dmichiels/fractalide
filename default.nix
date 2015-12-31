{ pkgs ? import <nixpkgs> {},
lib ? pkgs.lib}:
let
callPackage = lib.callPackageWith (pkgs // support // components // contracts);
support = rec {
  cargo = pkgs.cargo;
  rustcMaster = pkgs.rustcMaster;
  rustRegistry = callPackage ./build-support/rust-packages.nix {};
  buildFractalideComponent = callPackage ./build-support/buildFractalideComponent.nix {};
  buildFractalideContract = callPackage ./build-support/buildFractalideContract.nix {};
  buildFractalideSubnet = callPackage ./build-support/buildFractalideSubnet.nix {};
  buildRustPackage = callPackage ./build-support/buildRustPackage.nix {};
  genName = callPackage ./build-support/genName.nix {};
  capnpc-rust = callPackage ./build-support/capnpc-rust {};
  filterContracts = List:  map (name: (lib.attrValues (lib.filterAttrs (n: v: n == name) contracts))) List;
};
contracts = rec {
  maths-number = callPackage ./contracts/maths/number {};
  maths-boolean = callPackage ./contracts/maths/boolean {};
};
components = rec {
  maths-boolean-not = callPackage ./components/maths/boolean/not {};
  maths-boolean-nand = callPackage ./components/maths/boolean/nand {};
  maths-boolean-add = callPackage ./components/maths/number/add {};
};
in {
  inherit components contracts support;
  component-name = callPackage ./mappings/component-name.nix { inherit components; };
  contract-name = callPackage ./mappings/contract-name.nix { inherit contracts; };

}