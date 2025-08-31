{ pkgs, ... }:
let
  emacsWithTS = pkgs.emacs-pgtk.override {
    withTreeSitter = true;
  };
in 
{
  environment.systemPackages = [ emacsWithTS ];
  services.emacs = {
    enable = true;
    package = emacsWithTS;
    startWithGraphical = true;
    install = true;
  };
  systemd.user.services.emacs.serviceConfig = {
    ExecStartPre = "${pkgs.coreutils}/bin/sleep 10";
  };
}
