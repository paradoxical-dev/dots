{ pkgs, ... }:
{
  # home.packages = with pkgs; [
  #   vscode
  # ];

  # programs.vscode.enable = true;
  # programs.vscode.package = pkgs.vscode.fhs;

  home.packages = with pkgs; [
    vscode.fhs
  ];
}
