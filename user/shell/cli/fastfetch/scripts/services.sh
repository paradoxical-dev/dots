#/bin/sh

# USER
pipewire_status=$(systemctl --user is-active pipewire >/dev/null 2>&1 && echo -e "\033[32m●\033[0m" || echo -e "\033[31m●\033[0m")
mpd_status=$(systemctl --user is-active mpd >/dev/null 2>&1 && echo -e "\033[32m●\033[0m" || echo -e "\033[31m●\033[0m")
dconf_status=$(systemctl --user is-active dconf >/dev/null 2>&1 && echo -e "\033[32m●\033[0m" || echo -e "\033[31m●\033[0m")
dbus_status=$(systemctl --user is-active dbus >/dev/null 2>&1 && echo -e "\033[32m●\033[0m" || echo -e "\033[31m●\033[0m")
hypridle=$(systemctl --user is-active hypridle >/dev/null 2>&1 && echo -e "\033[32m●\033[0m" || echo -e "\033[31m●\033[0m")
mpdris=$(systemctl --user is-active mpdris2 >/dev/null 2>&1 && echo -e "\033[32m●\033[0m" || echo -e "\033[31m●\033[0m")

# SYSTEM
ssh=$(systemctl is-active sshd >/dev/null 2>&1 && echo -e "\033[32m●\033[0m" || echo -e "\033[31m●\033[0m")
network_manager=$(systemctl is-active NetworkManager >/dev/null 2>&1 && echo -e "\033[32m●\033[0m" || echo -e "\033[31m●\033[0m")
bluetooth=$(systemctl is-active bluetooth >/dev/null 2>&1 && echo -e "\033[32m●\033[0m" || echo -e "\033[31m●\033[0m")
firewall=$(systemctl is-active firewall >/dev/null 2>&1 && echo -e "\033[32m●\033[0m" || echo -e "\033[31m●\033[0m")
unbound=$(systemctl is-active unbound >/dev/null 2>&1 && echo -e "\033[32m●\033[0m" || echo -e "\033[31m●\033[0m")
fail2ban=$(systemctl is-active fail2ban >/dev/null 2>&1 && echo -e "\033[32m●\033[0m" || echo -e "\033[31m●\033[0m")
docker=$(systemctl is-active docker >/dev/null 2>&1 && echo -e "\033[32m●\033[0m" || echo -e "\033[31m●\033[0m")

# Will be moving these to docker containers to include in docker stats
# ollama=$(systemctl is-active ollama >/dev/null 2>&1 && echo -e "\033[32m●\033[0m" || echo -e "\033[31m●\033[0m")
# open_webui=$(systemctl is-active open-webui >/dev/null 2>&1 && echo -e "\033[32m●\033[0m" || echo -e "\033[31m●\033[0m")


# Display statuses inline
echo -e "           \033[3;31mUser \033[0m                            \033[3;31mSystem \033[0m"
echo -e "  Pipewire: $pipewire_status     MPD:    $mpd_status         Docker:    $docker    SSH:       $ssh"
echo -e "  dconf:    $dconf_status     DBus:   $dbus_status         Fail2Ban:  $fail2ban    Unbound:   $unbound"
echo -e "  HyprIdle: $hypridle     MPDris: $mpdris         Bluetooth: $bluetooth    Firewall:  $firewall"
# echo -e "                                    Docker:          $docker"
