# NixOS config

Hyprland desktop in the shape of [Omarchy](https://github.com/basecamp/omarchy) (DHH's Arch + Hyprland setup). "Omar's Hyperland" was read as that. If you meant a different Omar, say so and this can be pointed at their config instead.

This has not been installed. NixOS is not on this machine yet. `hardware-configuration.nix` is a stub that refuses to build until the installer generates the real one.

## What you get

- Hyprland, Waybar, Ghostty, Wofi, Mako, hyprlock, greetd
- Tokyo Night colors, dwindle layout, Super+Return for a terminal
- Your dotfiles from `github:r4ravi2008/dotfiles`, linked for zsh, nvim, Ghostty, Herdr, lazygit, and OpenCode config
- `opencode` and the Codex CLI (`codex`) on PATH
- Tailscale enabled
- Plex and Homebridge present but off, until you flip `services.plex.enable` and `services.homebridge.enable`
- NVIDIA open driver, because GeForce Experience is installed on Windows. Set `hardware.nvidia.open = false` if the card is older, or delete the NVIDIA block if this install is Intel-only

skhd is not installed. That config is for macOS. The Hyprland binds are in `config/hyprland.conf`.

## Codex app

The ChatGPT desktop app with Codex has a Linux preview as `.deb` / `.rpm` for Ubuntu 24.04 and 26.04, Debian 13, and Fedora 43 and 44. There is no official NixOS build. The CLI is what this config installs.

To run the desktop app anyway, after the first boot:

```bash
distrobox create -n ubuntu -i ubuntu:24.04
distrobox enter ubuntu
# download the .deb from https://openai.com/codex/ inside that container and install it
```

## After the USB install

1. Boot the NixOS graphical installer. Do not format `E:` if you still want the Homebridge copy and the wedding videos.
2. `sudo nixos-generate-config --root /mnt`
3. Copy this directory to `/mnt/etc/nixos`, and replace `hardware-configuration.nix` with the generated file. Keep the generated `fileSystems` and boot loader settings.
4. Confirm the username in `flake.nix` matches the user you created.
5. `sudo nixos-rebuild switch --flake /mnt/etc/nixos#rk`

On first login, Herdr plugins and skills are not applied yet. The static links are. Run:

```bash
cd ~/.dotfiles && ./bootstrap.sh
```

Nix has already installed the CLI tools, so the package-manager half of bootstrap may warn. That is fine. Push any unpushed dotfiles commits before the wipe. This flake tracks GitHub, not the WSL working tree.

## Hardware this was written for

- Intel Core i7-14700K
- MSI PRO Z790-A MAX WIFI, BIOS M.10 as of the 2026-09-29 note on `D:`
- NVIDIA GPU, model not read from Windows
- 4x 32 GB Corsair DIMMs
