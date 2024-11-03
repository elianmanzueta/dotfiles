{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
  };

  outputs = inputs@{ self, home-manager, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [
            pkgs.neovim
            pkgs.ripgrep
            pkgs.fzf
            pkgs.lazygit
            pkgs.fish
        ];
      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";
      nixpkgs.config.allowUnfree = true;

      # Enable alternative shell support in nix-darwin.
      programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

    # Declare the user that will be running `nix-darwin`.
        users.users.elian= {
            name = "elian";
            home = "/Users/elian";
            shell = "pkgs.fish";
        };
      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
    homeconfig = {pkgs, ...}: {

            # this is internal compatibility configuration 
            # for home-manager, don't change this!
            home.stateVersion = "23.05";
            # Let home-manager install and manage itself.
            programs.home-manager.enable = true;

            home.packages =  [
          pkgs.unzip
          pkgs.curl
          pkgs.kitty
          pkgs.obsidian
              ];

            home.sessionVariables = {
                EDITOR = "nvim";

            };

        programs.git = {
            enable = true;
            userName = "Elian Manzueta";
            userEmail = "elianmanzueta@protonmail.com";
            ignores = [ ".DS_Store" ];
            extraConfig = {
                init.defaultBranch = "main";
                push.autoSetupRemote = true;
            };
        };
        programs.fish.shellAbbrs = {
          rebuild = "darwin-rebuild switch --flake /Users/elian/.config/nix";
          ls = "eza -lhaF --color=auto --icons=always";
        };


    };

  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Elians-MacBook-Pro
    darwinConfigurations."Elians-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      modules = [ 
          configuration
          home-manager.darwinModules.home-manager  {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.verbose = true;
                home-manager.users.elian = homeconfig;
          }
        ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."Elians-MacBook-Pro".pkgs;
  };
}
