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
            DOTFILES_DIR="$PWD/dotfiles"
            CONFIG_DIR="$HOME/.config"
            BACKUP_DIR="$(mktemp -d /tmp/dotconfig-backup-XXXX)"

            echo "Setting up temporary dotfile links from $DOTFILES_DIR"
            echo "Backups stored in: $BACKUP_DIR"

            mkdir -p "$CONFIG_DIR"

            # Backup + replace each item
            for src in "$DOTFILES_DIR"/*; do
              name="$(basename "$src")"
              target="$CONFIG_DIR/$name"

              if [ -e "$target" ]; then
                mv "$target" "$BACKUP_DIR/$name"
                echo "Backed up $target -> $BACKUP_DIR/$name"
              fi

              ln -s "$src" "$target"
              echo "Linked $target -> $src"
            done

            # Define cleanup on exit
            cleanup() {
              echo "Restoring original configs..."
              for src in "$DOTFILES_DIR"/*; do
                name="$(basename "$src")"
                target="$CONFIG_DIR/$name"
                backup="$BACKUP_DIR/$name"

                # Remove symlink
                [ -L "$target" ] && rm "$target"

                # Restore backup if it exists
                if [ -e "$backup" ]; then
                  mv "$backup" "$target"
                  echo "Restored $target"
                fi
              done

              rmdir "$BACKUP_DIR" 2>/dev/null || true
              echo "Configs restored."
            }

            trap cleanup EXIT

            echo "Dotfiles active (will revert when you exit this shell)"
          '';
        };
      }
    );
}
