{
  module-functions,
  config,
  ...
}:
module-functions.module "programs" "eww" {
  yunfachi.programs.eww.config."top_bar/default.yuck" = let
    extraSpace = 5;
  in ''
    (include "top_bar/widgets/battery.yuck")
    (include "top_bar/widgets/clicker.yuck")
    (include "top_bar/widgets/player.yuck")
    (include "top_bar/widgets/time.yuck")
    (include "top_bar/widgets/volume.yuck")
    (include "top_bar/widgets/workspaces.yuck")

    ${builtins.concatStringsSep "\n" (builtins.genList (monitor_id: ''
      (defwindow window_top_bar_${toString monitor_id}
          :monitor ${toString monitor_id}
          :geometry (geometry
                      :x "0px"
                      :y "${toString (config.yunfachi.rice.gaps.outer - extraSpace)}px"
                      :width "100%"
                      :height "${toString (config.yunfachi.rice.bar_height + extraSpace * 2)}px"
                      :anchor "top center")
          :stacking "fg"
          :focusable false
          (widget_top_bar :monitor_id ${toString monitor_id})
      )'') (builtins.length config.yunfachi.hardware.displays))}

    (defwidget widget_top_bar [monitor_id]
        (box
            :class "top_bar_root"
            :orientation "h"
            (box
              :class "top_bar_left"
              (widget_workspaces :monitor_id monitor_id)
            )
            (box
              :class "top_bar_center"
              :halign "center"
              :space-evenly false
              :spacing 10
              (widget_time)
              (widget_clicker)
            )
            (box
              :class "top_bar_right"
              :space-evenly false
              :spacing 10
              :halign "end"
              (widget_player)
              (widget_volume)
              (widget_battery)
            )
        )
    )
  '';
}
