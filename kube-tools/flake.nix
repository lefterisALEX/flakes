{
  description = "Declarative kube-tools setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        # Define your tools in one place
        tools = {
          kubectl = pkgs.kubectl;
          helm = pkgs.kubernetes-helm;
          # add more: kustomize = pkgs.kustomize; etc.
        };
      in
      {
        # Make tools available under `nix build .#kubectl`
        packages = tools;

        # Bundle into a single output (`nix build .`)
        defaultPackage = pkgs.symlinkJoin {
          name = "kube-tools";
          paths = builtins.attrValues tools;
        };

        # `nix develop` shell
        devShells.default = pkgs.mkShell {
          name = "kube-tools-shell";
          packages = builtins.attrValues tools;

          # optional niceties
          shellHook = ''
            echo "Kube tools ready: kubectl, helm"
          '';
        };
      }
    );
}

