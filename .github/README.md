# ejiek's NixOS setup

This is my attempt to live with NixOS as a daily driver.
Be cautious that I'm still trying to figure Nix out and fit in.
There might be serious idiomatic & structure flaws.

## Updating

Using Flake means that `nixpkgs` are no longer controlled by `nix-channel`.
Instead, `nixpkgs` are locked to flake input.
To update the system one needs to update the input:

```bash
nix flake lock --update-input nixpkgs
```

Next step is testing new version of the system. I have it aliased to `ntest`:

```bash
sudo nixos-rebuild test --flake /home/ejiek/.slashNix/flake.nix#e220
```

The final step is to use new system/ switch to it. I have it aliased to `nwitch`:

```bash
sudo nixos-rebuild switch --flake /home/ejiek/.slashNix/flake.nix#e220
```

### Updating nix-env packages

Before deciding if a given package is going to stick with my system I prefer to use it without adding it to my config.
So I add in to the nix-env.
These packages are not updated with the rest of the system through flake lock mechanism.
Instead, they are using nix channel configured for the root user (`nixos-unstable`).

First one needs to update a channel, info about available package:

```bash
sudo nix-channel --update
```

Then update packages themselves:

```bash
nix-env -u '*'
```

___
[original repository](https://github.com/ejiek/slashnix)
