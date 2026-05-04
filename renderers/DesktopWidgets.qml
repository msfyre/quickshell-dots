import Quickshell
import Quickshell.Wayland
import qs.widgets.desktop

PanelWindow {
	implicitWidth: screen.width
	implicitHeight: screen.height

	aboveWindows: false

	color: "transparent"

	WlrLayershell.namespace: "qs-desktop-widgets"
	WlrLayershell.layer: WlrLayer.Background

	Clock {
		anchors {
			bottom: parent.bottom
			bottomMargin: 10
			right: parent.right
			rightMargin: 10
		}

		isFormat24H: false

		elementScale: 1.8
	}

	Quote {
		anchors {
			bottom: parent.bottom
			bottomMargin: 10
			left: parent.left
			leftMargin: 10
		}
	}

	InternetConnection {
		anchors {
			top: parent.top
			topMargin: 10
			right: parent.right
			rightMargin: 10
		}
	}
}
