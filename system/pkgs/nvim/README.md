# Neovim

I don't think I'll ever convert my Neovim configs to Nix. This seems like a huge undertaking for something as simple as copying the preferred config over to `~.config/nvim`.

I have two different configuration for Neovim:

- **custom_nvim**
  
  This is my configuration I built from scratch, based on ThePrimeagen's config. I never use it anymore but I couldn't brign myself to remove it, so here it stays.

- ~~astro_nvim~~ (will be removed soon)

  This is my custom config based on astro nvim. It is my daily driver for development work and includes some great plugins to create a cohesive IDE environment.

  - **main_nvim**

  I created this setup to ditch Astro. After a while astro began to feel like *the Windows of Neovim*. It was bloated and hard to deeply configure the internals without viewing source code.

  That being said I decided to try and create a new setup from scratch as an omage to my original setup.

  This setup is a full featured IDE with a focus on speed and performance. Both the editor itself and the movement/navigation plugins added are optimized for speed as much as possible.

  So much so that the faster startup times are around **13-14 ms**. I ditched a ton of non essential plugins while still retaining a beutiful UI and added some that I thought would enhance my efficency even more.

  I think this will be my endgame config, given some more tweaks here and there.
