import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Universal 2.2

Item {
    property int value: 0

    id: control
    implicitHeight: 50
    implicitWidth: 100

    // Bar.
    ProgressBar {
        id: bar
        from: 0
        to: 100
        value: parent.value

        anchors.fill: parent

        background: Rectangle {
            color: parent.value ? "#333333" : Universal.color(Universal.Red)
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
        text: parent.value.toString() + "%"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }
}
