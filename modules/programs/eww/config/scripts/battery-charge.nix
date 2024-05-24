{
  module-functions,
  pkgs,
  ...
}:
module-functions.module "programs" "eww" {
  yunfachi.programs.eww.config."scripts/battery-charge.sh" = ''
    ${pkgs.acpi}/bin/acpi --battery | grep -o -P '(?<=, ).*(?=%)'
  '';
}
