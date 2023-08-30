# ejiek's NixOS setup

This is my attempt to live with NixOS as a daily driver.
Be cautious that I'm still trying to figure Nix out and fit in.
There might be serious idiomatic & structural flaws.

| Machine       | System        | Status |
| --            | --            | --     |
| Desktop       | NixOS         | Done   |
| Laptop        | NixOs         | WIP    |
| SteamDeck     | SteamOS + Nix | WIP    |
| PinePhone Pro | NixOS         | TBD    |

## Roadmap

- [ ] Make repo usable by multiple machines (see [Wimpy's repo](https://github.com/wimpysworld/nix-config))
- [ ] Adopt encryption or a way to store secrets separately (see [agenix](https://github.com/ryantm/agenix))
- [ ] Document the way(s) this repo is used

## Updating

Using Flake means that `nixpkgs` are no longer controlled by `nix-channel` of NixOS.
Instead, `nixpkgs` are locked to flake input.
To update the system one needs to update the input:

```bash
nix flake lock --update-input nixpkgs
```

Next step is testing new version of the system. I have it aliased to `ntest`:

```bash
sudo nixos-rebuild test --flake /home/ejiek/.slashNix/flake.nix#
```

The final step is to use new system/ switch to it. I have it aliased to `nwitch`:

```bash
sudo nixos-rebuild switch --flake /home/ejiek/.slashNix/flake.nix#
```

There are other inputs in this flake. To get a list:

```bash
nix flake metadata
```

Updating inputs one by one makes it easier to understand which one is responsible for a failure.
Nevertheless, for a lucky path it's easier to update them all at once:

```bash
nix flake update
```

You can even commit the change:

```bash
nix flake update --commit-lock-file
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
