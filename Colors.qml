pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property var adapter: colorFileAdapter

    FileView {
        id: colorFileView
        path: Quickshell.shellDir + "/color.json"
        watchChanges: true

        adapter: colorFileAdapter

        onFileChanged: {
            reload();
        }
    }

    JsonAdapter {
        id: colorFileAdapter

        property color background: "black"
        property color foreground: "white"
        property var base16
    }
}
