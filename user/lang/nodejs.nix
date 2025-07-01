{ pkgs, deno, ... }:
{
  home.packages = with pkgs; [
    nodePackages_latest.nodejs
    nodePackages_latest.nodemon
    # nodePackages_latest.ijavascript
    eslint

    deno
  ];
}
