import { bind } from "astal"

import { clock } from "lib/variables"
import PanelButton from "../PanelButton"

export default () => <PanelButton>
    <label
      justification="center"
      label={clock(x => x.format("%H:%M - %a %d"))} />
</PanelButton>
