{ config, pkgs, userSettings, ... }:
let
  themes = {
    yin = "--light-mode";
    yang = "--dark-mode";
    burst = "--dark-mode";
    shards = "--dark-mode";
  };
  code_theme = themes.${userSettings.theme};
  hist_size = 10000;
  fzf-themes = {
    shards = {
      fg_plus = "#f8f8fb";
      header = "#f5c2e7";
      hl_plus = "#94e2d5";
      hl = "#b4befe";
      info = "#f5e0dc";
      marker = "#f38ba8";
      prompt = "#b4befe";
      spinner = "#94e2d5";
      pointer = "#b4befe";
      bg_plus = "#45475b";
      border = "#404040";
    };
  };
  fzf-colors = fzf-themes.${userSettings.theme};
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
      size = hist_size;
      path = "${config.home.homeDirectory}.zsh_history";
      save = hist_size;
      share = true;
      append = true;
      ignoreSpace = true;
      ignoreDups = true;
      ignoreAllDups = true;
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

    plugins = [
      {
        name = "fzf-tab";
        src = pkgs.fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "master";
          sha256 = "EWMeslDgs/DWVaDdI9oAS46hfZtp4LHTRY8TclKTNK8=";
        };
      }
      {
        name = "vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];

    initExtra = ''
        # Autostart #
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

        # Starship #
        eval "$(starship init zsh)"

        # Keymaps #
        bindkey '^p' history-search-backward
        bindkey '^n' history-search-forward

        # VI mode customization #
        export ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK        
        export ZVM_KEYTIMEOUT=0
        export ZVM_VI_HIGHLIGHT_BACKGROUND=#45475b
        function zvm_after_select_vi_mode() {
          case $ZVM_MODE in
            $ZVM_MODE_NORMAL)
              echo 'n' > ${config.home.homeDirectory}.current_vi_mode
              ;;
            $ZVM_MODE_INSERT)
              echo 'i' > ${config.home.homeDirectory}.current_vi_mode
              ;;
            $ZVM_MODE_VISUAL)
              echo 'v' > ${config.home.homeDirectory}.current_vi_mode
              ;;
            $ZVM_MODE_REPLACE)
              echo 'r' > ${config.home.homeDirectory}.current_vi_mode
              ;;
            $ZVM_MODE_VISUAL_LINE)
              echo 'vl' > ${config.home.homeDirectory}.current_vi_mode
              ;;
          esac
        }

        # Case insensitive completion
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

        # Fzf #
        eval "$(fzf --zsh)"
        zstyle ':completion:*' menu no
        zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
        zstyle ':fzf-tab:*' use-fzf-default-opts yes
        export FZF_DEFAULT_OPTS='
        --color=fg+:${fzf-colors.fg_plus},bg+:${fzf-colors.bg_plus}
        --color=hl:${fzf-colors.hl},hl+:${fzf-colors.hl_plus},info:${fzf-colors.info},marker:${fzf-colors.marker}
        --color=prompt:${fzf-colors.prompt},spinner:${fzf-colors.spinner},pointer:${fzf-colors.pointer},header:${fzf-colors.header}
        --color=border:${fzf-colors.border},label:#aeaeae,query:${fzf-colors.fg_plus},gutter:-1
        --border="rounded" --preview-window="border-rounded"
        --prompt=" " --marker=""
        --separator="─" --scrollbar="│" --info="right"'

        ## fzf previews ##
        # service status
        zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'

        # file content
        zstyle ':fzf-tab:complete:*:*' fzf-preview 'less $realpath'
        export LESSOPEN='|${config.home.homeDirectory}dots/scripts/lessfilter.sh %s'
        zstyle ':fzf-tab:complete:*:options' fzf-preview 
        zstyle ':fzf-tab:complete:*:argument-1' fzf-preview

        # env vars
        zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' \
      	fzf-preview 'echo ''${(P)word}'

        # commands
        zstyle ':fzf-tab:complete:-command-:*' fzf-preview \
        '(out=$(tldr --color always "$word") 2>/dev/null && echo $out) || (out=$(MANWIDTH=$FZF_PREVIEW_COLUMNS man "$word") 2>/dev/null && echo $out) || (out=$(which "$word") && echo $out) || echo "''${(P)word}"'

        # Environment #
        export SYSTEM_THEME="${userSettings.theme}"
        export OLLAMA_API_BASE="http://127.0.0.1:11434"

        # Add Cargo to PATH
        export PATH="$HOME/.cargo/bin:$PATH"
    '';
  };

}
