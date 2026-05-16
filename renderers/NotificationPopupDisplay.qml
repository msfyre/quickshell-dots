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

        add: Transition {
            PropertyAnimation {
                property: "y"
                duration: root.animationDuration
                from: -20
                easing.type: Easing.OutBack
            }
            PropertyAnimation {
                property: "scale"
                from: 0
                to: 1
                duration: root.animationDuration
                easing.type: Easing.OutCubic
            }
        }

        move: Transition {
            PropertyAnimation {
                property: "y"
                duration: root.animationDuration
                easing.type: Easing.InOutCubic
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
