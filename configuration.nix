{ pkgs, ... }:
let
  # TODO experiment with using overlay instead of callPackage directly here
  getni = pkgs.callPackage ./getni { };
in
{
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