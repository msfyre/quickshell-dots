pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property string currentUsername: "Fetching username..."

    Process {
        id: usernameFetcher

        command: ["whoami"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                root.currentUsername = this.text.trim();
            }
        }
    }
}
