pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
	readonly property var colorScheme: colorAdapter

	FileView {
		path: Quickshell.shellDir + "/color.json"
		adapter: colorAdapter

		watchChanges: true

		onFileChanged: reload()
	}

	JsonAdapter {
		id: colorAdapter

		property string foreground
		property string background
		property var base16
	}
}
