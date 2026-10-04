# Starter for the MSI PRO Z790-A MAX WIFI / i7-14700K machine.
# "Omar's Hyperland" is treated as DHH's Omarchy (opinionated Hyprland).
# This is a launch pad, not a copy of the Arch installer.
{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./hyprland.nix
  ];

  networking.hostName = "aira";
  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;

  users.users.aira = {
    isNormalUser = true;
    description = "aira";
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
      "input"
    ];
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;
  security.sudo.wheelNeedsPassword = true;

  environment.systemPackages = with pkgs; [
    git
    curl
    wget
    jq
    ripgrep
    fd
    fzf
    zoxide
    lazygit
    tmux
    neovim
    nodejs
    bun
    rustup
    podman
    podman-compose
    distrobox
    # Terminal agents. The ChatGPT/Codex desktop app has no NixOS package;
    # see README for the Ubuntu distrobox path. `codex` here is the CLI.
    opencode
    codex
    btop
    fastfetch
    wl-clipboard
    brightnessctl
    pavucontrol
  ];

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  services.tailscale.enable = true;
  # Exit nodes drop traffic unless reverse-path filtering is loose.
  networking.firewall.checkReversePath = "loose";

  # Flip these on after the disk layout and the Homebridge restore are settled.
  services.plex = {
    enable = false;
    openFirewall = true;
  };
  services.homebridge = {
    enable = false;
    openFirewall = true;
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  networking.networkmanager.enable = true;
  services.openssh.enable = true;

  # NVIDIA is installed on the Windows side (GeForce Experience). Turn this
  # off if the NixOS box is Intel-only.
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics.enable = true;

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  system.stateVersion = "25.11";
}
