{pkgs, ...}:
{
  home.packages = with pkgs; [
    nixd
    nil
    asm-lsp
    pyright
    rust-analyzer
    lldb
  ];
}
