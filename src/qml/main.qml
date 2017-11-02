import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import Hardware.Transmitter 1.0
import SignalBar 1.0
import StandardPopup 1.0

ApplicationWindow {
    title: qsTr("Drone Shooter")
    width: 1024
    height: 600
    visible: true

    // Left frame.
    Frame {
        id: leftFrame
        width: 250
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        Label {
            text: qsTr("DRONE SHOT")
            anchors.horizontalCenter: parent.horizontalCenter
        }

        RoundButton {
            text: qsTr("Off")
            width: 150
            height: 150
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Button {
            text: qsTr("Legal Notices")
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            onClicked: legalPopup.open()
        }
    }

    // Right frame.
    Frame {
        anchors.left: leftFrame.right
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        GridLayout {
            columns: 2
            anchors.fill: parent

            // Wi-Fi 1
            Label {
                text: qsTr("Wi-Fi (2.4 - 2.5 GHz)")
            }

            SignalBar {
                value: transmitterManager.getTransmitterController(TransmitterID.WiFi1).utilization
                Layout.fillWidth: true
            }

            // Wi-Fi 2
            Label {
                text: qsTr("Wi-Fi (2.4 - 2.5 GHz)")
            }

            SignalBar {
                value: transmitterManager.getTransmitterController(TransmitterID.WiFi2).utilization
                Layout.fillWidth: true
            }

            // Wi-Fi 3
            Label {
                text: qsTr("Wi-Fi (5.5 - 5.8 GHz)")
            }

            SignalBar {
                value: transmitterManager.getTransmitterController(TransmitterID.WiFi3).utilization
                Layout.fillWidth: true
            }

            // GPS
            Label {
                text: qsTr("GPS (1575 MHz)")
            }

            SignalBar {
                value: transmitterManager.getTransmitterController(TransmitterID.GPS).utilization
                Layout.fillWidth: true
            }

            // RC 1
            Label {
                text: qsTr("RC (868 - 912 MHz)")
            }

            SignalBar {
                value: transmitterManager.getTransmitterController(TransmitterID.RC1).utilization
                Layout.fillWidth: true
            }

            // RC 2
            Label {
                text: qsTr("RC (433 - 434 MHz)")
            }

            SignalBar {
                value: transmitterManager.getTransmitterController(TransmitterID.RC2).utilization
                Layout.fillWidth: true
            }
        }
    }

    // Legal Popup
    StandardPopup {
        id: legalPopup
    }
}
