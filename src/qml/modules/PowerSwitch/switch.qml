import QtQuick 2.0
import QtQuick.Controls 2.3
import QtQuick.Controls.Universal 2.2

Item {
    id: root
    onStateChanged: update()

    property color powerOffActiveColor: "#666666"
    property color powerOffColor: "#333333"
    property color powerOnActiveColor: Universal.color(Universal.Green)
    property color powerOnColor: Universal.color(Universal.Emerald)
    property bool state: false

    signal powerOff;
    signal powerOn;

    Component.onCompleted: update()

    RoundButton {
        id: button
        onClicked: root.state ? root.powerOff() : root.powerOn()
        anchors.fill: parent
    }

    function update() {
        if (state) {
            button.text = qsTr("ON")
            button.background.color = Qt.binding(function () {
                return button.down ? powerOnActiveColor : powerOnColor
            })
        } else {
            button.text = qsTr("OFF")
            button.background.color = Qt.binding(function () {
                return button.down ? powerOffActiveColor : powerOffColor
            })
        }
    }
}
