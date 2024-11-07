{config, pkgs, ...}:

# TODO: paths are not recognized for some reason
# let
#   zshConf = import ./configs/shells/zsh.nix { inherit config pkgs; };
#   kittyConf = import ./configs/kitty/kitty.nix { inherit config pkgs; };
#   fastfetchConf = import ./configs/fastfetch/fastfetch.nix { inherit config pkgs; };
# in 
{
    home.stateVersion = "24.05";
    home.username = "gitmoney";
    home.homeDirectory = "/home/gitmoney/";

    # programs = {
    #   zsh = zshConf.programs.zsh;
    #   kitty = kittyConf.programs.kitty;
    #   fastfetch = fastfetchConf.programs.fastfetch;
    #   git = {
    #     enable = true;
    #     userName = "paradoxical-dev";
    #     userEmail = "jaredonnell21@gmail.com";
    #   };
    #   neovim = {
    #     enable = true;
    #     defaultEditor = true;
    #   };
    # };

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
        include /home/gitmoney/dots/main/configs/kitty/current-theme.conf 

        enabled_layouts    Grid, Stack

        font_size          12
        font_family        JetBrainsMonoNL NFM Regular
        italic_font        Victor Mono Italic
        bold_italic_font   Victor Mono Bold Italic
      '';
    };

    # FASTFETCH
    programs.fastfetch = {
      enable = true;
      settings = {
        logo = {
          type = "kitty";
          source = "/home/gitmoney/dots/main/configs/fastfetch/goku2.png";
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
          key = " ";
          type = "custom";
        }
        {
          key = " ";
          type = "custom";
        }
        {
          key = " {#31} user    {#keys}";
          type = "title";
          format = "{user-name}";
        }
        {
          key = " {#32}󰇅 hname   {#keys}";
          type = "title";
          format = "{host-name}";
        }
        {
          key = " {#33}󰅐 uptime  {#keys}";
          type = "uptime";
        }
        {
          key = " {#34}{icon} distro  {#keys}";
          type = "os";
        }
        {
          key = " {#35} kernel  {#keys}";
          type = "kernel";
        }
        {
          key = " {#36}󰇄 desktop {#keys}";
          type = "de";
        }
        {
          key = " {#31} term    {#keys}";
          type = "terminal";
        }
        {
          key = " {#32} shell   {#keys}";
          type = "shell";
        }
        {
          key = " {#33}󰍛 cpu     {#keys}";
          type = "cpu";
          showPeCoreCount = true;
        }
        {
          key = " {#34}󰉉 disk    {#keys}";
          type = "disk";
          folders = "/";
        }
        {
          key = " {#35} memory  {#keys}";
          type = "memory";
        }
        {
          key = " {#36}󰩟 network {#keys}";
          type = "localip";
          format = "{ipv4} ({ifname})";
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
