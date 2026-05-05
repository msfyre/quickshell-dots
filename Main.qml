import QtQuick
import Quickshell
import qs.renderers
import qs.services

Item {
	id: root
	
	LazyLoader {
		id: notifServiceLoader
		loading: true
		source: NotificationService.objectName
	}

	DesktopWidgets {}
	NotificationPopupDisplay {}
	VolumePopupDisplay {}
}
