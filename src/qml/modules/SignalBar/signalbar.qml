import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Controls.Universal 2.2

import Hardware.Transmitter 1.0

Item {
    // Properties.
    property color activeBackgroundColor: "#666666"
    property color activeForegroundColor: Universal.color(Universal.Green)
    property color backgroundColor: "#333333"
    property color foregroundColor: Universal.color(Universal.Emerald)
    property TransmitterController transmitterController

    // Signals.
    signal clicked;

    // Defaults.
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
            id: background
            color: control.backgroundColor
        }

        contentItem: Item {
            Rectangle {
                id: progress
                width: bar.visualPosition * parent.width
                height: parent.height
                color: control.foregroundColor
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

        onPressed: {
            background.color = control.activeBackgroundColor
            progress.color = control.activeForegroundColor
        }

        onReleased: {
            background.color = control.backgroundColor
            progress.color = control.foregroundColor
        }
    }
}
