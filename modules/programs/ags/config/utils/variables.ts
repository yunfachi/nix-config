import { GLib, Variable } from "astal";

export const time = Variable(GLib.DateTime.new_now_local()).poll(
  1000,
  () => GLib.DateTime.new_now_local(),
);
