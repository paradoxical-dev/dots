{ pkgs, ... }:
{
  home.packages = with pkgs; [
    texliveFull
    # (pkgs.texlive.withPackages (ps: with ps; [
      # latex
      # dvipng
      # amsmath
      # amssymb
    # ]))
  ];
}
