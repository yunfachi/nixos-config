let
  combinedManager = import (builtins.fetchTarball {
    url =
      "https://github.com/flafydev/combined-manager/archive/725f45b519187d6e1a49fe4d92b75d32b0d05687.tar.gz";
    sha256 = "sha256:0kkwx01m5a28sd0v41axjypmiphqfhnivl8pwk9skf3c1aarghfb";
  });
in combinedManager.mkFlake {
  description = "NixOS configuration";

  lockFile = ./flake.lock;

  initialInputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  configurations = {
    PocoMachine = {
      system = "x86_64-linux";
      specialArgs = rec {
        configDir = "/etc/nixos";
        configFlake = "${configDir}?submodules=1";
      };
      modules = [
        ./configuration.nix
        ({ lib, ... }: { imports = (import ./utils { inherit lib; }).modules; })
      ];
    };
  };

  # Optional
  # outputs = _inputs: { };
}
