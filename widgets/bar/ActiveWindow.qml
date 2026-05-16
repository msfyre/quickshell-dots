import QtQuick
import Quickshell.Wayland
import qs.generics
import qs.services

Item {
    id: root

    width: displayText.implicitWidth + (fontSize * 2)
    height: parent.height

    readonly property real fontSize: parent.height / 2

    Text {
        id: displayText
        anchors.centerIn: parent
        text: String.truncateStringLeft(ToplevelManager.activeToplevel ? `|| ${ToplevelManager.activeToplevel.appId}: ${ToplevelManager.activeToplevel.title}` : "Not focused.", 40)
        color: ToplevelManager.activeToplevel ? ColorPaletteService.colors.color7 ?? "white" : ColorPaletteService.colors.color3

        font.family: GTK3Service.getFontName()
        font.pixelSize: root.fontSize

        Behavior on color {
            PropertyAnimation {
                duration: 200
            }
        }
    }
}
