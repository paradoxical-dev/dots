# dots

# Overview

My collection of configurations to create a modular, cross-platform system capable of supporting a wide range of use-cases.

This configuration comes with support for popular video drivers, common development tools, easy switching between system themes, preconfigured neovim editor with integrated theme support, system security packages and much more. My use case is primarily focused on development and study work, however the config aims to be easily customizeable to fit any need.

> [!IMPORTANT]
> I'm thinking of a change to Gentoo linux. I'm getting a little tired of finicking with multiple package versions, language versions, etc. and how isolated you become from the machien
> That being said I'll continue to update this repo as I read up and experiment with Gentoo on my older machine.
> Gentoo seems enticing with complete control over the system and package managment, and could be a great learning experience as I look to automate some of my most valued nix features into a traditionallinux distro.

## Configurations

<details>
<summary>Primary DE</summary>

- Wayland

- **WM**: Hyprland

- **Bar**: Hyprpanel

- **Session Manager**: SDDM w/ Sugar Candy Theme

- **Terminal**: Kitty

- **Shell**: Zsh

- **Editor**: Neovim
</details>

<details>
<summary>Prepackaged Tools</summary>

- Obsidian

- Zathura

- MPD

- Cava

- HyprIdle/HyprLock

- Wofi

- Docker

- Alpaca

- Yazi
</details>

<details>
<summary>Inluded Security Packages</summary>

- Fail2Ban

- Unbound

- Firewall Daemon

- Sysctl
</details>

# Builtin Themes

This configuration comes with different pre packaged themes. Each theme has corresponding config files for customizeable applications, such as Kitty, Hyprpanel, etc.

This makes it so that updating home-manager with a different set theme, will update the config files to match the new theme.

## Themes

<details>
<summary>Yin</summary>

![Home](https://i.imgur.com/PUmXPjc.png)

![Neovim](https://i.imgur.com/qKOq2yO.png)

![Obsidian/zathura](https://i.imgur.com/peLx7e2.png)

</details>

<details>
<summary>Yang</summary>

![Home](https://i.imgur.com/UennvDJ.png)

![Neovim](https://i.imgur.com/H7TOMbB.png)

![Obsidian/zathura](https://i.imgur.com/51cfRHV.png)

</details>

<details>
<summary>Burst</summary>

![Home](https://i.imgur.com/BwRwpYV.png)

![Neovim](https://i.imgur.com/TNgCoEj.png)

![Obsidian/zathura](https://i.imgur.com/tG6IhZx.png)

</details>
