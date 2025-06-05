import { Astal, Gdk } from "astal/gtk3"
import Clock from "./components/Clock";
import Player from "./components/Player";
import Workspaces from "./components/Workspaces";

export default function Bar(gdkmonitor: Gdk.monitor) {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

  return <window
    className="bar"
    gdkmonitor={gdkmonitor}
    exclusivity={Astal.Exclusivity.EXCLUSIVE}
    anchor={TOP | LEFT | RIGHT}
  >
    <box className="bar-container">
      <centerbox
        hexpand
        spacing={6}
        startWidget={
          <box hexpand>
            <Workspaces gdkmonitor={gdkmonitor} />
          </box>
        }
        centerWidget={
          <box halign="center">
            <Clock />
          </box>
        }
        endWidget={
          <box>
            <box hexpand>
              <Player />
            </box>
            <box halign="end">
              <label label="asdasd" />
            </box>
          </box>
        }
      />
    </box >
  </window >
}
