import { bind } from "astal"
import { Gdk } from "astal/gtk3"
import Hyprland from "gi://AstalHyprland"

import PanelButton from "../PanelButton"
import { sh, range } from "lib/utils"

const hyprland = Hyprland.get_default()

const dispatch = (arg: string | number) => sh(`hyprctl dispatch workspace ${arg}`)

const Workspaces = (monitor: number, ws: number) => <box>
    {bind(hyprland, "workspaces").as(workspaces => range(ws).map(i => <label
        attribute={i}
        vpack="center"
        label={`${i+10*monitor}`}
        className={bind(hyprland, "focusedWorkspace").as(fw => (i+10*monitor) == fw.id ? "active" : ((workspaces.filter(x => x.id == i+10*monitor)[0]?.get_clients().length > 0) ? "occupied" : "") )}/>
    ))}
</box>

export default (monitor: number) => <PanelButton
    className="workspaces"
    onScroll={(_, event) => dispatch(event.delta_y > 0 ? "m+1" : "m-1")}
    child={Workspaces(monitor, 10)} />
