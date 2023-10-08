# nix-zig-testvm

Small example of custom derivation building example zig application that consumes Unix system C library to get host and domain names inside nix virtual vm.

## Nix derivation

### Build

`nix-build -A getni`

### Run

`result/getni`

## NixOS test VM

### Build VM

`nixos-rebuild build-vm -I nixos-config=./configuration.nix`

### Run VM

`result/bin/run-nix-zig-vm`
