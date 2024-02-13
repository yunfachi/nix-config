{
  module-functions,
  config,
  ...
}:
module-functions.module "programs" "eww" {
  yunfachi.programs.eww.config."top_bar/default.yuck" = let
    extraSpace = 5;
  in ''
    (include "top_bar/widgets/player.yuck")
    (include "top_bar/widgets/time.yuck")
    (include "top_bar/widgets/workspaces.yuck")

    (defwindow window_top_bar
      :monitor 0
      :geometry (geometry
                  :x "0px"
                  :y "${toString (config.yunfachi.rice.gaps.outer - extraSpace)}px"
                  :width "100%"
                  :height "${toString (config.yunfachi.rice.bar_height + extraSpace * 2)}px"
                  :anchor "top center")
      :stacking "fg"
      :focusable false
      (widget_top_bar)
    )

    (defwidget widget_top_bar []
        (box
            :class "top_bar_root"
            :orientation "h"
            (box
              :class "top_bar_left"
              (widget_workspaces)
            )
            (box
              :class "top_bar_center"
              (widget_time)
            )
            (box
              :class "top_bar_right"
              (widget_player)
            )
        )
    )
  '';
}
