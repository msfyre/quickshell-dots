import QtQuick
import Quickshell.Services.SystemTray

Row {
	id: root

    Repeater {
        model: SystemTray.items

        MouseArea {
            id: trayItemButton

            required property SystemTrayItem modelData

            Image {
                source: trayItemButton.modelData.icon
		sourceSize.width: root.parent.height
		sourceSize.height: root.parent.height
            }
        }
    }
}
