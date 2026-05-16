import QtQuick
import qs.services

Item {
    id: root

    property color textColor: ColorPaletteService.colors.color6

    property real fontSize: GTK3Service.getFontSize()

    property real borderRadius: 5

    implicitWidth: layout.implicitWidth + (fontSize * 3)
    implicitHeight: layout.implicitHeight + (fontSize * 2)

    Rectangle {
        anchors.fill: parent
        color: ColorPaletteService.colors.background
        radius: root.borderRadius
        border.color: root.textColor
        border.width: 2

        opacity: 0.9
    }

    visible: opacity > 0

    opacity: 0

    Column {
        id: layout

        anchors.centerIn: parent

        spacing: 2

        Item {
            anchors.horizontalCenter: parent.horizontalCenter

            width: headphoneIndicatorDisplay.implicitWidth
            height: headphoneIndicatorDisplay.implicitHeight

            Text {
                id: headphoneIndicatorDisplay
                anchors.centerIn: parent
                text: PipewireService.isHeadphonesConnected ? "\udb80\udecb" : "\udb81\udfce"
                color: root.textColor
                font.family: GTK3Service.getFontName()
                font.pointSize: root.fontSize * 1.5
            }
        }

        Rectangle {
            id: volumeBar

            width: volumeText.implicitWidth
            height: 5

            anchors.horizontalCenter: parent.horizontalCenter

            color: ColorPaletteService.colors.color0 ?? "gray"
            radius: root.borderRadius

            visible: !PipewireService.audioSink.audio.muted && PipewireService.volume > 0

            Rectangle {
                width: parent.width * PipewireService.volume
                height: parent.height

                color: root.textColor ?? "white"
                radius: root.borderRadius

                Behavior on width {
                    PropertyAnimation {
                        duration: 250
                        easing.type: Easing.OutCubic
                    }
                }
            }
        }

        Text {
            id: volumeText
            anchors.horizontalCenter: parent.horizontalCenter
            text: {
                if (!PipewireService.audioSink.audio.muted && PipewireService.volume > 0) {
                    return `VOLUME: ${Math.round(PipewireService.volume * 100)}%`;
                } else if (PipewireService.audioSink.audio.muted && PipewireService.volume > 0) {
                    return `VOLUME: ${Math.round(PipewireService.volume * 100)}% (MUTED)`;
                } else {
                    return `(MUTED)`;
                }
            }
            color: root.textColor
            font.family: GTK3Service.getFontName()
            font.pointSize: root.fontSize
        }
    }

    Connections {
        target: PipewireService.audioSink.audio

        function onVolumeChanged() {
            root.opacity = 1;
            visibilityTimer.restart();
        }

        function onMutedChanged() {
            root.opacity = 1;
            visibilityTimer.restart();
        }
    }

    Behavior on opacity {
        PropertyAnimation {
            id: opacityTween
            duration: 250
        }
    }

    Timer {
        id: visibilityTimer
        interval: 5000 - opacityTween.duration

        onTriggered: {
            root.opacity = 0;
        }
    }
}
