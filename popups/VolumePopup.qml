import QtQuick
import Quickshell.Services.Pipewire

Item {
    id: root
    property real visibilityTimeSecs: 5
    property color bgColor: "black"
    property color barBGColor: "gray"
    property color textColor: "white"
    property string textFont: "sans"
    property real displayHeight: 10
    implicitWidth: Math.round(layout.implicitWidth + (displayHeight * 2.8))
    implicitHeight: Math.round(layout.implicitHeight + (displayHeight * 2))

    anchors.horizontalCenter: parent.horizontalCenter
    visible: true
    opacity: 0

    readonly property bool isAudioMuted: !(Pipewire.defaultAudioSink.audio.volume > 0 && !Pipewire.defaultAudioSink.audio.muted)

    Behavior on opacity {
        NumberAnimation {
            id: opacityTween
            duration: 250
        }
    }

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

    Connections {
        target: Pipewire.defaultAudioSink.audio

        function onVolumesChanged() {
            root.visible = true;
            root.opacity = 1;

            if (!root.isAudioMuted) {
                popupText.text = `VOLUME: ${Math.round(Pipewire.defaultAudioSink.audio.volume * 100)}%`;
            } else {
                popupText.text = `VOLUME: ${Math.round(Pipewire.defaultAudioSink.audio.volume * 100)}% (MUTED!)`;
            }

            visibilityTimer.restart();
            visibilityTimerForAnimation.restart();
        }

        function onMutedChanged() {
            root.visible = true;
            root.opacity = 1;

            if (!root.isAudioMuted) {
                popupText.text = `VOLUME: ${Math.round(Pipewire.defaultAudioSink.audio.volume * 100)}%`;
            } else {
                popupText.text = `VOLUME: ${Math.round(Pipewire.defaultAudioSink.audio.volume * 100)}% (MUTED!)`;
            }

            visibilityTimer.restart();
            visibilityTimerForAnimation.restart();
        }
    }

    Rectangle {
        id: backdrop
        implicitWidth: parent.width
        implicitHeight: parent.height
        color: root.bgColor
        radius: 5
        border.color: root.textColor
        border.width: 2
        opacity: 0.675
    }

    Column {
        id: layout

        anchors.centerIn: parent

        spacing: 6

        Rectangle {
            id: volumeBar

            anchors.horizontalCenter: parent.horizontalCenter
            implicitWidth: popupText.implicitWidth + (root.displayHeight * 2)
            implicitHeight: root.displayHeight / 2

            color: root.barBGColor

            radius: backdrop.radius / Math.PI
            visible: !root.isAudioMuted

            Rectangle {
                implicitWidth: parent.width * Pipewire.defaultAudioSink.audio.volume
                implicitHeight: parent.height

                color: root.textColor
                radius: implicitHeight / 2

                Behavior on implicitWidth {
                    NumberAnimation {
                        duration: 250
                        easing.type: Easing.OutCubic
                    }
                }
            }
        }

        Text {
            id: popupText

            anchors.horizontalCenter: parent.horizontalCenter

            text: "VOLUME: 99.9%"
            horizontalAlignment: Text.AlignHCenter
            color: root.textColor
            font.family: root.textFont
            font.pixelSize: root.displayHeight
        }
    }

    Timer {
        id: visibilityTimer
        interval: (root.visibilityTimeSecs * 1000) + (opacityTween.duration * 2)
        running: false

        onTriggered: {
            root.visible = false;
        }
    }

    Timer {
        id: visibilityTimerForAnimation
        interval: (root.visibilityTimeSecs * 1000) + opacityTween.duration
        running: false

        onTriggered: {
            root.opacity = 0;
        }
    }
}
