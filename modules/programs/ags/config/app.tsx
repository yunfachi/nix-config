import { App } from "astal/gtk3"

import Bar from "./widget/bar/Bar"
import ScreenCorners from "./widget/bar/ScreenCorners";
import style from "./style/main.scss";

App.start({
    css: style,
    main() {
        App.get_monitors().map(Bar)
        App.get_monitors().map(ScreenCorners)
    },
})

