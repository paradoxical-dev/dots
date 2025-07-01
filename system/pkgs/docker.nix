{ pkgs, userSettings, ... }:
{
  environment.systemPackages = with pkgs; [
    docker
    docker-compose
    lazydocker
  ];

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    # moves container data to home partition to preserve storage on root
    extraOptions = "--data-root=/home/${userSettings.username}/docker"; # The corresponding directory will need to chowned with `chown -R root:docker $HOME/doker`
  };

  # add user to docker group
  users.users.${userSettings.username}.extraGroups = [
    "docker"
  ];
}
