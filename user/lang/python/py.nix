{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    python3Full
    python3Packages.pip

    # standard packages
    python3Packages.pandas
    python3Packages.numpy

    # pyrola / jupyter support
    python3Packages.pynvim
    python3Packages.jupyter-client
    python3Packages.prompt-toolkit
    python3Packages.pillow
    python3Packages.ilua

    pyenv
  ];
}
