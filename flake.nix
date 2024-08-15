{
  description = "My luasnips";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = {flake-parts, ...} @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];
      perSystem = {pkgs, ...}: {
        packages.default = pkgs.stdenv.mkDerivation {
          name = "luasnips";
          src = ./.;
          installPhase = ''
            mkdir -p $out/share/snippets
            cp -r ./*.lua $out/share/snippets
          '';
        };

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            lua
            stylua
            lua-language-server
          ];
        };
      };
    };
}
