{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.sessionVariables = {
    CACHED_CONFIG = pkgs.stdenv.mkDerivation {
      name = "system-config";
      src = /etc/nixos;
      installPhase = ''
        mkdir -p $out
        cp -rT . $out
      '';
    };
  };
  system.stateVersion = "24.05";
  nix.settings.experimental-features = ["nix-command" "flakes"];
  imports = [
    ./hardware-configuration.nix
  ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "copyconfig";
  networking.networkmanager.enable = true;
  services.sshd.enable = true;
  time.timeZone = "America/Los_Angeles";
  users.users.nixos = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    initialPassword = "password";
  };
}
