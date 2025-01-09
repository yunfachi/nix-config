{
  delib,
  decryptSecret,
  decryptHostSecret,
  lib,
  ...
}:
delib.host {
  name = "dekomori";

  nixos = {name, ...}: {
    networking = {
      defaultGateway = {
        address = decryptHostSecret name "hosts/dekomori/defaultGateway";
        interface = "ens3";
      };
      defaultGateway6 = {
        address = decryptHostSecret name "hosts/dekomori/defaultGateway6";
        interface = "ens3";
      };

      dhcpcd.enable = false;

      interfaces = {
        ens3 = {
          ipv4 = {
            addresses = [
              {
                address = decryptSecret "hosts/dekomori/ip";
                prefixLength = 32;
              }
            ];
            routes = [
              {
                address = decryptHostSecret name "hosts/dekomori/defaultGateway";
                prefixLength = 32;
              }
            ];
          };

          ipv6 = {
            addresses = [
              {
                address = decryptHostSecret name "hosts/dekomori/ipv6/address";
                prefixLength = lib.toInt (decryptHostSecret name "hosts/dekomori/ipv6/prefixLength");
              }
              {
                address = decryptHostSecret name "hosts/dekomori/ipv6LinkLocal";
                prefixLength = 64;
              }
            ];
            routes = [
              {
                address = decryptHostSecret name "hosts/dekomori/defaultGateway6";
                prefixLength = 128;
              }
            ];
          };
        };
      };
    };

    services.udev.extraRules = ''
      ATTR{address}=="${decryptHostSecret name "hosts/dekomori/mac"}", NAME="ens3"
    '';
  };
}
