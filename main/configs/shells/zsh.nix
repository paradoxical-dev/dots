{ config, pkgs, ... }:

programs.zsh = {
  enable = true;
  enableCompletion = true;
  autosuggestion.enable = true;
  syntaxHighlighting.enable = true;

  shellAliases = {
	  update = "sudo nixos-rebuild switch";

    c = "clear";
	  ff = "fastfetch";
	  ls = "eza -a --icons";
	  ll = "eza -al --icons";
	  lt = "eza -a --tree --level=1 --icons";
	  shutdown = "systemctl poweroff";
	  v = "nvim";
	  wifi = "nmtui";

	  gs = "git status";
	  ga = "git add";
	  gc = "git commit -m";
	  gp = "git push";
	  gpl = "git pull";
	  gst = "git stash";
	  gsp = "git stash; git pull";
	  gcheck = "git checkout";
	  gcredential = "git config credential.helper store";
  };

  history = {
	  size = 10000;
	  path = "/home/gitmoney/.zsh_history";
  };

  oh-my-zsh = {
	  enable = true;
	  plugins = [
	    "git"
	      "sudo"
	      "web-search"
	      "copyfile"
	      "copybuffer"
        "dirhistory"
	  ];
  };

  initExtra = ''
  # Autostart
	if [[ $(tty) == *"pts"* ]]; then
    fastfetch
	else
    echo
    if [ -f /bin/qtile ]; then
      echo "Start Qtile X11 with command Qtile"
    fi
    if [ -f /bin/hyprctl ]; then
      echo "Start Hyprland with command Hyprland"
    fi
	fi

  # Starship
	eval "$(starship init zsh)"

  # Fzf
	source <(fzf --zsh)
  '';
};
