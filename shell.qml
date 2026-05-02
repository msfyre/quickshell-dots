import QtQuick
import Quickshell
import qs.services

ShellRoot {
	Loader {
		id: shellLoader
		sourceComponent: Main {}
	}

	Component.onCompleted: {
		QuoteService.quoteDatabase = "linux";
	}
}
