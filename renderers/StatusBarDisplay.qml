import QtQuick

import Quickshell
import Quickshell.Wayland

import qs.widgets.bar
import qs.services

PanelWindow {
    anchors {
        bottom: true
        left: true
        right: true
    }

    implicitHeight: 20

    WlrLayershell.layer: WlrLayer.Top
    WlrLayershell.namespace: "qs-status-bar"

    color: "transparent"

    Rectangle {
        anchors.fill: parent

        color: ColorPaletteService.colors.background ?? "black"
        opacity: 0.4
    }

    Row {
        anchors.fill: parent

        UserDisplay {}
        Clock {}
        ActiveWindow {}
    }
}
