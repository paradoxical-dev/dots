{ config, pkgs, lib, userSettings, ... }:
{
  environment.systemPackages = with pkgs; [
    open-webui
  ];
  services.open-webui = {
    enable = true;
    environment = {
      # DISABLE AUTH
      WEBUI_AUTH = "False";
      ENABLE_OAUTH_SIGNUP = "False";
      DEFAULT_USER_ROLE = "admin";

      # SET PATHS
      DATA_DIR = "/home/${userSettings.username}/open-webui/backend/data";
      STATIC_DIR = "/home/${userSettings.username}/open-webui/backend/static";
      FRONTEND_BUILD_DIR = "/home/${userSettings.username}/open-webui/build";
    };
    stateDir = "/home/${userSettings.username}/open-webui/";
  };
  systemd.services.open-webui = {
    serviceConfig = {
      User = "${userSettings.username}";
      DynamicUser = lib.mkForce false;
      ProtectHome = lib.mkForce false;
    };
  };
}
