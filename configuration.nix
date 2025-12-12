{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];
  
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking = {
    hostName = "mefi";
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
      dns = "none";
    };
    nameservers = [ "1.1.1.1" "1.0.0.1" "8.8.8.8" ];
    proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  time.timeZone = "Asia/Novosibirsk";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    # font = "Lat2-Terminus16";
    useXkbConfig = true;
  };


  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  programs = {
    nix-ld.enable = true;
    zsh.enable = true;
    gnupg.agent.enable = true;
    firefox.enable = true;
  };

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
    libinput.enable = true;
  };

  hardware.graphics.enable = true;
  security.pam.services.swaylock = {};

  
  users = {
    users = {
      loma = {
        shell = pkgs.zsh;
        isNormalUser = true;
        extraGroups = [ "wheel" "input" "power" "video" "audio" "networkmanager"];
      };
      root.shell = pkgs.zsh;
    };
  };

  environment.systemPackages = with pkgs; [
    icu
    sudo
    vim
    neovim
    efibootmgr
    git
    sway
    gnumake
    wayland
    mesa
    fasm
    llvm
    clang
    i3status
    wget
    zsh
    iwd
    wlsunset
    grim
    slurp
    foot
    tmux
    lldb
    gdb
    wireguard-tools
    translate-shell
    bluez
    pipewire
    pass
    ncdu
    rsync
    htop
    bc
    man-pages
    man-db
    gnupg
    mpv
    swayimg
    swaybg
    lld
    wmenu
    less
    openssh
    wl-clipboard
    linux-firmware
    linux
    cmake
    meson
    cpio
    xz
    nmap
    vulkan-tools
    hyperfine
    rustup
    dosfstools
    qemu
    # "ttf-cascadia-code-nerd
    # "ttf-cascadia-code
    swayidle
    swaylock
    pavucontrol
    valgrind
    fzf
    xwayland
    traceroute
    apacheHttpd
    tldr
    strace
    radare2
    ctags
    ripgrep
    zathura
    nasm
    nftables
    yazi
    tcpdump
    avrdude
    mat2
    i2pd
    libvirt
    virt-manager
    tigervnc
    net-tools
    zk
    yarn
    glow
    stow
  ];

  system.stateVersion = "25.05";
}
