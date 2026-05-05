import QtQuick
import Quickshell.Services.Pipewire
import qs.services

Item {
	id: root

	PwObjectTracker {
		objects: [Pipewire.defaultAudioSink]
	}

	property color textColor: ColorPaletteService.colorScheme.base16[7]
	
	property real fontSize: GTK3Service.getFontSize()

	property real borderRadius: 5

	property PwNode audioSink: Pipewire.defaultAudioSink

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

			visible: !root.audioSink.audio.muted && root.audioSink.audio.volume > 0

			Rectangle {
				width: parent.width * root.audioSink.audio.volume
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
				if (!root.audioSink.audio.muted && root.audioSink.audio.volume > 0) {
					return `VOLUME: ${Math.round(root.audioSink.audio.volume * 100)}%`
				} else if (root.audioSink.audio.muted && root.audioSink.audio.volume > 0) {
					return `VOLUME: ${Math.round(root.audioSink.audio.volume * 100)}% (MUTED)`
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
		target: root.audioSink.audio

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
