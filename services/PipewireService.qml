import Quickshell
import Quickshell.Services.Pipewire
pragma Singleton

Singleton {
	PwObjectTracker {
		objects: [Pipewire.defaultAudioSink]
	}

	readonly property PwNode audioSink: Pipewire.defaultAudioSink

	readonly property real volume: {
		if (audioSink != null) {
			return audioSink.audio.volume;
		} else {
			return 0;
		}
	}

	readonly property bool isMuted: audioSink.audio.muted
}
