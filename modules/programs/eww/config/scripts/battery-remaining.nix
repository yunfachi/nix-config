{
  module-functions,
  pkgs,
  ...
}:
module-functions.module "programs" "eww" {
  yunfachi.programs.eww.config."scripts/battery-remaining.sh" = ''
    ${pkgs.acpi}/bin/acpi --battery | awk -F ', ' '{print $3}'
  '';
}
