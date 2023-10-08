{ pkgs, ... }:
let
  getni = pkgs.callPackage ./getni { };
in
{
  # For some reason this causes the full rebuild and takes ages;
  # if you know how to fix it, please open a PR/comment on the issue - thanks!
  # Issue on GH: https://github.com/lambda-mike/nix-zig-testvm/issues/1
  # nixpkgs.overlays = [ (final: prev: (import ./getni { inherit (prev) stdenv zig; })) ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nix-zig";
  networking.domain = "nixos";

  # Enable flakes support
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.windowManager.xmonad.enable = true;
  services.xserver.xkbVariant = "colemak";

  users.users.alice = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      alacritty
      fd
      getni
      helix
      tree
      zig
    ];
    initialPassword = "testpw";
  };

  services.qemuGuest.enable = true;

  system.stateVersion = "23.05";
}