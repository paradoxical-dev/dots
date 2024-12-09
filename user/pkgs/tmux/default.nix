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

      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R
      bind-key -r C-h select-window -t :-
      bind-key -r C-l select-window -t :+


      unbind r
      bind r source-file ~/.config/tmux/tmux.conf


      bind C-c run "tmux save buffer - | xclip -i -sel clip"
      bind C-v run "tmux set-buffer $(xclip -o -sel clip); tmux paste-buffer"


      set-option -g status-position top

      set -g status-left ""
      set -g status-right ""
      set-option -g status-bg default
      set-option -g status-fg default
      set-option -g status-justify centre
      set-option -g status-position top

      # Configure window list style
      setw -g window-status-format "${currentTheme.status.window.default}"
      setw -g window-status-current-format "${currentTheme.status.window.current}"
      setw -g window-status-separator "       "

      # Set the status line height to 1
      set-option -g status-interval 5
      set-option -g status-style bg=default,fg=default

      # Make the status line centered
      set-option -g status-justify centre

      # Zen Mode
      set-option -g allow-passthrough on
    '';
  };
}
