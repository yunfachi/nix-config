import { Gtk } from "astal/gtk3"
import { Variable, bind } from "astal"
import Hyprland from "gi://AstalHyprland"
import PanelButton from "widgets/common/PanelButton.tsx"
import { range } from "utils"

function WorkspaceButton({ workspace }) {
  const hyprland = Hyprland.get_default()

  const classNames = Variable.derive(
    [bind(hyprland, "focusedWorkspace"), bind(hyprland, "clients")],
    (focusedWorkspace, _) => {
      const classes = []

      if (focusedWorkspace.id === workspace.id)
        classes.push("active")

      if (hyprland.get_workspace(workspace.id)?.get_clients().length > 0)
        classes.push("occupied")

      return classes.join(" ")
    }
  )

  return (
    <box
      className={classNames()}
      onDestroy={() => classNames.drop()}
      valign={Gtk.Align.CENTER}
    />
  )
}

export default function Workspaces({ gdkmonitor, workspaces_number = 10 }) {
  const hyprland = Hyprland.get_default()
  const monitor = hyprland
    .get_monitors()
    .find(m => m.model === gdkmonitor.model)

  const start = monitor.id * 10
  const end = start + workspaces_number - 1

  return (
    <PanelButton
      onScroll={(_self, event, _user_data) => {
        const direction = event.delta_y > 0 ? "m+1" : "m-1"
        hyprland.dispatch("workspace", direction)
      }}
    >
      <box className="workspaces">
        {range(start, end).map(i => (
          <WorkspaceButton
            workspace={Hyprland.Workspace.dummy(i + 1, null)}
          />
        ))}
      </box>
    </PanelButton>
  )
}

