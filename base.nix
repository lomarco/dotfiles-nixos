{
  pkgs,
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
    };
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
    wireless.iwd.settings = {
      General = {
        AddressRandomization = "network";
        AddressRandomizationRange = "full";
      };
    };
  };

  time.timeZone = "Etc/GMT-7";

  hardware = {
    graphics.enable = true;
    enableRedistributableFirmware = true;
  };

  services = {
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
    };
    fstrim.enable = true;
  };

  users.users = {
    loma = {
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = [
        "wheel"
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

  programs = {
    sway = {
      enable = true;
      xwayland.enable = false;
    };
    zsh.enable = true;
    nh = {
      enable = true;
    };
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = pkgs.pinentry-tty;
    };
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  documentation.enable = false;
  security.polkit.enable = false;

  fonts.packages = with pkgs; [
    iosevka-bin
  ];

  environment.systemPackages = with pkgs; [
    vim
    neovim
    git
    gnumake
    fasm
    llvm
    clang
    i3status-rust
    wget
    wlsunset
    grim
    brightnessctl
    slurp
    foot
    tmux
    lldb
    translate-shell
    bluez
    (pass.withExtensions (exts: [ exts.pass-otp ]))
    ncdu
    rsync
    htop
    bc
    mpv
    swayimg
    swaybg
    lld
    wmenu
    less
    openssh
    wl-clipboard
    cmake
    nmap
    hyperfine
    rustup
    swayidle
    swaylock
    pavucontrol
    valgrind
    fzf
    traceroute
    xxd
    ripgrep
    zathura
    nasm
    yazi
    tcpdump
    stow
    ninja
    unzip
    bluetui
    tokei
    usbutils
    netcat
    lsof
    cliphist
    iw
    hyprpicker
    ffmpeg
    wf-recorder
    git-lfs
    wlvncc
    woomer
    libnotify
    fnott
    nixfmt
    firefox
  ];

  system.stateVersion = "26.05";
}
