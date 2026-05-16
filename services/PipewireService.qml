pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire

Singleton {
    id: root

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

    readonly property PwNode audioSink: Pipewire.defaultAudioSink
    readonly property bool isHeadphonesConnected: activePort.includes("headphones")

    property string activePort: ""

    readonly property real volume: {
        if (audioSink != null) {
            return audioSink.audio.volume;
        } else {
            return 0;
        }
    }

    Process {
        id: activePortCatcher

        command: ["sh", "-c", "pactl list sinks | grep 'Active Port'"]

        stdout: StdioCollector {
            onStreamFinished: {
                root.activePort = this.text.replace("Active Port: ", "").trim();
            }
        }
    }

    FrameAnimation {
        running: true

        onTriggered: {
            activePortCatcher.running = true;
        }
    }
}
