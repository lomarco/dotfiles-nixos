{
  pkgs,
  waterfox,
  ...
}:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot = {
        enable = true;
        editor = false;
      };
      efi.canTouchEfiVariables = true;
    };
  };

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
      max-jobs = "auto";
      cores = 0;
    };

    optimise.automatic = true;
  };

  networking = {
    hostName = "mefi";
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];
  };

  time.timeZone = "Etc/GMT-7";

  services = {
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
    };

    i2pd = {
      enable = true;
      settings = {
        http.enabled = true;
        httpproxy.enabled = true;
      };
    };
  };

  users.users = {
    loma = {
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = [
        "wheel"
        "docker"
      ];
      initialPassword = "dildo";
    };
    root = {
      shell = pkgs.zsh;
      initialPassword = "dildo";
    };
  };

  hardware.graphics.enable = true;

  programs = {
    sway.enable = true;
    zsh.enable = true;
    nh = {
      enable = true;
      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "--keep-since 4d --keep 3";
      };
    };
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = pkgs.pinentry-tty;
    };
  };

  environment.systemPackages = with pkgs; [
    waterfox.packages.${pkgs.stdenv.hostPlatform.system}.waterfox-bin

    neovim
    git
    tmux
    foot
    wmenu
    i3status-rust
    ncdu
    htop
    stow
    nixfmt
  ];

  fonts.packages = with pkgs; [ iosevka-bin ];

  system.stateVersion = "26.05";
}
