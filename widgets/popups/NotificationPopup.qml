import QtQuick
import Quickshell.Services.Notifications
import qs.services

Item {
    id: root

    required property Notification modelData
    property int timeoutMS: 5000

    readonly property color textColor: ColorPaletteService.colors.color6 ?? "white"
    readonly property string fontFamily: GTK3Service.getFontName()
    readonly property int fontSize: GTK3Service.getFontSize()

    readonly property int animationDuration: 500

    implicitWidth: layout.implicitWidth + (summaryText.font.pixelSize * 2)
    implicitHeight: layout.implicitHeight + (summaryText.font.pointSize * 1.5)

    visible: opacity > 0

    opacity: baseMouseArea.containsMouse ? 0.95 : 0.8

    MouseArea {
        id: baseMouseArea
        anchors.fill: parent
        hoverEnabled: true

        onClicked: {
            fadeoutTimer.running = !fadeoutTimer.running;
            notificationActions.visible = !notificationActions.visible;
        }
    }

    PropertyAnimation {
        id: fadeOutAnimation
        property: "opacity"
        target: root
        to: 0
        duration: root.animationDuration
        easing.type: Easing.InExpo
    }

    Rectangle {
        anchors.fill: parent
        color: ColorPaletteService.colors.background ?? "black"
        radius: 5
        border.color: root.textColor
        border.width: 2
    }

    Row {
        id: layout

        anchors.centerIn: parent

        spacing: 10

        Column {
            id: textLayout

            spacing: 2

            anchors {
                verticalCenter: parent.verticalCenter
            }

            Text {
                id: summaryText
                text: root.modelData.summary
                color: root.textColor
                anchors.horizontalCenter: parent.horizontalCenter

                font {
                    bold: true
                    family: root.fontFamily
                    pointSize: root.fontSize
                }
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter

                spacing: 10

                Image {
                    id: notificationImage

                    anchors.verticalCenter: parent.verticalCenter

                    source: root.modelData.image
                    height: bodyText.implicitHeight + (root.fontSize * 2)

                    smooth: true

                    fillMode: Image.PreserveAspectFit
                }

                Text {
                    id: bodyText
                    text: root.modelData.body
                    textFormat: Text.AutoText
                    color: root.textColor

                    anchors.verticalCenter: parent.verticalCenter

                    wrapMode: Text.WordWrap

                    font {
                        family: root.fontFamily
                        pointSize: root.fontSize * 0.8
                    }
                }
            }
        }

        Column {
            id: notificationActions

            visible: false

            Repeater {
                model: root.modelData.actions

                MouseArea {
                    id: actionButton

                    required property NotificationAction modelData

                    width: actionButtonText.implicitWidth
                    height: actionButtonText.implicitHeight

                    Text {
                        id: actionButtonText
                        text: actionButton.modelData.text
                    }

                    onClicked: {
                        modelData.invoke();
                    }
                }
            }
        }
    }

    Timer {
        id: fadeoutTimer

        interval: root.timeoutMS - (root.animationDuration + 100)
        running: true

        onTriggered: {
            fadeOutAnimation.start();
        }
    }
}
