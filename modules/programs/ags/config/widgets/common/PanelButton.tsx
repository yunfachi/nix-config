import { App, hook, Gtk } from "astal/gtk3";

export default function PanelButton({
  child,
  window,
  className = "",
  ...args
}) {
  return (
    <button
      className={`panel-button flat ${className}`}
      setup={(self) => {
        if (!window) return

        let open = false;

        self.add_css_class(window);

        hook(self, App, "window-toogled", (_, win) => {
          const winName = win.name;
          const visible = win.visible;

          if (winName !== window) return

          if (open && !visible) {
            open = false
            self.remove_css_class("active")
          }

          if (visible) {
            open = true
            self.add_css_class("active")
          }
        })
      }}
      {...args}
    >
      {child}
    </button>
  )
}
