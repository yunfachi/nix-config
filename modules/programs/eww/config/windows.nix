{module-functions, ...}:
module-functions.module "programs" "eww" (cfg: {
  yunfachi.programs.eww.config."windows.yuck" = ''
    (defwindow window_top_bar
      :monitor 0
      :geometry (geometry
                  :x "${toString cfg.bar.x}px"
                  :y "${toString cfg.bar.x}px"
                  :width "${toString cfg.bar.width}px"
                  :height "${toString cfg.bar.height}px"
                  :anchor "top center")
      :stacking "bg"
      :focusable false
    "WIP")
  '';
})
