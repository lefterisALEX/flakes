# Default recipe - list available commands
default:
    @just --list

install-common:
    nix profile add .#common

install-kube-tools:
    nix profile add .#kube-tools

install-all: install-common install-kube-tools
