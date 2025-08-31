{ pkgs, ... }:
let
  emacsWithTS = pkgs.emacs-pgtk.override {
    withTreeSitter = true;
  };
in 
{
  home.packages = [
    emacsWithTS
  ];
  # services.emacs = {
  #   enable = true;
  #   package = emacsWithTS;
  #   client = {
  #     enable = true;
  #     # arguments = [
  #     #   "-c"
  #     #   "~"
  #     # ];
  #   };
  #   startWithUserSession = "graphical";
  #   socketActivation.enable = false;
  # };
  # systemd.user.extraConfig = ''
  # [Service]
  # Environment=WAYLAND_DISPLAY=${builtins.getEnv "WAYLAND_DISPLAY"}
  # Environment=DISPLAY=${builtins.getEnv "DISPLAY"}
  # '';
}
