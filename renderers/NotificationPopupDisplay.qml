import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.services
import qs.widgets.notification

pragma ComponentBehavior: Bound

PanelWindow {
	implicitWidth: screen.width
	implicitHeight: screen.height

	color: "transparent"

	mask: Region {
	}

	readonly property int animationDuration: 500

	WlrLayershell.namespace: "qs-notification-popups"
	WlrLayershell.layer: WlrLayer.Overlay

	Column {
		id: notifications

		anchors {
			horizontalCenter: parent.horizontalCenter
			top: parent.top
			topMargin: 10
		}

		add: Transition {
			PropertyAnimation {
				property: "y"
				duration: notifPopup.animationDuration 
				from: -20
				easing.type: Easing.OutCubic
			}
			PropertyAnimation {
				properties: "opacity, scale"
				from: 0
				to: 1
				duration: notifPopup.animationDuration * 2
				easing.type: Easing.OutCubic
			}
		}

		move: Transition {
			PropertyAnimation {
				property: "y"
				duration: notifPopup.animationDuration * 2
				easing.type: Easing.InOutBack
			}
		}

		spacing: 5

		Repeater {
			model: NotificationService.tracked

			NotificationPopup {
				id: notifPopup
				anchors.horizontalCenter: parent.horizontalCenter
			}
		}
	}
}
