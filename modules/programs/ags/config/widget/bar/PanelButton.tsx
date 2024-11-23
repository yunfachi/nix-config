export default ({
    child,
    window = "",
    ...args
}) => <button
    setup={self => {
        let open = false
        
        self.toggleClassName("panel-button")
        self.toggleClassName("flat")
        self.toggleClassName(window)

        /*self.hook(App, (_, win, visible) => {
            if (win !== window)
                return

            if (open && !visible) {
                open = false
                self.toggleClassName("active", false)
            }

            if (visible) {
                open = true
                self.toggleClassName("active")
            }
        })*/
    }}
    {...args}
    >
    <box>{child}</box>
</button>

