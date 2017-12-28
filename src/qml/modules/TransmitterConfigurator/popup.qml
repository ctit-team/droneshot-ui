import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import Hardware.Transmitter 1.0
import PowerSwitch 1.0
import StandardPopup 1.0

StandardPopup {
    property TransmitterController transmitterController

    RowLayout {
        anchors.fill: parent

        // Decrease Button.
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Button {
                text: "-"
                width: 100
                height: 100
                onClicked: transmitterController.utilization -= 10
                font.pointSize: 30
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        // Toggle button + strength indicator.
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            PowerSwitch {
                state: transmitterController.utilization !== 0
                width: 250
                height: 250
                onPowerOn: transmitterController.utilization = 100
                onPowerOff: transmitterController.utilization = 0
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 30
            }

            Label {
                text: transmitterController.utilization.toString() + "%"
                font.pointSize: 30
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        // Increase Button.
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Button {
                text: "+"
                width: 100
                height: 100
                onClicked: transmitterController.utilization += 10
                font.pointSize: 30
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}
