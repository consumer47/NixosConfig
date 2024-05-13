{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
# <home-manager/nixos> 
# "${pkgs.home-manager}/nixos"
    ];
#home-manager.users.dennis = { pkgs, ... }: {
#    # stateVersion determines stable/unstable
#     home.stateVersion = "23.11";
#     home.packages = with pkgs; [
#     
#     ];
#};
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dennis = {
    isNormalUser = true;
    description = "Dennis Schwichtenhoevel";
    extraGroups = [ "networkmanager" "wheel" ]; # Allow user to administer the system
    # packages = with pkgs; [ ]; # User-specific packages
  };

  # Enable the X11 windowing system and configure it.
  services.xserver = {
    enable = true;
    layout = "de";
    xkbOptions = "caps:escape, odiaeresis:BackSpace";
    xkbVariant = "";
    displayManager = {
      gdm.enable = false;
      autoLogin = {
        enable = true;
        user = "dennis";
      };
    };
    
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu #application launcher most people use
        i3status # gives you the default i3 status bar
        i3lock #default i3 screen locker
     ];
    };
    desktopManager.gnome.enable = false;
  };
  services.xserver.libinput = {
  enable = true;
  touchpad.naturalScrolling = false; # Set to true to enable natural scrolling
};

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Configure keymap in console
  console.keyMap = "de";

  # Enable networking
  networking = {
    hostName = "nixos"; # Define your hostname.
    networkmanager.enable = true;
  };
networking.wireless.networks."Klabautermann".psk = "6a6f994335a6bc658695fb825418fa08ebc80680f28807bd48f742abcbc172b2";



  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "de_DE.UTF-8";
      LC_IDENTIFICATION = "de_DE.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
      LC_NAME = "de_DE.UTF-8";
      LC_NUMERIC = "de_DE.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_TELEPHONE = "de_DE.UTF-8";
      LC_TIME = "de_DE.UTF-8";
    };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true; # Uncomment if you want to use JACK applications
  };

  # Define default user shell and available shells
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];
# enable zsh and oh my zsh
programs = {
   zsh = {
      enable = true;
      autosuggestions.enable = true;
      zsh-autoenv.enable = true;
      syntaxHighlighting.enable = true;
      ohMyZsh = {
         enable = true;
         theme = "robbyrussell";
         plugins = [
           "git"
           "npm"
           "history"
           "node"
           "rust"
           "deno"
         ];
      };
   };
};
  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
(vscode-with-extensions.override {
    vscodeExtensions = with vscode-extensions; [
#     ms-vscode.cpptools
      
# 076923.python-image-preview
# andenetalexander.vim-cheatsheet
# batisteo.vscode-django
# benjamin-simmonds.pythoncpp-debug
# donjayamanne.python-environment-manager
# donjayamanne.python-extension-pack
# harryhopkinson.vim-theme
# kevinrose.vsc-python-indent
# mgesbert.python-path
# ms-python.debugpy
ms-python.python
# ms-python.vscode-pylance
ms-vscode.cpptools
# njpwerner.autodocstring
# vintharas.learn-vim
# visualstudioexptteam.intellicode-api-usage-examples
# visualstudioexptteam.vscodeintellicode
# vscodevim.vim
# wholroyd.jinja
# xadillax.viml
# xirider.livecode
      # ... other extensions ...
    ];
  })
  rofi
  pulseaudio
    # System utilities and tools
    networkmanagerapplet
    blueman
arandr
ranger
htop

    pavucontrol 
    spotify
    xterm

    gnome3.gnome-terminal
    xclip
    vim
    neovim
    git
    tmux
    stdenv.cc # Common compilation tools
    gdb
    cmake
    python3
    python3Packages.pip
    nodejs
    go
    rustc
    cargo
    htop
    fzf
    ripgrep
    bat
    eza
    tldr
    tree
    wget
    curl
    rsync
    nmap
    traceroute
    whois
    ntfs3g
    dosfstools
    gparted
    hfsprogs
    gnupg
    openssh
    vlc
    gimp
    libreoffice
    evince
    inkscape
    unzip
    zip
    p7zip
    unrar
    zsh
    firefox
    chromium
    virtualbox
    docker
    qemu
    i3
    (vim_configurable.override {
      features = "huge"; # Vim compiled with clipboard support
    })
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


  # Set the system state version
  system.stateVersion = "23.11"; # Did you read the comment?

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable the firewall and open necessary ports.
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ /* Your TCP ports here */ ];
    allowedUDPPorts = [ /* Your UDP ports here */ ];
  };

  # Bootloader configuration.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # ... other configurations ...
}
