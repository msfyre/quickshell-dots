import "." as Widgets
import ".."
import Quickshell
import Quickshell.Wayland

PanelWindow {
    id: root

    implicitWidth: screen.width
    implicitHeight: screen.height
    color: "transparent"
    aboveWindows: false
    WlrLayershell.layer: WlrLayer.Bottom
    WlrLayershell.namespace: "qs-desktop-widgets"

    Widgets.MprisIndicator {
        displayHeight: 9
        bgColor: Colors.adapter.background
        textColor: Colors.adapter.base16[7]
        textFont: GTK3.fontName

        anchors {
            top: parent.top
            topMargin: 10

            right: parent.right
            rightMargin: 15
        }
    }

    Widgets.Clock {
        displayHeight: 30
        bgColor: Colors.adapter.background
        textColor: Colors.adapter.base16[7]
        textFont: GTK3.fontName

        anchors {
            bottom: parent.bottom
            bottomMargin: 10
            right: parent.right
            rightMargin: 15
        }
    }

    Widgets.Quote {
        displayHeight: 10
        quoteRouletteCooldownSecs: 5
        animationDuration: 750
        bgColor: Colors.adapter.background
        textColor: Colors.adapter.base16[7]
        textFont: GTK3.fontName

        anchors {
            bottom: parent.bottom
            bottomMargin: 10
            left: parent.left
            leftMargin: 15
        }
    }
}
