{pkgs, ...}:
{
  home.packages = with pkgs; [
    nixd
    nil
    asm-lsp
  ];
}
