{
  description = "NixOS config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    vscode-server.url = "github:nix-community/nixos-vscode-server";
    polymc.url = "github:PolyMC/PolyMC";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, home-manager, zen-browser, nixpkgs, nixpkgs-stable, vscode-server, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {

    # Home Manager standalone activation
    homeConfigurations = {
      nix01 = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
          {
            home.username = "nix";
            home.homeDirectory = "/home/nix";
            home.stateVersion = "24.11"; # Update to match your setup
          }
        ];
      };
      genie = home-manager.lib.homeManagerConfiguration {
        #inherit pkgs;
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [
          ./home-manager/home.nix
        ];

      };
    };

    # NixOS system configurations
    nixosConfigurations = {
      asusnix = nixpkgs.lib.nixosSystem {
        specialArgs = {
          pkgs-stable = import nixpkgs-stable {
            inherit system;
            config.allowUnfree = true;
          };
          inherit inputs system;
          hostName = "asusnix";
          sshUser = "genie";
          openTCPPorts = [ 22 2377 7946 5900 ];
          openUDPPorts = [ 2377 7946 4789 ];
        };
        modules = [
          ./hosts/asus-nix/configuration.nix
          inputs.home-manager.nixosModules.default
          {
            home-manager.users.genie = import ./home-manager/home.nix;
            home-manager.backupFileExtension = "hm-bak";
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
          vscode-server.nixosModules.default
          ({ config, pkgs, ... }: {
            services.vscode-server.enable = true;
          })
        ];
      };
      genienix = nixpkgs.lib.nixosSystem {
        specialArgs = {
          pkgs-stable = import nixpkgs-stable {
            inherit system;
            config.allowUnfree = true;
          };
          inherit inputs system;
          hostName = "genienix";
          sshUser = "genie";
          openTCPPorts = [ 22 2377 7946 5900 ];
          openUDPPorts = [ 2377 7946 4789 ];
        };
        modules = [
          ./hosts/genie-nix/configuration.nix
          inputs.home-manager.nixosModules.default
          {
            home-manager.users.genie = import ./home-manager/home.nix;
            home-manager.backupFileExtension = "hm-bak";
          }
          vscode-server.nixosModules.default
          ({ config, pkgs, ... }: {
            services.vscode-server.enable = true;
          })
        ];
      };

      nix01 = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          hostName = "nix01";
          sshUser = "nix";
          nfsDisk = "/dev/sdb1";
          nfsMount = "/swarm";
          nfsExport = "/export/swarm";
          openTCPPorts = [ 22 2377 7946 2049 ];
          openUDPPorts = [ 2377 7946 4789 ];
        };
        modules = [
          ./hosts/nix-01/configuration.nix
          inputs.home-manager.nixosModules.default
          {
            home-manager.users.nix = import ./home.nix;
            home-manager.backupFileExtension = "hm-bak";
          }
          vscode-server.nixosModules.default
          ({ config, pkgs, ... }: {
            services.vscode-server.enable = true;
          })
        ];
      };

      nix02 = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          hostName = "nix02";
          sshUser = "nix";
          openTCPPorts = [ 22 2377 7946 ];
          openUDPPorts = [ 2377 7946 4789 ];
        };
        modules = [
          ./hosts/nix-02/configuration.nix
          inputs.home-manager.nixosModules.default
          {
            home-manager.users.nix = import ./home.nix;
            home-manager.backupFileExtension = "hm-bak";
          }
          vscode-server.nixosModules.default
          ({ config, pkgs, ... }: {
            services.vscode-server.enable = true;
          })
        ];
      };

      nix03 = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          hostName = "nix03";
          sshUser = "nix";
          openTCPPorts = [ 22 2377 7946 ];
          openUDPPorts = [ 2377 7946 4789 ];
          smb_path = "/media";
          smb_name = "media";
          smb_test = "d /media 0755 root root -";
        };
        modules = [
          ./hosts/nix-03/configuration.nix
          inputs.home-manager.nixosModules.default
          {
            home-manager.users.nix = import ./home.nix;
            home-manager.backupFileExtension = "hm-bak";
          }
          vscode-server.nixosModules.default
          ({ config, pkgs, ... }: {
            services.vscode-server.enable = true;
          })
        ];
      };

      nixtest = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
           hostName = "nixtest";
          # sshUser = "nix";
           openTCPPorts = [ 22 2377 7946 ];
           openUDPPorts = [ 2377 7946 4789 ];
        };
        modules = [
          ./hosts/nix-test/configuration.nix
          inputs.home-manager.nixosModules.default
          {
            home-manager.users.nix = import ./home.nix;
            home-manager.backupFileExtension = "hm-bak";
          }
          vscode-server.nixosModules.default
          ({ config, pkgs, ... }: {
            services.vscode-server.enable = true;
          })
        ];
      };
    };
  };
}
