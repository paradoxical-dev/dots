# Shell

This directory contains all configurations of the shell/terminal environments. This includes shell configurations (i.e. zsh, bash, etc.) different CLI packages, shell prompts and more.

# Zsh

My base zsh config comes with some QoL features and ergonomic aliases.

## Aliases

- **`c`**: clear
- **`ff`**: fastfetch
- **`ls`**: eza -a --icons
- **`ll`**: eza -al --icons
- **`lt`**: eza -a --tree --level=1 --icons
- **`shutdown`**: systemctl poweroff
- **`v`**: nvim
- **`wifi`**: nmtui
- **`gs`**: git status
- **`ga`**: git add
- **`gc`**: git commit -m
- **`gp`**: git push
- **`gpl`**: git pull
- **`gst`**: git stash
- **`gsp`**: git stash; git pull
- **`gcheck`**: git checkout
- **`gcredential`**: git config credential.helper store
- **`gg`**: lazygit

## Prompt

My prompt is configured with starship and prebuilt configs can be found in the [starship directory](./starship/)

## Features

The shell features fzf lookup of command history (default binding is <C-r>) and fastfetch on startup for the *aesthetics*. I have also modified the fastfetch config using custom scripts to display a server like MOTD and make it overall more useful.
