import { clock } from "lib/variables"
import PanelButton from "../PanelButton"

export default () => PanelButton({
    // window: "datemenu",
    // on_clicked: () => App.toggleWindow("datemenu"),
    child: Widget.Label({
        justification: "center",
        label: clock.bind().as(x => x.format("%H:%M - %a %d")),
    }),
})