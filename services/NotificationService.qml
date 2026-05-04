pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Notifications

Singleton {
	id: root

	property ListModel tracked: trackedModel

	ListModel {
		id: trackedModel
	}

	signal notificationTracked(notification: Notification)
	
	function untrackNotification(notification: Notification) {
		for (let i = 0; i < trackedModel.count; i++) {
			if (trackedModel.get(i).notification == notification) {
				notification.tracked = false;
				trackedModel.remove(i);
				break;
			}
		}
	}

	NotificationServer {
		id: server

		imageSupported: true

		onNotification: notification => {
			notification.tracked = true

			trackedModel.append({ notification: notification });
			root.notificationTracked(notification);
		}
	}

	onNotificationTracked: notification => {
		console.log("Tracked a new notification!");
		console.log(notification.body.length > 0 ? `${notification.appName}: ${notification.summary} (${notification.body})` : `${notification.appName}: ${notification.summary}`)
	}
}
