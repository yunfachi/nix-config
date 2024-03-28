{
  option-functions,
  host,
  ...
}:
with option-functions;
  option "services" "openssh" {
    enable = enableOption "ssh daemon (sshd)" host.isServer;
  }
