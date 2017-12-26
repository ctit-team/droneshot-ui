import QtQuick 2.0
import QtQuick.Controls 2.3

Item {
    id: root

    property bool state: false

    signal powerOn;
    signal powerOff;

    RoundButton {
        text: root.state ? qsTr("ON") : qsTr("OFF")
        onClicked: root.state ? root.powerOff() : root.powerOn()
        anchors.fill: parent
    }
}
