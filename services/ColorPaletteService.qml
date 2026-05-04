pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
	id: root

	readonly property var colorScheme: colorAdapter

	property bool fileRead: false

	FileView {
		path: Quickshell.shellDir + "/color.json"

		adapter: colorAdapter

		watchChanges: true

		onLoaded: root.fileRead = true

		onFileChanged: {
			root.fileRead = false
			reload()
		}
	}

	JsonAdapter {
		id: colorAdapter

		property string foreground
		property string background
		property var base16
	}
}
