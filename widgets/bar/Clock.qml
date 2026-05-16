import QtQuick
import Quickshell

import qs.services

MouseArea {
    id: root

    readonly property real fontSize: height * 0.5
    readonly property color textColor: containsMouse ? ColorPaletteService.colors.background ?? "black" : ColorPaletteService.colors.color6 ?? "white"
    readonly property int animationDurationMS: 200

    width: displayText.implicitWidth + (fontSize * 2)
    height: parent.height

    hoverEnabled: true

    visible: displayText.text.length > 0

    Behavior on width {
        PropertyAnimation {
            duration: root.animationDurationMS
        }
    }

    SystemClock {
        id: clock

        readonly property string formattedTime: Qt.formatDateTime(date, "hh:mm:ss A")
        readonly property string formattedDate: Qt.formatDateTime(date, "MM/dd/yyyy")
    }

    Rectangle {
        anchors.fill: parent
        opacity: root.containsMouse ? 0.95 : 0.2

        color: ColorPaletteService.colors.color6 ?? "black"

        Behavior on opacity {
            NumberAnimation {
                duration: root.animationDurationMS
            }
        }
    }

    Text {
        id: displayText

        anchors.centerIn: parent

        text: root.containsMouse ? `DATE: ${clock.formattedDate}` : `TIME: ${clock.formattedTime}`
        color: root.textColor

        font.family: GTK3Service.getFontName()
        font.pixelSize: root.fontSize

        Behavior on color {
            PropertyAnimation {
                duration: root.animationDurationMS
            }
        }
    }
}
