import { App, Astal, Gtk, Gdk } from "astal/gtk3"

import Date from "./buttons/Date"
import SimplePlayer from "./buttons/SimplePlayer"
import Workspaces from "./buttons/Workspaces"

export type BarWidget = keyof typeof widget

const { TOP, BOTTOM, LEFT, RIGHT } = Astal.WindowAnchor

const widget = {
    date: Date,
    workspaces: Workspaces,
    expander: () => <box expand={true} />,
}

export default (gdkmonitor: Gdk.Monitor, monitor) => <window
    gdkmonitor={gdkmonitor}
    className="bar"
    name={"bar" + monitor}
    anchor={TOP | LEFT | RIGHT}
    exclusivity={Astal.Exclusivity.EXCLUSIVE}>
    <centerbox
        startWidget=<box hexpand={true}>
            {widget.workspaces(monitor)}
        </box>
        centerWidget=<box hpack="center">
            {widget.date()}
        </box>
        endWidget=<box hexpand={true}>
        </box>
    />
</window>
