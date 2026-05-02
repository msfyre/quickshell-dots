import Quickshell
import Quickshell.Io
pragma Singleton

Singleton {
	id: root

	property string quote: `"Tabula rasa"\n- John Locke`

	Process {
		id: fortuneProcess
		command: ["fortune", "/usr/share/fortune/literature", "-s"]
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
