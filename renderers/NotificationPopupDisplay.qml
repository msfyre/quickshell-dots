pragma ComponentBehavior: Bound

import QtQuick

import Quickshell
import Quickshell.Wayland

import qs.services
import qs.widgets.popups

PanelWindow {
    id: root

    implicitWidth: screen.width
    implicitHeight: screen.height

    color: "transparent"

    mask: Region {
        item: notifications
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

        move: Transition {
            PropertyAnimation {
                property: "y"
                duration: root.animationDuration
                easing.type: Easing.OutBack
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
