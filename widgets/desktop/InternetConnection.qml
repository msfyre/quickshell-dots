pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell.Networking
import qs.services

Item {
    id: root

    readonly property color textColor: ColorPaletteService.fileRead ? ColorPaletteService.colorScheme.base16[6] : "white"
    readonly property string fontFamily: GTK3Service.getFontName()
    readonly property real fontSize: GTK3Service.getFontSize()

    property real separatorWidth: 2

    implicitWidth: layout.implicitWidth + (fontSize * 2.5)
    implicitHeight: layout.implicitHeight + (fontSize * 1.5)

    Rectangle {
        color: ColorPaletteService.colorScheme.background ?? "black"
        border.color: root.textColor
        border.width: 2
        radius: 4
        anchors.fill: parent
    }

    ColumnLayout {
        id: layout

        anchors.centerIn: parent

        property real maxPrefixWidth: 0

        spacing: 0

        Repeater {
            model: Networking.devices

            Row {
                id: networkDeviceItem

                required property NetworkDevice modelData

                property Network connectedNetwork: null

                spacing: 7.5

                function updateConnectedNetwork() {
                    for (const network of networkDeviceItem.modelData.networks.values) {
                        if (network.connected) {
                            networkDeviceItem.connectedNetwork = network;
                            return;
                        }
                    }

                    networkDeviceItem.connectedNetwork = null;
                }

                Layout.alignment: Qt.AlignVCenter

                Repeater {
                    model: networkDeviceItem.modelData.networks.values

                    Item {
                        id: networkItem

                        required property Network modelData

                        Connections {
                            target: networkItem.modelData

                            function onConnectedChanged() {
                                networkDeviceItem.updateConnectedNetwork();
                            }
                        }
                    }
                }

                // alignment purposes
                Item {
                    implicitWidth: layout.maxPrefixWidth
                    implicitHeight: prefixDisplay.implicitHeight

                    anchors.verticalCenter: parent.verticalCenter

                    Text {
                        id: prefixDisplay

                        text: {
                            switch (networkDeviceItem.modelData.type) {
                            case DeviceType.Wifi:
                                return "\uf1eb";
                            case DeviceType.Wired:
                                return "\uef44";
                            default:
                                return "";
                            }
                        }

                        anchors.centerIn: parent

                        color: root.textColor

                        font {
                            family: root.fontFamily
                            pointSize: root.fontSize
                        }
                    }
                }

                Rectangle {
                    id: separatorA
                    width: root.separatorWidth
                    height: parent.height
                    color: root.textColor
                }

                Text {
                    id: statusDisplay

                    color: root.textColor

                    anchors.verticalCenter: parent.verticalCenter

                    text: {
                        switch (networkDeviceItem.modelData.state) {
                        case ConnectionState.Connecting:
                            return "Connecting...";
                        case ConnectionState.Connected:
                            networkDeviceItem.updateConnectedNetwork();
                            return networkDeviceItem.connectedNetwork ? networkDeviceItem.connectedNetwork.name : "Connected";
                        case ConnectionState.Disconnecting:
                            return "Disconnecting...";
                        default:
                            return "Offline";
                        }
                    }

                    font {
                        bold: true
                        family: root.fontFamily
                        pointSize: root.fontSize
                    }
                }

                Rectangle {
                    id: separatorB
                    visible: networkDeviceItem.modelData.type === DeviceType.Wifi && networkDeviceItem.modelData.connected
                    width: root.separatorWidth
                    height: parent.height
                    color: root.textColor
                }

                Text {
                    id: strengthDisplay
                    visible: networkDeviceItem.modelData.type === DeviceType.Wifi && networkDeviceItem.modelData.connected
                    text: {
                        const networkAsWifi = networkDeviceItem.connectedNetwork as WifiNetwork;
                        return `[${networkAsWifi.signalStrength}]`;
                    }
                    color: root.textColor

                    font {
                        bold: true
                        family: root.fontFamily
                        pointSize: root.fontSize
                    }
                }

                Component.onCompleted: {
                    layout.maxPrefixWidth = Math.max(prefixDisplay.implicitWidth);
                    updateConnectedNetwork();
                }
            }
        }
    }
}
