import PanelButton from "../PanelButton"
import { sh, range } from "lib/utils"

const hyprland = await Service.import('hyprland')

const dispatch = (arg: string | number) => sh(`hyprctl dispatch workspace ${arg}`)

const Workspaces = (monitor: number, ws: number) => Widget.Box({
    children: range(ws).map(i => Widget.Label({
        attribute: i,
        vpack: "center",
        label: `${i+10*monitor}`,
        setup: self => self.hook(hyprland, () => {
            self.toggleClassName("active", hyprland.active.workspace.id === i+10*monitor)
            self.toggleClassName("occupied", (hyprland.getWorkspace(i+10*monitor)?.windows || 0) > 0)
        }),
    })),
})

export default (monitor: number) => PanelButton({
    class_name: "workspaces",
    on_scroll_up: () => dispatch("m-1"),
    on_scroll_down: () => dispatch("m+1"),
    child: Workspaces(monitor, 10),
})
