import Quickshell
import qs.widgets.desktop

PanelWindow {
	implicitWidth: screen.width
	implicitHeight: screen.height

	aboveWindows: false

	color: "transparent"

	Clock {
		anchors {
			bottom: parent.bottom
			right: parent.right
		}

		implicitHeight: 50
	}
}
