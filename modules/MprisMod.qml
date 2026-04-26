pragma Singleton
pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import Quickshell.Services.Mpris

Singleton {
    id: root
    property MprisPlayer trackedPlayer: null
    property MprisPlayer activePlayer: trackedPlayer ?? Mpris.players.values[0] ?? null

    function getPlayerFromIdentity(playerIdentity: string): MprisPlayer {
        for (const player of Mpris.players.values) {
            console.log(player.identity);

            if (player.identity.toLowerCase() == playerIdentity.toLowerCase()) {
                return player;
            }
        }

        return activePlayer;
    }

    Instantiator {
        model: Mpris.players

        Connections {
            required property MprisPlayer modelData
            target: modelData

            Component.onCompleted: {
                if (root.trackedPlayer == null || modelData.isPlaying) {
                    root.trackedPlayer = modelData;
                }
            }

            Component.onDestruction: {
                if (root.trackedPlayer == null || !root.trackedPlayer.isPlaying) {
                    for (const player of Mpris.players.values) {
                        if (player.playbackState.isPlaying) {
                            root.trackedPlayer = player;
                            break;
                        }
                    }

                    if (root.trackedPlayer == null && Mpris.players.values.length != 0) {
                        root.trackedPlayer = Mpris.players.values[0];
                    }
                }
            }

            function onPlaybackStateChanged() {
                if (root.trackedPlayer !== modelData) {
                    root.trackedPlayer = modelData;
                }
            }
        }
    }
}
