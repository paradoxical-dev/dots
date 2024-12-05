{ config, pkgs, ... }:
{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "none";
      };
      display = {
        separator = " ";
      };
      modules = [
        {
          type = "command";
          key = " ";
          text = "hostname | figlet -f slant";
        }
        # {
        #   type = "custom";
        #   format = " ";
        # }
        {
          format = "OS:";
          type = "custom";
        }
        {
          key = "{#34} {icon} distro  {#keys}";
          type = "os";
        }
        {
          type = "command";
          key = "  Age     ";
          keyColor = "magenta";
          text = "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days";
        }
        {
          key = "{#33}  Uptime  {#keys}";
          type = "uptime";
        }
        {
          type = "custom";
          format = " ";
        }
        {
          type = "custom";
          format = "Services:";
        }
        {
          type = "command";
          key = " ";
          text = "sh ~/dots/user/shell/cli/fastfetch/scripts/services.sh";
        }
        {
          type = "custom";
          format = "  ";
        }
        {
          type = "custom";
          format = "Disk:";
        }
        {
          type = "command";
          key = " ";
          text = "sh ~/dots/user/shell/cli/fastfetch/scripts/disk.sh";
        }
        {
          type = "custom";
          format = " ";
        }
        {
          type = "custom";
          format = "Memory:";
        }
        {
          type = "command";
          key = " ";
          text = "sh ~/dots/user/shell/cli/fastfetch/scripts/ram.sh";
        }
        {
          type = "custom";
          format = " ";
        }
        # {
        #   type = "custom";
        #   format = "Temps:";
        # }
        # {
        #   type = "command";
        #   key = " ";
        #   text = "sh ~/dots/user/shell/cli/fastfetch/scripts/temps.sh";
        # }
      ];
    };
  };
}
