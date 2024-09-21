import { type MprisPlayer } from "types/service/mpris"
import PanelButton from "../PanelButton"
import icons from "lib/icons"
import { icon } from "lib/utils"

const mpris = await Service.import('mpris')

const getPlayer = (preferredName = "spotify") =>
    mpris.getPlayer(preferredName) || mpris.players[0] || null


const Content = (player: MprisPlayer) => {
    const revealer = Widget.Revealer({
        click_through: true,
        visible: true,
        transition: "slide_right",
        setup: self => {
            let current = ""
            self.hook(player, () => {
                if (current === player.track_title)
                    return

                current = player.track_title
                self.reveal_child = true
                Utils.timeout(3000, () => {
                    !self.is_destroyed && (self.reveal_child = false)
                })
            })
        },
        child: Widget.Label({
            truncate: "end",
            max_width_chars: 55,
            label: Utils.merge([
                player.bind("track_title"),
                player.bind("track_artists"),
            ], () => `${player.track_title} - ${player.track_artists.join(", ")}`),
        }),
    })

    const playericon = Widget.Icon({
        icon: player.bind("entry").as(x => icon(`${x}-symbolic`, icons.fallback.audio))
    })

    return Widget.Box({
        attribute: { revealer },
        children: [playericon, revealer],
    })
}

export default () => {
    let player = getPlayer()

    const btn = PanelButton({
        class_name: "simpleplayer",
        child: Widget.Icon(icons.fallback.audio),
    })

    const update = () => {
        player = getPlayer()
        btn.visible = !!player

        if (!player)
            return

        const content = Content(player)
        const { revealer } = content.attribute
        btn.child = content
        btn.on_primary_click = () => { player.playPause() }
        btn.on_secondary_click = () => { player.playPause() }
        btn.on_scroll_up = () => { player.next() }
        btn.on_scroll_down = () => { player.previous() }
        btn.on_hover = () => { revealer.reveal_child = true }
        btn.on_hover_lost = () => { revealer.reveal_child = false }
    }

    return btn.hook(mpris, update, "notify::players")
}
