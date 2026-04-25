import QtQuick
import Quickshell.Io

Item {
    id: root

    property double quoteRouletteCooldownSecs: 10
    property color bgColor: "black"
    property color textColor: "white"
    property string textFont: "sans"
    property real displayHeight: 25
    property string displayedQuote: ""
    property int animationDuration: 250

    implicitWidth: Math.round(displayText.implicitWidth + (displayHeight * 3))
    implicitHeight: Math.round(displayText.implicitHeight + (displayHeight * 2))

    Process {
        id: fortuneProcess

        command: ["fortune", "/usr/share/fortune/science", "-s"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                root.displayedQuote = this.text.trim();
            }
        }

    }

    Rectangle {
        implicitWidth: parent.width
        implicitHeight: parent.height
        color: root.bgColor
        radius: 5
        opacity: 0.675
        border.color: root.textColor
        border.width: 2
    }

    Text {
        id: displayText

        anchors.centerIn: parent
        text: root.displayedQuote
        color: root.textColor
        font.family: root.textFont
        font.pixelSize: root.displayHeight
        smooth: true

        Behavior on text {
            PropertyAnimation {
                target: displayText
                property: "opacity"
                from: 0
                to: 1
                duration: root.animationDuration
                easing.type: Easing.InExpo
            }

        }

    }

    Timer {
        interval: (root.quoteRouletteCooldownSecs * 1000) + root.animationDuration
        running: true
        repeat: true
        onTriggered: {
            fortuneProcess.running = true;
        }
    }

    Behavior on implicitWidth {
        NumberAnimation {
            duration: root.animationDuration
            easing.type: Easing.InOutCubic
        }

    }

    Behavior on implicitHeight {
        NumberAnimation {
            duration: root.animationDuration / 2
            easing.type: Easing.InOutCubic
        }

    }

}
