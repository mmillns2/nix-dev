{
  description = "Development Environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        devPackages = with pkgs; [
          neovim
          tmux
          tmuxifier
          bat
          htop
          btop
          tree
          clang-tools
      	  screen
          libgcc
	        lz4
	        usbutils
          neofetch
          feh
        ];
      in {
        packages.default = pkgs.buildEnv {
          name = "dev-tools";
          paths = devPackages;  
        };

        devShells.default = pkgs.mkShell {
          packages = devPackages;

          shellHook = ''
            source ~/.bash_profile
            source ~/.bashrc
            mancx
          '';
        };
      }
    );
}
