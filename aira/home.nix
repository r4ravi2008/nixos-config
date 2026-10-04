{
  pkgs,
  dotfiles,
  lib,
  ...
}:
{
  home.username = "aira";
  home.homeDirectory = "/home/aira";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    opencode
    codex
  ];

  programs.git = {
    enable = true;
    settings.user.name = "r4ravi2008";
    settings.user.email = "r4ravi2008@gmail.com";
  };

  # Static links from github:r4ravi2008/dotfiles. Herdr plugins, skills, and
  # Pi still come from ~/.dotfiles/bootstrap.sh, run once after login.
  home.file = {
    ".bash_aliases".source = "${dotfiles}/.bash_aliases";
    ".zshrc".source = "${dotfiles}/zsh/zshrc";
    ".zshenv".source = "${dotfiles}/zsh/zshenv";
    ".config/nvim".source = "${dotfiles}/nvim";
    ".config/ghostty/config".source = "${dotfiles}/ghostty/config";
    ".config/herdr/config.toml".source = "${dotfiles}/herdr/config.toml";
    ".config/lazygit/config.yml".source = "${dotfiles}/lazygit/config.yml";
    ".config/ImageMagick/type.xml".source = "${dotfiles}/imagemagick/type.xml";
    ".config/opencode/ocx.jsonc".source = "${dotfiles}/opencode/ocx.jsonc";
    ".config/opencode/package.json".source = "${dotfiles}/opencode/package.json";
    ".config/opencode/plugins".source = "${dotfiles}/opencode/plugins";
    ".config/hypr/hyprland.conf".source = ./config/hyprland.conf;
    ".config/waybar/config.jsonc".source = ./config/waybar.jsonc;
    ".config/waybar/style.css".source = ./config/waybar.css;
  };

  home.activation.cloneDotfiles = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -d "$HOME/.dotfiles/.git" ]; then
      ${pkgs.git}/bin/git clone https://github.com/r4ravi2008/dotfiles.git "$HOME/.dotfiles"
    fi
  '';

  programs.zsh.enable = true;
}
