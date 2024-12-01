{ config, pkgs, userSettings, systemSettings, ... }:
{
  home.packages = with pkgs; [
    mpd
    mpc-cli
  ];
  services.mpd = {
    enable = true;
    musicDirectory = "/home/${userSettings.username}/Music";
    # user = "${userSettings.username}";
    extraConfig = ''
    audio_output {
      type "pipewire"
      name "PipeWire Output"
    }
    '';
    network.startWhenNeeded = true;
  };
}
