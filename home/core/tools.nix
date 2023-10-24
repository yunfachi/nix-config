{pkgs, ...}: {
  home.packages = with pkgs; [
    ranger # terminal file manager
    thefuck # the fuck
    wakatime # wakatime

    # archives
    zip
    unzip

    # network
    dnsutils
    tcpdump
    nmap

    # text processing
    gnugrep
    gnused
    gawk

    # misc
    wireguard-tools
    file
    which
    tree
    gnutar
    libnotify
    lsof
    dmidecode
    glow # markdown preview in terminal
  ];

  programs = {
  };

  services = {
    udiskie.enable = true;
  };
}
