import QtQuick
import Quickshell
import qs.services

Item {
	id: root

	implicitWidth: layout.implicitWidth + layout.implicitHeight

	property bool isFormat24H: false

	property real borderRadius: 5

	readonly property color textColor: ColorPaletteService.colorScheme.base16[6] ?? "white"
	readonly property string fontFamily: GTK3Service.getFontName()

	SystemClock {
		id: sysclock

		readonly property string formattedTime: Qt.formatDateTime(date, root.isFormat24H ? "HH:mm:ss" : "hh:mm:ss A")
		readonly property string formattedDate: Qt.formatDateTime(date, "MMMM dd, yyyy")
	}

	Rectangle {
		color: ColorPaletteService.colorScheme.background ?? "black"
		border.color: root.textColor
		border.width: 2
		radius: root.borderRadius
		anchors.fill: parent
	}

	Column {
		id: layout
		anchors.centerIn: parent

		readonly property real totalHeight: root.implicitHeight * 0.5

		spacing: 0

		Text {
			id: dateText
			anchors.horizontalCenter: parent.horizontalCenter
			text: sysclock.formattedDate
			color: root.textColor
			font.family: root.fontFamily
			font.pixelSize: layout.totalHeight * 0.35
		}

		Text {
			id: timeText
			anchors.horizontalCenter: parent.horizontalCenter
			text: root.isFormat24H ? `[24H] ${sysclock.formattedTime}` : sysclock.formattedTime
			color: root.textColor
			font.weight: 700
			font.family: root.fontFamily
			font.pixelSize: layout.totalHeight * 0.65
		}
	}
}
