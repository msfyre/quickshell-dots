import QtQuick
import qs.services

Item {
	id: root

	implicitWidth: layout.implicitWidth + layout.implicitHeight

	Rectangle {
		anchors.fill: parent
	}

	Column {
		id: layout
		anchors.centerIn: parent

		readonly property real totalHeight: root.implicitHeight * 0.6

		spacing: 0

		Text {
			id: dateText
			anchors.horizontalCenter: parent.horizontalCenter
			text: ClockService.formattedDate
			font.pixelSize: layout.totalHeight * 0.4
		}

		Text {
			id: timeText
			anchors.horizontalCenter: parent.horizontalCenter
			text: ClockService.formattedTime
			font.pixelSize: layout.totalHeight * 0.5
		}
	}
}
