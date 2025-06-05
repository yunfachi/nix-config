import { App } from "astal/gtk3"
import style from "style/index.scss";
import Bar from "widgets/bar";

App.start({
  css: style,
  instanceName: "yunfachi-shell",
  main: () => {
    App.get_monitors().map(Bar)
  },
})
