{ config, pkgs, userSettings, systemSettings, ... }:
{
  environment.systemPackages = with pkgs; [
    mpd
    mpc-cli
  ];
  services.mpd = {
    enable = true;
    musicDirectory = "/home/${userSettings.username}/Music";
    user = "${userSettings.username}";
    extraConfig = ''
    audio_output {
      type "pipewire"
      name "PipeWire Output"
    }
    '';
    startWhenNeeded = true;
  };
  systemd.services.mpd = {
    environment.XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.${userSettings.username}.uid}";
    serviceConfig.SupplementaryGroups = [ "pipewire" ];
  };
}
