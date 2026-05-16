import Quickshell
import Quickshell.Wayland

import qs.widgets.popups

PanelWindow {
    id: root

    implicitWidth: screen.width
    implicitHeight: screen.height

    WlrLayershell.namespace: "qs-volume-osd"
    WlrLayershell.layer: WlrLayer.Overlay

    color: "transparent"

    mask: Region {}

    VolumeOSD {
        id: volumeOSD

        anchors {
            horizontalCenter: parent.horizontalCenter

            bottom: parent.bottom
            bottomMargin: root.screen.height / 4
        }
    }
}
