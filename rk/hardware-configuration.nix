# Replace this file before installing.
# On the mounted target: sudo nixos-generate-config --root /mnt
# Then copy the generated hardware-configuration.nix over this one.
{ lib, ... }:
{
  assertions = [
    {
      assertion = false;
      message = "Replace nixos/hardware-configuration.nix with the file from nixos-generate-config before building.";
    }
  ];
  boot.loader.systemd-boot.enable = lib.mkDefault true;
  boot.loader.efi.canTouchEfiVariables = lib.mkDefault true;
}
