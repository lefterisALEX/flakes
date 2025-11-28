# Default recipe - list available commands
default:
    @just --list

install-common:
    NIXPKGS_ALLOW_UNFREE=1 nix profile add .#common

install-kube-tools:
    nix profile add .#kube-tools

install-all: install-common install-kube-tools
