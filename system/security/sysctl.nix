{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    sysctl
  ];

  boot.kernel.sysctl = {
    "net.ipv4.conf.all.accept_source_route" = "0";
    "net.ipv6.conf.all.accept_source_route" = "0";
    "net.ipv4.conf.all.rp_filter" = "1";
    "net.ipv4.conf.all.accept_redirects" = "0";
    "net.ipv6.conf.all.accept_redirects" = "0";
    "net.ipv4.conf.all.log_martians" = "1";
    "net.ipv4.tcp_syncookies" = "1";
    "fs.suid_dumpable" = "0";
  };
}
