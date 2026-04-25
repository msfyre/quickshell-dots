import QtQuick
import Quickshell.Services.Mpris
import "../modules" as Modules

Item {
    id: root

    property real visibilityTimeSecs: 5
    property color bgColor: "black"
    property color textColor: "white"
    property string textFont: "sans"
    property real displayHeight: 10

    visible: false
    opacity: 0

    readonly property MprisPlayer player: Modules.MprisMod.getPlayerFromName("mpd")

    implicitWidth: Math.round(popupText.implicitWidth + (displayHeight * 2))
    implicitHeight: Math.round(popupText.implicitHeight + (displayHeight * 1.5))

    anchors.horizontalCenter: parent.horizontalCenter

    Behavior on opacity {
        NumberAnimation {
            id: opacityTween
            duration: 250
        }
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

    Connections {
        target: root.player

        function onPostTrackChanged() {
            root.visible = true;

            root.opacity = 1;

            popupText.text = `[${root.player.identity}] Now Playing: ${root.player.trackArtist} - ${root.player.trackTitle}`;

            visibilityTimer.restart();
            visibilityTimerForAnimation.restart();
        }
    }

    Text {
        id: popupText
        anchors.centerIn: parent
        text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.\nCurabitur vehicula ipsum id lacinia dictum.\nUt congue dolor sed aliquam aliquam.\nMorbi ut nisl nec felis iaculis porta id in dui.\nUt elementum, neque sed scelerisque imperdiet, arcu libero malesuada odio, sed finibus ipsum odio non nisl.\nMauris convallis quam eget enim tincidunt scelerisque.\nVestibulum faucibus ipsum nibh, sit amet ultricies mauris sagittis sit amet.\nNam ut maximus odio.\nSed pretium arcu id venenatis rutrum.\nDuis quis turpis ac lorem lacinia vehicula vel sit amet justo."
        horizontalAlignment: Text.AlignHCenter
        color: root.textColor
        font.family: root.textFont
        font.pixelSize: root.displayHeight
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
