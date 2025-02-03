{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    # python3Full
    # python3Packages.pip

    # global packages
    (python3.withPackages (ppkgs: [
      # standard packages
      ppkgs.debugpy
      ppkgs.pandas
      ppkgs.numpy
      ppkgs.matplotlib

      # pyrola / jupyter support
      ppkgs.pynvim
      ppkgs.jupyter-client
      ppkgs.prompt-toolkit
      ppkgs.pillow
      ppkgs.ilua
    ]))

    pyenv
  ];
}
