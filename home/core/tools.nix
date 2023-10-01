{pkgs, ...}: {
  home.packages = with pkgs; [
    ranger # terminal file manager

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
