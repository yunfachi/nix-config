{
  module-functions,
  lib,
  config,
  ...
}:
module-functions.module "programs" "eww" {
  yunfachi.programs.eww.config."colorscheme.scss" = ''
    ${lib.concatLines (
      lib.mapAttrsToList (
        name: value: "\$${name}: #${value};"
      )
      config.yunfachi.rice.colorscheme
    )}
  '';
}
