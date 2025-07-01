{ pkgs, ... }:
{
  # home.packages = with pkgs; [
  #   zed-editor
  # ];

  # programs.zed-editor.enable = true;
  # programs.zed-editor.package = pkgs.zed-editor.fhs;

  home.packages = with pkgs; [
    zed-editor-fhs
  ];
}
