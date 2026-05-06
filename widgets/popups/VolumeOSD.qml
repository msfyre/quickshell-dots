import QtQuick
import qs.services

Item {
	id: root

	property color textColor: ColorPaletteService.colorScheme.base16[7]
	
	property real fontSize: GTK3Service.getFontSize()

	property real borderRadius: 5

	implicitWidth: layout.implicitWidth + (fontSize * 3)
	implicitHeight: layout.implicitHeight + (fontSize * 2)

	Rectangle {
		anchors.fill: parent
		color: ColorPaletteService.colorScheme.background
		radius: root.borderRadius
		border.color: root.textColor
		border.width: 2
	}

	visible: opacity > 0

	opacity: 0

	Column {
		id: layout

		anchors.centerIn: parent

		spacing: 4

		Rectangle {
			id: volumeBar

			width: parent.width
			height: 5

			anchors.horizontalCenter: parent.horizontalCenter

			color: ColorPaletteService.colorScheme.base16[0] ?? "gray"
			radius: root.borderRadius

			visible: !PipewireService.isMuted && PipewireService.volume > 0

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
				if (!PipewireService.isMuted && PipewireService.volume > 0) {
					return `VOLUME: ${Math.round(PipewireService.volume * 100)}%`
				} else if (PipewireService.isMuted && PipewireService.volume > 0) {
					return `VOLUME: ${Math.round(PipewireService.volume * 100)}% (MUTED)`
				} else {
					return `(MUTED)`
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
