# Omarchy-shaped desktop: Hyprland, a bar, Ghostty, a launcher, and a locker.
# Colors are Tokyo Night, which is also Omarchy's default theme.
{ pkgs, ... }:
{
  programs.hyprland.enable = true;

  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
      user = "greeter";
    };
  };

  environment.systemPackages = with pkgs; [
    waybar
    ghostty
    wofi
    mako
    hyprlock
    hypridle
    hyprpaper
    nerd-fonts.jetbrains-mono
  ];

  # Hyprland on NVIDIA needs these or windows stay black.
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  # User config is linked from this repo by home-manager, not from ~/.dotfiles.
  # ~/.dotfiles has Ghostty and shell config, not a Hyprland config yet.
}
