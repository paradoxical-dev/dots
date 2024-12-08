{ config, pkgs, userSettings, ... }:
{
  environment.systemPackages = with pkgs; [
    sudo
  ];

  security.sudo = {
    enable = true;
    extraConfig = ''
      # Enable the running of the fail2ban script which by default requires sudo privelages
      ${userSettings.username} ALL=(ALL) NOPASSWD: /home/${userSettings.username}/dots/user/shell/cli/fastfetch/scripts/fail2ban.sh
    '';
  };
}
