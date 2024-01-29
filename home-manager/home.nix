{ pkgs, ... }: {
    home.packages = with pkgs; [
      htop
      fzf
      git
      git-lfs
      awscli
      ripgrep
      jq
      entr
      rnix-lsp
      git-lfs
      kitty
      zellij
      colima
      kubectl
      poetry
      vscode
      shell_gpt
      wmctrl
    ];

    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      nix-direnv = {
        enable = true;
    };
      # Uncomment and set the path if you use fish shell
      # enableFishIntegration = true;
      # fishIntegrationPath = "/Users/rkommineni/.config/fish/conf.d/direnv.fish";
    };

    services.sxhkd= {
      enable = true;
      keybindings = {
      "super + Return" = "kitty";
      };
    };

    home.stateVersion = "23.11";
    programs.emacs = {
          enable = true;
          extraPackages = epkgs: [ epkgs.pdf-tools epkgs.org-pdftools ]; # non-trivial
    };
}
