import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Controls.Universal 2.2

import Hardware.Transmitter 1.0

Item {
    property TransmitterController transmitterController

    signal clicked;

    id: control
    implicitHeight: 50
    implicitWidth: 100

    // Bar.
    ProgressBar {
        id: bar
        from: 0
        to: 100
        value: transmitterController.utilization
        anchors.fill: parent

        background: Rectangle {
            color: transmitterController.utilization ? "#333333" : Universal.color(Universal.Red)
        }

        contentItem: Item {
            Rectangle {
                width: bar.visualPosition * parent.width
                height: parent.height
                color: Universal.color(Universal.Emerald)
            }
        }
    }

    // Percentage text.
    Label {
        id: percentText
        text: transmitterController.utilization.toString() + "%"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }

    // Mouse Handler.
    MouseArea {
        anchors.fill: parent
        onClicked: control.clicked()
    }
}
