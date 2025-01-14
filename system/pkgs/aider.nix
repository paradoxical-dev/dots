{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ aider-chat ];
}
