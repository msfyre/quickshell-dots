pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property string quote: `"Tabula rasa"\n- John Locke`
    property string quoteDatabase: "literature"

    Process {
        id: fortuneProcess
        command: ["fortune", `/usr/share/fortune/${root.quoteDatabase}`, "-s"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                root.quote = this.text.trim();
            }
        }
    }

    function generateQuote() {
        fortuneProcess.running = true;
    }
}
