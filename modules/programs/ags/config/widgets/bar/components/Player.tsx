import PanelButton from "widgets/common/PanelButton.tsx"
import AstalMpris from "gi://AstalMpris"
import { Variable, bind } from "astal"
import { Gtk } from "astal/gtk3"
import { VarMap, blurImage } from "utils"

const preferredPlayersNames = ["Feishin", "Spotify", "Mozilla firefox"]

function getPlayer(allPlayers: Map<string, CustomPlayer>) {
  const players = Array.from(allPlayers.values());

  if (players.length == 0) return undefined

  const playingPlayers = players
    .filter(p => p.playbackStatus === AstalMpris.PlaybackStatus.PLAYING)

  const playingPreferredPlayer = preferredPlayersNames
    .filter(name => playingPlayers.some(p => p.player.identity.toLowerCase() === name.toLowerCase()))
    .map(name => playingPlayers.find(p => p.player.identity.toLowerCase() === name.toLowerCase()))
    .find(p => p)

  const preferredPlayer = preferredPlayersNames
    .map(name => players.find(p => p.player.identity.toLowerCase() === name.toLowerCase()))
    .find(p => p) || players[0]

  const player =
    playingPreferredPlayer
    || playingPlayers[0]
    || preferredPlayer
    || players[0]

  return player;
}

class CustomPlayer {
  public player: AstalMpris.Player;

  public playbackStatus: AstalMpris.Player;
  public title: string;
  public artist: string;
  public coverArt: string;

  public constructor(player: AstalMpris.Player) {
    this.player = player
    this.playbackStatus = player.playback_status
    this.title = player.title;
    this.artist = player.artist;
    this.coverArt = player.cover_art;
  }
}

class PlayerService {
  private static _instance: PlayerService;
  private _mprisService = AstalMpris.Mpris;
  private _subscriptions: Map<string, Map<string, any>> = new Map();

  public allPlayers: VarMap<string, CustomPlayer> = new VarMap([]);
  public currentPlayer: Variable<string, any> = bind(this.allPlayers).as((allPlayers: Map<string, CustomPlayer>) => {
    return getPlayer(allPlayers)
  })

  private constructor() {
    this._mprisService = AstalMpris.get_default()

    for (const player of this._mprisService.get_players()) {
      this._handlePlayerAdded(player);
    }

    this._mprisService.connect("player-added", (_, addedPlayer: AstalMpris.Player) => this._handlePlayerAdded(addedPlayer));
    this._mprisService.connect("player-closed", (_, closedPlayer: AstalMpris.Player) => this._handlePlayerClosed(closedPlayer));
  }

  public static getInstance(): PlayerService {
    if (this._instance === undefined)
      this._instance = new PlayerService();

    return this._instance;
  }

  private _resetSubscription(busName: string, subscription?: string): void {
    if (subscription == undefined) {
      this._subscriptions.get(busName)?.forEach((_value, key) => this._resetSubscription(busName, key))
    } else {
      this._subscriptions.get(busName)?.get(subscription)?.drop();
      this._subscriptions.get(busName)?.delete(subscription);
    }
  }

  private _setSubscription(busName: string, subscription: string, value: any): void {
    let inner = this._subscriptions.get(busName);
    if (!inner) {
      inner = new Map()
      this._subscriptions.set(busName, inner)
    }
    inner.set(subscription, value)
  }

  private _handlePlayerAdded(addedPlayer: AstalMpris.Player): void {
    this.allPlayers.set(addedPlayer.busName, new CustomPlayer(addedPlayer));
    this._subscriptions.set(addedPlayer.busName, new Map());

    this._updateAll(addedPlayer);
  }

  private _handlePlayerClosed(closedPlayer: AstalMpris.Player): void {
    this._resetSubscription(closedPlayer.busName);
    this.allPlayers.delete(closedPlayer.busName);
  }

  private _updateAll(player: AstalMpris.Player): void {
    this._updatePlaybackStatus(player);
    this._updateTitle(player);
    this._updateArtist(player);
    this._updateCoverArt(player);
  }

  private _updatePlaybackStatus(player: AstalMpris.Player): void {
    this._resetSubscription(player.busName, "playbackStatus");

    const playbackStatusBinding = bind(player, "playbackStatus");

    this._setSubscription(player.busName, "playbackStatus", Variable.derive([playbackStatusBinding], (status) => {
      this.allPlayers.set(player.busName, { ...this.allPlayers.get(player.busName), playbackStatus: status ?? AstalMpris.PlaybackStatus.STOPPED });
    }));
  }

  private _updateTitle(player: AstalMpris.Player): void {
    this._resetSubscription(player.busName, "title");

    const titleBinding = bind(player, "title");

    this._setSubscription(player.busName, "title", Variable.derive([titleBinding], (status) => {
      this.allPlayers.set(player.busName, { ...this.allPlayers.get(player.busName), title: status ?? "" });
    }));
  }

  private _updateArtist(player: AstalMpris.Player): void {
    this._resetSubscription(player.busName, "artist");

    const artistBinding = bind(player, "artist");

    this._setSubscription(player.busName, "artist", Variable.derive([artistBinding], (status) => {
      this.allPlayers.set(player.busName, { ...this.allPlayers.get(player.busName), artist: status ?? "" });
    }));
  }

  private _updateCoverArt(player: AstalMpris.Player): void {
    this._resetSubscription(player.busName, "coverArt");

    const coverArtBinding = bind(player, "coverArt");

    this._setSubscription(player.busName, "coverArt", Variable.derive([coverArtBinding], (status) => {
      this.allPlayers.set(player.busName, { ...this.allPlayers.get(player.busName), coverArt: status });
    }));
  }
}

const playerService = PlayerService.getInstance();

export default function Player() {
  const BLUR_STRENGTH = 3;
  const DARK_ALPHA = 0.65;
  const blurredCover = Variable<string | undefined>(undefined);

  return playerService.currentPlayer.as(
    (player: CustomPlayer | undefined) => {
      const coverArt = player?.coverArt;
      const visible = player !== undefined;

      if (coverArt !== undefined) {
        blurImage(BLUR_STRENGTH, coverArt).then(out => {
          blurredCover.set(out)
        });
      } else {
        blurredCover.set(undefined);
      }

      return (
        <PanelButton className="player" visible={visible}>
          {coverArt !== undefined ? (
            <box>
              <box
                className="cover"
                valign={Gtk.Align.CENTER}
                css={`background-image: url("${coverArt}")`} // XSS ?
              />
              <box
                className="player-background"
                css={blurredCover(blurredCover => `background-image: linear-gradient(rgba(0,0,0,${DARK_ALPHA}), rgba(0,0,0,${DARK_ALPHA})), url("${blurredCover || coverArt}")`)} // XSS ?
              >
                <label label={`${player?.title ?? ""} - ${player?.artist ?? ""}`} />
              </box>
            </box>
          ) : (
            <label label={`${player?.title ?? ""} - ${player?.artist ?? ""}`} />
          )}
        </PanelButton>
      )
    })
}
