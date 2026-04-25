pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property string fontName: ""
    property double fontSize: 10

    Process {
        id: fontProcess

        command: ["gsettings", "get", "org.gnome.desktop.interface", "font-name"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                let output = this.text.trim();
                output = output.replace(/^'|'$/g, "");

                const sizeMatch = output.match(/\s+(\d+)$/);
                const fontSize = sizeMatch ? parseFloat(sizeMatch[1]) : 10;

                root.fontName = output.replace(/\s+\d+$/, "");
                root.fontSize = fontSize;
            }
        }
    }

    FrameAnimation {
        running: true
        onTriggered: {
            fontProcess.running = true;
        }
    }
}
