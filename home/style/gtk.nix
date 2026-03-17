{pkgs, ...}: {
  gtk = {
    enable = true;
    theme = {
      name = "Everforest-Dark-B";
      package = pkgs.everforest-gtk-theme;
    };
    iconTheme = {
      name = "Everforest-Dark";
      package = pkgs.everforest-gtk-theme;
    };
    cursorTheme = {
      name = "breeze-dark";
      package = pkgs.kdePackages.breeze-icons;
      size = 24;
    };
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 11;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  dconf.settings = {
        "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      cursor-theme = "breeze-dark";
      cursor-size = 24;
    };
  };

  home.pointerCursor = {
    name = "breeze-dark";
    package = pkgs.kdePackages.breeze-icons;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "adwaita-dark";
  };

  home.sessionVariables = {
    XCURSOR_THEME = "breeze-dark";
    XCURSOR_SIZE = "24";
  };
}
