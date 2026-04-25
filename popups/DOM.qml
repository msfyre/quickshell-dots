import QtQuick
import Quickshell
import Quickshell.Wayland
import ".."

PanelWindow {
    id: root

    implicitWidth: screen.width
    implicitHeight: screen.height
    WlrLayershell.namespace: "qs-popups"
    WlrLayershell.layer: WlrLayer.Overlay

    color: "transparent"
    mask: Region {
        item: container
    }

    Item {
        id: container

        anchors {
            bottom: parent.bottom
            bottomMargin: Screen.height * 0.3
            horizontalCenter: parent.horizontalCenter
        }

        Column {
            id: containerModel

            anchors.horizontalCenter: parent.horizontalCenter

            spacing: 6

            MusicChangePopup {
                textFont: GTK3.fontName
                textColor: Colors.adapter.base16[7]
                displayHeight: GTK3.fontSize * 1.2
                visibilityTimeSecs: 10
            }

            VolumePopup {
                textFont: GTK3.fontName
                textColor: Colors.adapter.base16[7]
                barBGColor: Colors.adapter.base16[0]
                displayHeight: GTK3.fontSize * 1.2
                visibilityTimeSecs: 1
            }
        }

        ListView {
            anchors.horizontalCenter: parent.horizontalCenter

            spacing: 4
        }
    }
}
