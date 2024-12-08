{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    fail2ban
  ];

  services.fail2ban = {
    enable = true;
    jails = {
      sshd = {
        settings = {
          port = 22;
          filter = "sshd";
          logpath = "/var/log/auth.log";
          maxRetry = 5;
          bantime = 3600;
          findtime = 600;
        };
      };
    };
  };
}
