{
  module-functions,
  config,
  ...
}:
module-functions.module "programs" "eww" {
  yunfachi.programs.eww.config."base.scss" = ''
    @import "colorscheme.scss";

    $gaps_outter: ${toString config.yunfachi.rice.gaps.outer}px;

    @mixin window {
        background-color: $base00;
        border-radius: ${toString config.yunfachi.rice.rounding}px;
        border: ${toString config.yunfachi.rice.border_size}px solid $base04;
        box-shadow: 0 0 3px -0.5px #000000; //TODO: add this to rice
    }
  '';
}
