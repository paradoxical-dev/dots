{ pkgs, ... }:
# INFO: You'll need to download the Ubuntu version of the Packet Tracer binaries;
# However, after downloading, you'll need to rename the package to CiscoPacketTracer822_amd64_signed.deb before adding this to the nix-path using:
# `nix-prefetch-url --type sha256 file:///full/path/to/binaries`

# WARN: If you are on wayland, this looks like shit but is fully functional. Haven't found a way to make it look nice on wayland yet
{
  home.packages = with pkgs; [ ciscoPacketTracer8 ];
}
