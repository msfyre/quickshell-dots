pragma Singleton
import Quickshell
import Quickshell.Services.Mpris

Singleton {
    function getPlayerFromName(playerName: string): MprisPlayer {
        const lowercasePlayerName = playerName.toLowerCase();

        for (const player of Mpris.players.values) {
            const identityLowercase = player.identity.toLowerCase().trim();

            if (player.identity.toLowerCase().includes(playerName.toLowerCase)) {
                return player;
            }
        }

        return Mpris.players.values[0];
    }
}
