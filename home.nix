{config, pkgs, ...}:

{
    home.stateVersion = "24.05";
    home.username = "gitmoney";
    home.homeDirectory = "/home/gitmoney";

    #ZSH
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

	      #Starship
	      eval "$(starship init zsh)"

	      #Fzf
	      source <(fzf --zsh)
      '';
    };

    #GIT
    programs.git = {
      enable = true;
      userName = "paradoxical-dev";
      userEmail = "jaredonnell21@gmail.com";
    };

    #NVIM
    programs.neovim = {
      enable = true;
      defaultEditor = true;
    };

    # KITTY
    programs.kitty = {
      enable = true;
      # themeFile = "./kitty/current-theme.conf";
      keybindings = {
        "ctrl+shift+h" = "previous_tab";
        "ctrl+shift+l" = "next_tab";
        "ctrl+shift+;" = "next_layout";
      };
      shellIntegration.enableBashIntegration = true;
      shellIntegration.enableZshIntegration = true;
      settings = {
        background_opacity = 0.8;
        active_tab_background = "#E29ECA";
        inactive_tab_background = "#090610";
        tab_title_template = "{tab.active_oldest_wd}";
        active_tab_title_template = "{title}";
        tab_active_symbol = "󱌣";
        tab_title_max_length = 50;
        window_border_width = 1;
        active_border_color = "#414141";
        inactive_border_color = "#414141";
        window_padding_width = 5;
        cursor_shape = "block";
      };
      extraConfig = ''
        include /home/gitmoney/dots/kitty/current-theme.conf 

        enabled_layouts    Grid, Stack

        font_size          12
        font_family        JetBrainsMonoNL NFM Regular
        italic_font        Victor Mono Italic
        bold_italic_font   Victor Mono Bold Italic
      '';
    };
}