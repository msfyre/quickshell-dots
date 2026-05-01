pragma Singleton

import QtQuick
import Quickshell

Singleton {
	readonly property string formattedTime: Qt.formatDateTime(sysclock.date, "hh:mm:ss A")
	readonly property string formattedDate: Qt.formatDateTime(sysclock.date, "MMMM dd, yyyy")

	SystemClock {
		id: sysclock
	}
}
