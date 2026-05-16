import QtQuick
import qs.services

MouseArea {
    id: root

    readonly property real fontSizePixels: parent.height / 2
    readonly property int animationDurationMS: 200

    readonly property color textColor: containsMouse ? (ColorPaletteService.colors.background ?? "black") : (ColorPaletteService.colors.color6 ?? "white")

    width: userDisplayText.implicitWidth + (fontSizePixels * 2)
    height: parent.height

    hoverEnabled: true

    Rectangle {
        id: fill

        anchors.fill: parent
        opacity: root.containsMouse ? 0.975 : 0.2
        color: ColorPaletteService.colors.color6 ?? "black"

        Behavior on opacity {
            NumberAnimation {
                duration: root.animationDurationMS
            }
        }
    }

    Text {
        id: userDisplayText
        anchors.centerIn: parent
        text: `// ${UserService.currentUsername.toUpperCase() ?? "Fetching username..."} //`

        color: root.textColor

        font.family: GTK3Service.getFontName()
        font.pixelSize: root.fontSizePixels

        Behavior on color {
            PropertyAnimation {
                duration: root.animationDurationMS
            }
        }
    }
}
