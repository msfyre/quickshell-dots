import QtQuick
import QtQuick.Layouts
import Quickshell

Item {
    id: root

    property color bgColor: "black"
    property color textColor: "white"
    property string textFont: "sans"
    property real displayHeight

    implicitWidth: Math.round(displayLayout.implicitWidth + (displayHeight * 2))
    implicitHeight: Math.round(displayLayout.implicitHeight + (displayHeight / 2))

    SystemClock {
        id: clock

        readonly property string formattedTime: Qt.formatDateTime(date, "hh:mm:ss A")
        readonly property string formattedDate: Qt.formatDateTime(date, "ddd | MMMM dd, yyyy")
    }

    Rectangle {
        implicitWidth: parent.width
        implicitHeight: parent.height
        color: root.bgColor
        radius: 5
        border.color: root.textColor
        border.width: 2
        opacity: 0.675
    }

    ColumnLayout {
        id: displayLayout

        spacing: 0

        anchors {
            fill: parent
            margins: 8
        }

        Text {
            id: dateDisplayText

            Layout.alignment: Qt.AlignCenter
            text: clock.formattedDate
            color: root.textColor
            font.family: root.textFont
            font.pixelSize: root.displayHeight * 0.35
        }

        Text {
            id: timeDisplayText

            Layout.alignment: Qt.AlignCenter
            text: clock.formattedTime
            color: root.textColor
            font.family: root.textFont
            font.pixelSize: root.displayHeight * 0.65
            font.weight: 500
        }
    }
}
