#kh
{
  description = "Declarative package setup";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  outputs = { nixpkgs, ... }:
    let
      forSystem = system: 
        let 
          pkgs = import nixpkgs { inherit system; };
          kube-tools = import ./kube-tools/default.nix pkgs;
          common = import ./common/default.nix pkgs;
        in {
          kube-tools = pkgs.symlinkJoin {
            name = "kube-tools";
            paths = kube-tools;
          };
          common = pkgs.symlinkJoin {
            name = "common-tools";
            paths = common;
          };
          default = pkgs.symlinkJoin {
            name = "all-tools";
            paths = kube-tools ++ common;
          };
        };
    in {
      packages.x86_64-linux = forSystem "x86_64-linux";
      packages.aarch64-linux = forSystem "aarch64-linux";
      packages.x86_64-darwin = forSystem "x86_64-darwin";
      packages.aarch64-darwin = forSystem "aarch64-darwin";
    };
}
