{ config, pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    mouse = true;
    prefix = "C-s";
    keyMode = "vi";
    terminal = "screen-256color";
    baseIndex = 1;
    extraConfig = ''
      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R
      bind-key -r C-h select-window -t :-
      bind-key -r C-l select-window -t :+


      unbind r
      bind r source-file ~/.tmux.conf


      bind C-c run "tmux save buffer - | xclip -i -sel clip"
      bind C-v run "tmux set-buffer $(xclip -o -sel clip); tmux paste-buffer"


      set-option -g status-position top

      set -g status-left ''
      set -g status-right ''
      set-option -g status-bg default
      set-option -g status-fg default
      set-option -g status-justify centre
      set-option -g status-position top

      # Configure window list style
      setw -g window-status-format "#[fg=#39393b]#[Italics]#I: #[Italics]#W"
      setw -g window-status-current-format "#[fg=#c9c7cd,bg=#28282b]    #[Italics]#I: #[Italics]#W    "
      setw -g window-status-separator "       "

      # Set the status line height to 1
      set-option -g status-interval 5
      set-option -g status-style bg=default,fg=default

      # Make the status line centered
      set-option -g status-justify centre

      # Zen Mode
      set-option -g allow-passthrough on
    ''
  };
}
