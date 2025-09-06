{
  description = "Poetry2Nix Setup for Nix Devlopment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    poetry2nix.url = "github:nix-community/poetry2nix";
  };

  outputs = { self, nixpkgs, poetry2nix }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      packages.${system}.default =
        poetry2nix.mkPoetryApplication {
          projectDir = ./.;  # expects pyproject.toml + poetry.lock here
          python = pkgs.python311; # or python312 depending on your project
        };

      devShells.${system}.default =
        pkgs.mkShell {
          inputsFrom = [ self.packages.${system}.default ];
          packages = with pkgs; [
            poetry  # optional: if you still want to use Poetry CLI
          ];
        };
    };
}
