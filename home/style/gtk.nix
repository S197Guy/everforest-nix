{
  pkgs,
  ...
}: {
  gtk = {
    enable = true;
    theme = {
      name = "Everforest-Dark-BL";
      package = pkgs.everforest-gtk-theme;
    };
    iconTheme = {
      name = "Everforest-Dark";
      package = pkgs.everforest-icon-theme;
    };
    cursorTheme = {
      name = "Capitaine Cursors";
      package = pkgs.capitaine-cursors;
      size = 24;
    };
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 11;
    };
  };

  home.pointerCursor = {
    name = "Capitaine Cursors";
    package = pkgs.capitaine-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };
}
