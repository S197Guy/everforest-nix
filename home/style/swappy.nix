{ config, ... }: {
  home.file.".config/swappy/config".text = ''
[Default]
save_dir=${config.home.homeDirectory}/Pictures/Screenshots
save_filename_format=Screenshot-%Y%m%d-%H%M%S.png
show_panel=false
line_size=5
text_size=20
text_font=JetBrainsMono Nerd Font
paint_mode=brush
early_exit=true
fill_shape=false
'';
}
