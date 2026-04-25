import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Mpris
import "../modules" as Modules

Item {
    id: root

    property MprisPlayer player: Modules.MprisMod.getPlayerFromName("")

    property color bgColor: "black"
    property color textColor: "white"
    property string textFont: "sans"
    property real displayHeight

    implicitWidth: displayText.implicitWidth + ((displayHeight ?? displayText.implicitHeight) * 2)
    implicitHeight: displayText.implicitHeight + ((displayHeight ?? displayText.implicitHeight) * 1.75)

    Rectangle {
        anchors.fill: parent
        color: root.bgColor
        border.color: root.textColor
        border.width: 2
        opacity: 0.4
        radius: 5
    }

    Text {
        id: displayText
        anchors.centerIn: parent
        text: (root.player == null || !root.player.isPlaying) ? "Not playing anything!" : `[${root.player.identity}]  \uec1b  ${root.player.trackArtist} - ${root.player.trackTitle}`
        color: root.textColor
        font.family: root.textFont
        font.pixelSize: root.displayHeight
    }
}
