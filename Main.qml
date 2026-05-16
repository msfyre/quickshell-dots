import QtQuick
import Quickshell
import qs.renderers
import qs.services

Scope {
    id: root

    LazyLoader {
        id: notifServiceLoader
        loading: true
        source: NotificationService.objectName
    }

    StatusBarDisplay {}
    NotificationPopupDisplay {}
    VolumePopupDisplay {}
}
