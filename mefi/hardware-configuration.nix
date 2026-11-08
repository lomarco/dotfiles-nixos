{
  lib,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "nvme"
        "usb_storage"
        "sd_mod"
        "usbhid"
      ];
      kernelModules = [
        "amdgpu"
      ];
    };

    kernelModules = [
      "kvm-amd"
    ];
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  cpu.amd.updateMicrocode = true;
}
