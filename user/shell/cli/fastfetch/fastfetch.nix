{ config, pkgs, ... }:

{

  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "auto";
        source = "~/dots/user/shell/cli/fastfetch/goku_ascii.txt";
        height = 15;
        padding = {
          bottom = 2;
        };
      };
      display = {
        separator = " ";
      };
      modules = [
        {
          format = "┌──────────────────────────── Hardware ─────────────────────────────────┐";
          type = "custom";
        }
        {
          key = " {#33} 󰍛 cpu     {#keys}";
          type = "cpu";
          showPeCoreCount = true;
        }
        {
          key = " {#34} 󰉉 disk    {#keys}";
          type = "disk";
          folders = "/";
        }
        {
          key = " {#35}  memory  {#keys}";
          type = "memory";
        }
        {
          key = " {#36} 󰩟 network {#keys}";
          type = "localip";
          format = "{ipv4} ({ifname})";
        }
        {
          format = "└───────────────────────────────────────────────────────────────────────┘";
          type = "custom";
        }
        {
          format = " ";
          type = "custom";
        }
        {
          format = "┌──────────────────────────── Software ─────────────────────────────────┐";
          type = "custom";
        }
        {
          key = " {#34} {icon} distro  {#keys}";
          type = "os";
        }
        {
          key = " {#35}  kernel  {#keys}";
          type = "kernel";
        }
        {
          key = " {#36} 󰇄 desktop {#keys}";
          type = "de";
        }
        {
          key = " {#31}  term    {#keys}";
          type = "terminal";
        }
        {
          key = " {#32}  shell   {#keys}";
          type = "shell";
        }
        {
          format = "└───────────────────────────────────────────────────────────────────────┘";
          type = "custom";
        }
        {
          format = " ";
          type = "custom";
        }
        {
          format = "┌───────────────────────────── Uptime ──────────────────────────────────┐";
          type = "custom";
        }
        {
          key = " {#33} 󰅐 uptime  {#keys}";
          type = "uptime";
        }
        {
          type = "command";
          key = "   age     ";
          keyColor = "magenta";
          text = "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days";
        }
        {
          format = "└───────────────────────────────────────────────────────────────────────┘";
          type = "custom";
        }
        {
          key = " {#39} colors  {#keys}";
          type = "colors";
          symbol = "circle";
        }
      ];
    };
  };

}
