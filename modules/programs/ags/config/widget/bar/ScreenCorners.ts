export default (monitor: number) => Widget.Window({
    monitor,
    name: `corner${monitor}`,
    class_name: "screen-corner",
    anchor: ["top", "bottom", "right", "left"],
    click_through: true,
})
