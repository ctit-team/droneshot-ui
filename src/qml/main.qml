import QtGraphicalEffects 1.0
import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import AboutPopup 1.0
import Hardware.Transmitter 1.0
import PowerSwitch 1.0
import SignalBar 1.0
import StandardPopup 1.0
import TransmitterConfigurator 1.0

import "main.js" as Presenter

ApplicationWindow {
    title: qsTr("Drone Shot")
    width: 1024
    height: 600
    visible: true
    flags: Qt.FramelessWindowHint

    // Left frame.
    Frame {
        id: leftFrame
        width: 250
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        Image {
            id: logo
            source: "qrc:/resources/images/logo-medium.png"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        ColorOverlay {
            source: logo
            color: "#FFFFFF"
            anchors.fill: logo
        }

        PowerSwitch {
            width: 150
            height: 150
            state: transmitterManager.transmittersState !== TransmittersState.AllOff
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            onPowerOn: Presenter.setTransmittersUtilization(10)
            onPowerOff: Presenter.setTransmittersUtilization(0)
        }

        Button {
            text: qsTr("About...")
            width: 150
            height: 50
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            onClicked: aboutPopup.open()

            AboutPopup {
                id: aboutPopup
            }
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
                id: wifi1Bar
                transmitterController: transmitterManager.getTransmitterController(TransmitterID.WiFi1)
                onClicked: wifi1Configurator.open()
                Layout.fillWidth: true

                TransmitterConfigurator {
                    id: wifi1Configurator
                    title: qsTr("Wi-Fi (2.4 - 2.5 GHz)")
                    transmitterController: wifi1Bar.transmitterController
                }
            }

            // Wi-Fi 2
            Label {
                text: qsTr("Wi-Fi (2.4 - 2.5 GHz)")
            }

            SignalBar {
                id: wifi2Bar
                transmitterController: transmitterManager.getTransmitterController(TransmitterID.WiFi2)
                onClicked: wifi2Configurator.open()
                Layout.fillWidth: true

                TransmitterConfigurator {
                    id: wifi2Configurator
                    title: qsTr("Wi-Fi (2.4 - 2.5 GHz)")
                    transmitterController: wifi2Bar.transmitterController
                }
            }

            // Wi-Fi 3
            Label {
                text: qsTr("Wi-Fi (5.5 - 5.8 GHz)")
            }

            SignalBar {
                id: wifi3Bar
                transmitterController: transmitterManager.getTransmitterController(TransmitterID.WiFi3)
                onClicked: wifi3Configurator.open()
                Layout.fillWidth: true

                TransmitterConfigurator {
                    id: wifi3Configurator
                    title: qsTr("Wi-Fi (5.5 - 5.8 GHz)")
                    transmitterController: wifi3Bar.transmitterController
                }
            }

            // GPS
            Label {
                text: qsTr("GPS (1575 MHz)")
            }

            SignalBar {
                id: gpsBar
                transmitterController: transmitterManager.getTransmitterController(TransmitterID.GPS)
                onClicked: gpsConfigurator.open()
                Layout.fillWidth: true

                TransmitterConfigurator {
                    id: gpsConfigurator
                    title: qsTr("GPS (1575 MHz)")
                    transmitterController: gpsBar.transmitterController
                }
            }

            // RC 1
            Label {
                text: qsTr("RC (868 - 912 MHz)")
            }

            SignalBar {
                id: rc1Bar
                transmitterController: transmitterManager.getTransmitterController(TransmitterID.RC1)
                onClicked: rc1Configurator.open()
                Layout.fillWidth: true

                TransmitterConfigurator {
                    id: rc1Configurator
                    title: qsTr("RC (868 - 912 MHz)")
                    transmitterController: rc1Bar.transmitterController
                }
            }

            // RC 2
            Label {
                text: qsTr("RC (433 - 434 MHz)")
            }

            SignalBar {
                id: rc2Bar
                transmitterController: transmitterManager.getTransmitterController(TransmitterID.RC2)
                onClicked: rc2Configurator.open()
                Layout.fillWidth: true

                TransmitterConfigurator {
                    id: rc2Configurator
                    title: qsTr("RC (433 - 434 MHz)")
                    transmitterController: rc2Bar.transmitterController
                }
            }
        }
    }
}
