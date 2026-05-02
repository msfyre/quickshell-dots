pragma Singleton

// i imported QtCore so the read will be universal by StandardPaths
import QtCore
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
	id: root

	property var config: ({})

	// needed because the GTK3 parses both the font name AND the font size in the same entry
	function getFontName() {
		var value = root.config["gtk-font-name"]

		if (!value) return "monospace";

		var match = value.match(/^([^\d]+)/);
		return (match ? match[1] : value).trim();
	}

	function getFontSize() {
		var value = root.config["gtk-font-name"]

		if (!value) return 10;

		var match = value.match(/^([\d]+)/);
		return match ? parseInt(match[1]) : value;
	}

	FileView {
		id: configFileView

		path: StandardPaths.writableLocation(StandardPaths.ConfigLocation) + "/gtk-3.0/settings.ini"

		watchChanges: true

		onLoaded: {
			var lines = this.text().trim().split("\n");

			for (let i = 1; i < lines.length; i++) {
				const line = lines[i];
				const entry = line.split("=");

				root.config[entry[0].trim()] = entry[1].trim();
			}

			root.configChanged();
		}

		onFileChanged: reload()
	}
}
