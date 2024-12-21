# Drivers

Graphic drivers will be stored in this directory.

This is meant to be dynamically loaded into the `configuration.nix` by using the value of the `gpu_type` attribute from the `flake.nix`.

## Card Support

As of right now only hybrid graphics are supported. This file supports both Intel and AMD iGPUs with NVIDIA dGPUs (the most common hybrid setup) and is dynamic based on the `hybrid.iGpuType` attribute value.
