import QtQuick 2.0
import QtQuick.Controls 2.3
import QtQuick.Controls.Universal 2.3

Control {
    id: root
    onStateChanged: update()

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
                return button.down ? Universal.color(Universal.Green) : Universal.color(Universal.Emerald)
            })
        } else {
            button.text = qsTr("OFF")
            button.background.color = Qt.binding(function () {
                return button.down ? button.Universal.baseMediumLowColor : button.Universal.baseLowColor
            })
        }
    }
}
