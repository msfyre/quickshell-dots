import QtQuick
import Quickshell.Services.Notifications
import qs.services

Item {
	id: root

	required property Notification modelData
	property int timeoutMS: 5000

	readonly property color textColor: ColorPaletteService.colorScheme.base16[7] ?? "white"
	readonly property string fontFamily: GTK3Service.getFontName()
	readonly property int fontSize: GTK3Service.getFontSize()

	readonly property int animationDuration: 500

	implicitWidth: layout.implicitWidth + (summaryText.font.pixelSize * 2)
	implicitHeight: layout.implicitHeight + (summaryText.font.pointSize * 1.5)

	visible: opacity > 0

	opacity: 1

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
		color: ColorPaletteService.colorScheme.background ?? "black"
		radius: 5
		border.color: root.textColor
		border.width: 2
	}

	Row {
		id: layout

		anchors.centerIn: parent

		spacing: 10

		Image {
			id: notificationImage

			source: root.modelData.image
			sourceSize.height: textLayout.implicitHeight

			width: textLayout.implicitHeight

			fillMode: Image.PreserveAspectFit
		}

		Column {
			id: textLayout

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

			Text {
				id: bodyText
				text: root.modelData.body
				color: root.textColor
				anchors.horizontalCenter: parent.horizontalCenter

				font {
					family: root.fontFamily
					pointSize: root.fontSize * 0.8
				}
			}
		}
	}

	Timer {
		interval: root.timeoutMS - (root.animationDuration + 100)
		running: true

		onTriggered: {
			fadeOutAnimation.start();
		}
	}

	Component.onCompleted: {
		console.log("Image:", root.modelData.image);
	}
}
