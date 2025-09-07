{
  description = "Nix dev shell for Django + Pydantic + PostgreSQL using Poetry";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      devShells.${system}.default = pkgs.mkShell {
        # System dependencies for building Python packages with C extensions or Rust
        buildInputs = [
          pkgs.python311
          pkgs.poetry
          pkgs.postgresql
          pkgs.rustc
          pkgs.cargo
          pkgs.zlib
          pkgs.libjpeg
          pkgs.openssl
        ];

        # Environment variables to ensure Poetry uses Nix Python
        shellHook = ''
          export POETRY_VIRTUALENVS_CREATE=false
          export PATH=${pkgs.python311}/bin:$PATH
          export PATH=${pkgs.postgresql}/bin:$PATH
          export PG_CONFIG=${pkgs.postgresql}/bin/pg_config
          poetry env use $(which python)
          echo "Dev shell ready: Python 3.11 + Poetry installed"
          echo "Run 'poetry install' to install dependencies from pyproject.toml"
          echo "Then 'poetry shell' to activate virtualenv"
        '';
      };
    };
}
