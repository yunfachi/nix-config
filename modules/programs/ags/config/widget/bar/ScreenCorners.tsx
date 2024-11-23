import { Astal } from "astal/gtk3"

const { TOP, BOTTOM, LEFT, RIGHT } = Astal.WindowAnchor

export default (gdkmonitor: number) => <window
  gdkmonitor={gdkmonitor}
  name={"corner" + gdkmonitor}
  className="screen-corner"
  anchor={TOP | BOTTOM | LEFT | RIGHT}
  clickThrough={true}>
</window>
