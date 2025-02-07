{ config, pkgs, userSettings, ... }:
let
  themes = {
    yin = {
      status = {
        window = {
          default = "#[fg=#39393b]#[Italics]#I: #[Italics]#W";
          current = "#[fg=#c9c7cd,bg=#28282b]    #[Italics]#I: #[Italics]#W    ";
        };
      };
    };
    yang = {
      status = {
        window = {
          default = "#[fg=#e7e7e7]#[Italics]#I: #[Italics]#W";
          current = "#[fg=#28282b,bg=#ebebeb]    #[Italics]#I: #[Italics]#W    ";
        };
      };
    };
    burst = {
      status = {
        window = {
          default = "#[fg=#e7e7e7]#[Italics]#I: #[Italics]#W";
          current = "#[fg=#28282b,bg=#ebebeb]    #[Italics]#I: #[Italics]#W    ";
        };
      };
    };
    shards = {
      status = {
        window = {
          default = "#[fg=#666666]#[fg=#232526,bg=#666666]#[Italics]#[Bold]#I#[fg=#666666,bg=#232526] #[fg=#666666,bg=#232526]#[Italics] #W #[fg=#232526,bg=default]";
          current = "#[fg=#94e2d5]#[fg=#232526,bg=#94e2d5]#[Italics]#[Bold]#I#[fg=#94e2d5,bg=#232526] #[fg=#94e2d5,bg=#232526]#[Italics] #W #[fg=#232526,bg=default]";
        };
        left = {
          # default = "#[fg=#f5c2e7]#[fg=#232526,bg=#f5c2e7]#{?client_prefix,󰌪,󱐋}#[fg=#f5c2e7,bg=#232526] #[fg=#f5c2e7,bg=#232526]T-MODE#[fg=#232526,bg=default] ";
        };
        right = { };
        command_mode_color = "#f2cdcd";
        command_mode_icon = "󱐋";
        norm_mode_color = "#f5c2e7";
        norm_mode_icon = "󰌪";
      };
      default_pane_border = "#404040";
      current_pane_border = "#b4befe";
      command_style = "'fg=#b4befe,bg=default'";
    };
  };

  currentTheme = themes.${userSettings.theme};
in
{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    mouse = true;
    prefix = "C-s";
    keyMode = "vi";
    baseIndex = 1;
    escapeTime = 0;
    extraConfig = ''
      set -g default-terminal 'tmux-256color'
      set-option -ga terminal-overrides ",xterm-256color:Tc"

      # Navigation
      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R
      bind-key -r C-h select-window -t :-
      bind-key -r C-l select-window -t :+

      # Extra binds
      unbind r
      bind r source-file ~/.config/tmux/tmux.conf
      bind C-c run "tmux save buffer - | xclip -i -sel clip"
      bind C-v run "tmux set-buffer $(xclip -o -sel clip); tmux paste-buffer"

      # TPM
      set -g @plugin 'tmux-plugins/tpm'

      # FZF
      set -g @plugin 'sainnhe/tmux-fzf'
      set -g @plugin 'wfxr/tmux-fzf-url'

      # Statusline Options
      set-option -g status-position top
      prefix_color="#{?client_prefix,${currentTheme.status.command_mode_color},${currentTheme.status.norm_mode_color}}"
      prefix_symbol="#{?client_prefix,${currentTheme.status.command_mode_icon},${currentTheme.status.norm_mode_icon}}"
      set -g status-left "#[fg=''${prefix_color}]#[fg=#232526,bg=''${prefix_color}]''${prefix_symbol}#[fg=''${prefix_color},bg=#232526] #[fg=''${prefix_color},bg=#232526]T-MODE#[fg=#232526,bg=default] "

      set -g status-left-length 50
      set -g status-right ""
      set-option -g status-style bg=default,fg=default

      set -g renumber-windows on
      set-option -g status-bg default
      set-option -g status-fg default
      set-option -g status-justify centre
      set-option -g status-position top
      set-option -g status-interval 5
      set-option -g message-style ${currentTheme.command_style}
      set-option -g message-command-style ${currentTheme.command_style}

      # Configure window list style
      setw -g window-status-format "${currentTheme.status.window.default}"
      setw -g window-status-current-format "${currentTheme.status.window.current}"
      setw -g window-status-separator "    "

      # Pane border
      set -g pane-border-style fg=${currentTheme.default_pane_border}
      set -g pane-active-border-style fg=${currentTheme.current_pane_border}

      # Zen Mode
      set-option -g allow-passthrough on

      run '~/.tmux/plugins/tpm/tpm'
    '';
  };
}
