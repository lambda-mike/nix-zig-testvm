# nix-zig-testvm

Small example of custom derivation building example zig application that consumes Unix system C library to get host and domain names inside NixOS virtual vm.

## Nix derivation

### Build

`nix-build -A getni`

### Run

`result/bin/getni`

## NixOS test VM

### Build VM

`nixos-rebuild build-vm -I nixos-config=./configuration.nix`

### Run VM

`result/bin/run-nix-zig-vm`

Inside the vm in terminal try `getni` or `getnic` - the binaries will be present in the PATH environment variable.
