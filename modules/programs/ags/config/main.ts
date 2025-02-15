import Bar from "widget/bar/Bar"
import ScreenCorners from "widget/bar/ScreenCorners";
import { forMonitors } from "lib/utils"

App.config({
    windows: () => [
        ...forMonitors(Bar),
        ...forMonitors(ScreenCorners),
    ],
})

App.applyCss(`${App.configDir}/main.css`);
