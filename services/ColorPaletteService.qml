pragma Singleton

import QtQuick

import Quickshell
import Quickshell.Io

Singleton {
    id: root

    readonly property QtObject colors: QtObject {
        readonly property color background: colorAdapter.background
        readonly property color foreground: colorAdapter.foreground

        readonly property color color0: colorAdapter.base16 ? colorAdapter.base16[0] : "#181818"
        readonly property color color1: colorAdapter.base16 ? colorAdapter.base16[1] : "#282828"
        readonly property color color2: colorAdapter.base16 ? colorAdapter.base16[2] : "#383838"
        readonly property color color3: colorAdapter.base16 ? colorAdapter.base16[3] : "#585858"
        readonly property color color4: colorAdapter.base16 ? colorAdapter.base16[4] : "#b8b8b8"
        readonly property color color5: colorAdapter.base16 ? colorAdapter.base16[5] : "#d8d8d8"
        readonly property color color6: colorAdapter.base16 ? colorAdapter.base16[6] : "#e8e8e8"
        readonly property color color7: colorAdapter.base16 ? colorAdapter.base16[7] : "#f8f8f8"
        readonly property color color8: colorAdapter.base16 ? colorAdapter.base16[8] : "#ab4642"
        readonly property color color9: colorAdapter.base16 ? colorAdapter.base16[9] : "#dc9656"
        readonly property color color10: colorAdapter.base16 ? colorAdapter.base16[10] : "#f7ca88"
        readonly property color color11: colorAdapter.base16 ? colorAdapter.base16[11] : "#a1b56c"
        readonly property color color12: colorAdapter.base16 ? colorAdapter.base16[12] : "#86c1b9"
        readonly property color color13: colorAdapter.base16 ? colorAdapter.base16[13] : "#7cafc2"
        readonly property color color14: colorAdapter.base16 ? colorAdapter.base16[14] : "#ba8baf"
        readonly property color color15: colorAdapter.base16 ? colorAdapter.base16[15] : "#a16946"
    }

    property bool fileRead: false

    FileView {
        path: Quickshell.shellDir + "/color.json"

        adapter: colorAdapter

        watchChanges: true

        onLoaded: root.fileRead = true

        onFileChanged: {
            root.fileRead = false;
            reload();
        }
    }

    JsonAdapter {
        id: colorAdapter

        property string foreground
        property string background
        property var base16
    }
}
