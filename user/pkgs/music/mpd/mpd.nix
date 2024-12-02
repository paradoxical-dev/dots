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

    audio_output {
      type "fifo"
      name "my_fifo"
      path "/tmp/mpd.fifo"
      format "44100:16:2"
    }
    '';
    network.startWhenNeeded = true;
  };
}
