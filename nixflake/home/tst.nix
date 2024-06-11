{ config, pkgs, ... }:
let
  theme = "cobaltcarbon";
  theme2 = "neocarbon";
in 
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "tst";
  home.homeDirectory = "/home/tst";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];
  

  services.easyeffects.enable = true;


  # services.gnome-keyring = {
  #   enable = true;
  #   components = [ "pkcs11" "secrets" "ssh" ];
  # };
   
  dconf.settings = {
  "org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark";
   };
  };


   qt = {
     enable = true;
       platformTheme = {
         name = "adwaita";
       };

     style.name = "Adwaita-Dark";
   };

  fonts.fontconfig.enable = true;

  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

     theme = {
       name = "Adwaita-dark";
       package = pkgs.gnome.gnome-themes-extra;
     };

    # theme = {
    #   name = "palenight";
    #   package = pkgs.palenight-theme;
    # };

    font = {
      name = "Noto Sans";
      package = pkgs.noto-fonts
;
    };

    cursorTheme = {
      name = "Numix-Cursor";
      package = pkgs.numix-cursor-theme;
    };

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };
  # home.sessionVariables.GTK_THEME = "Adwaita-dark"; 
  
  # programs.zsh = {
  #   enable = true;
  # };


  programs.nnn = {
    enable = true;
    package = pkgs.nnn.override ({ withNerdIcons = true; });
  };

  services.gammastep = {
    enable = true;
    latitude = 47.0667;
    longitude = 15.45; 
    provider = "manual";
    tray = true;
  };
  
   # home.sessionVariables.GTK_THEME = "Adwaita";

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
  ".zshrc".source = ../../.zshrc;
  ".config/nvim" = {
    source = ../../nvim;
    recursive = true;
  };
  ".config/alacritty" = {
    source = ../../alacritty;
    recursive = true;
  };
  ".config/tmux/tmux.conf".source = ../../tmux/tmux.conf;
  ".config/tmux/themes/current.conf".source = ../../tmux/themes/terafox.conf;
  ".config/wofi/conf".source = ../../wofi/conf;
  ".config/wofi/style.css".source = ../../wofi/themes/${theme2}.css;
  ".config/hypr/hyprland.conf".source = ../../hypr/hyprland.conf;
  ".config/hypr/themes/current.conf".source = ../../hypr/themes/${theme2}.conf;
  ".config/hypr/modules" = {
    source = ../../hypr/modules;
    recursive = true;
  };
  ".config/hypr/modules/display.conf".source = ../../hypr/modules/display-apollo.conf;
  ".config/hypr/scripts" = {
    source = ../../hypr/scripts;
    recursive = true;
  };
  ".config/waybar/config".source = ../../waybar/config;
  ".config/waybar/themes/current.json".source = ../../waybar/themes/${theme2}.json;
  ".config/waybar/style.css".source = ../../waybar/themes/${theme2}.css;
  ".config/waybar/scripts/temps.sh".source = ../../waybar/scripts/temps-ares.sh;
  # ".config/dunstrc".source = ../dunst/dunstrc;
  ".config/mako/config".source = ../../mako/config;
  ".config/easyeffects/input" = {
    source = ../../easyeffects/config/input;
    recursive = true;
  };
  ".config/easyeffects/output" = {
    source = ../../easyeffects/config/output;
    recursive = true;
  };
  ".config/nnn" = {
    source = ../../nnn;
    recursive = true;
  };
  ".config/nwg-bar" = {
    source = ../../nwg-bar;
    recursive = true;
  };
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/pldcanfly/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}