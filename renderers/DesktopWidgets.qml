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
			bottomMargin: 10
			right: parent.right
			rightMargin: 10
		}

		isFormat24H: true

		implicitHeight: 58
	}
}
