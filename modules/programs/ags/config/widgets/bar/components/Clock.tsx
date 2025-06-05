import { time } from "utils";
import PanelButton from "widgets/common/PanelButton.tsx";

export default function Clock({ format = "%H:%M / %a %d" }) {
  return <PanelButton>
    <label
      className="clock"
      label={time((value) => value.format(format))}
    />
  </PanelButton>
}

