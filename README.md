## setup
```
curl -fsSL https://install.determinate.systems/nix | sh -s -- install --determinate
nix-shell -p just
just 
```
## commands

```
#  Install commom packages only
nix profile add .#common

# List all packages
nix profile list

# Add a new package in common.nix? Then update:
nix profile upgrade common

# update nixpkgs to latest
nix flake update

# list all packages
nix path-info -r --all 
```
