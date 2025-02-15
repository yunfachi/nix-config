import Date from "./buttons/Date"
import SimplePlayer from "./buttons/SimplePlayer"
import Workspaces from "./buttons/Workspaces"

export type BarWidget = keyof typeof widget

const widget = {
    date: Date,
    workspaces: Workspaces,
    simplePlayer: SimplePlayer,
    expander: () => Widget.Box({ expand: true }),
}

export default (monitor: number) => Widget.Window({
    monitor,
    class_name: "bar",
    name: `bar${monitor}`,
    anchor: ["top", "left", "right"],
    exclusivity: "exclusive",
    child: Widget.CenterBox({
        startWidget: Widget.Box({
            hexpand: true,
            children: [
                widget.workspaces(monitor),
            ]
        }),
        centerWidget: Widget.Box({
            hpack: "center",
            children: [
                widget.date(),
            ]
        }),
        endWidget: Widget.Box({
            hexpand: true,
            children: [
                widget.simplePlayer(),
            ]
        }),
    })
})
