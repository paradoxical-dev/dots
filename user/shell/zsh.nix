{ config, pkgs, userSettings, ... }:
let
  themes = {
    yin = "--light-mode";
    yang = "--dark-mode";
    burst = "--dark-mode";
  };
  code_theme = themes.${userSettings.theme};
in

{

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      update = "sudo nixos-rebuild switch --flake ${config.home.homeDirectory}dots#main";
      hm-update = "home-manager switch --flake ${config.home.homeDirectory}dots; ${config.home.homeDirectory}dots/scripts/theme-switch.sh";
      update-full = "update && hm-update";

      c = "clear";
      ff = "fastfetch";
      fe = "yazi";
      ls = "eza -a --icons";
      ll = "eza -al --icons";
      lt = "eza -a --tree --level=1 --icons";
      shutdown = "systemctl poweroff";
      v = "nvim";
      wifi = "nmtui";
      ai = "aider --model ollama_chat/qwen2.5-coder:14b --weak-model ollama_chat/llama3.2:latest ${code_theme} --no-auto-commits --pretty --stream";

      gs = "git status";
      ga = "git add";
      gc = "git commit -m";
      gp = "git push";
      gpl = "git pull";
      gst = "git stash";
      gsp = "git stash; git pull";
      gcheck = "git checkout";
      gcredential = "git config credential.helper store";
      gg = "lazygit";
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

      	# Environment
      	export SYSTEM_THEME="${userSettings.theme}"
        export OLLAMA_API_BASE="http://127.0.0.1:11434"
    '';
  };

}
