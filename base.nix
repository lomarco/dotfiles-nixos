{
  pkgs,
  ...
}:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
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

    optimise = {
      automatic = true;
      dates = "weekly";
    };
  };

  networking = {
    hostName = "mefi";
    firewall.enable = true;
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

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
  };

  users.users = {
    loma = {
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = [
        "wheel"
        "storage"
        "video"
        "input"
        "audio"
        "power"
        "docker"
        "networkmanager"
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

    ssh.startAgent = false;
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    ncdu
    sway
    wmenu
    i3status-rust
    foot
    git
    neovim
    stow
    gnumake
    rustup
    tmux
    llvm
    clang
    lld
    lldb
    zsh
    htop
    nixfmt
  ];

  fonts.packages = with pkgs; [ iosevka-bin ];

  system.stateVersion = "26.05";
}
