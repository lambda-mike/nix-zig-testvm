{ pkgs ? import <nixpkgs> { } } :
{
  getni = pkgs.callPackage ./getni { };
}
