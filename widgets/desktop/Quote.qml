import QtQuick
import qs.services

Item {
	id: root
	
	readonly property color textColor: ColorPaletteService.colorScheme.base16[6] ?? "white"
	readonly property int animationDuration: 500

	property real borderRadius: 5

	implicitWidth: displayText.implicitWidth + (displayText.font.pixelSize * 3)
	implicitHeight: displayText.implicitHeight * 1.5

	Behavior on implicitWidth {
		PropertyAnimation {
			duration: root.animationDuration
			easing.type: Easing.InOutCubic
		}
	}
	Behavior on implicitHeight {
		PropertyAnimation {
			duration: root.animationDuration / 2
			easing.type: Easing.InOutCubic
		}
	}

	PropertyAnimation {
		id: textOpacityTween
		target: displayText
		property: "opacity"
		from: 0
		to: 1
		duration: root.animationDuration
		easing.type: Easing.InCubic
	}

	Rectangle {
		color: ColorPaletteService.colorScheme.background ?? "black"
		radius: root.borderRadius
		border.color: root.textColor
		border.width: 2

		implicitWidth: root.implicitWidth
		implicitHeight: root.implicitHeight
	}

	Text {
		id: displayText
		anchors.centerIn: parent
		text: QuoteService.quote
		color: root.textColor
		font.family: GTK3Service.getFontName()
		font.pixelSize: GTK3Service.getFontSize()

	}

	Timer {
		interval: 5000
		running: true
		repeat: true

		onTriggered: {
			QuoteService.generateQuote()
		}
	}

	Connections {
		target: QuoteService

		function onQuoteChanged() {
			textOpacityTween.start()
		}
	}
}
