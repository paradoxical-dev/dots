{ pkgs, userSettings, ... }:
{
  virtualisation.libvirtd = {
    enable = true;
  };
  environment.systemPackages = with pkgs; [ virt-manager ];

  # bridged network
  # networking.bridges = {
  #   br0 = {
  #     interfaces = [ "wlp3s0" ];
  #   };
  # };
}
