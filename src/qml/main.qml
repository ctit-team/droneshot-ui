import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

ApplicationWindow {
    visible: true
    width: 1024
    height: 600
    title: qsTr("Drone Shooter")

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
            text: qsTr("off all")
            width: 150
            height: 150
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Button {
            text: qsTr("Legal Notices")
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
        }
    }

    // Right frame.
    Frame {
        anchors.left: leftFrame.right
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        GridLayout {
            columns: 3
            anchors.fill: parent

            // Wi-Fi 1
            Label {
                text: qsTr("Wi-Fi")
            }

            ProgressBar {
                Layout.fillWidth: true
            }

            Label {
                text: qsTr("2.4 - 2.5")
            }

            // Wi-Fi 2
            Label {
                text: qsTr("Wi-Fi")
            }

            ProgressBar {
                Layout.fillWidth: true
            }

            Label {
                text: qsTr("2.4 - 2.5")
            }

            // Wi-Fi 3
            Label {
                text: qsTr("Wi-Fi")
            }

            ProgressBar {
                Layout.fillWidth: true
            }

            Label {
                text: qsTr("5.5 - 5.8")
            }

            // GPS
            Label {
                text: qsTr("GPS")
            }

            ProgressBar {
                Layout.fillWidth: true
            }

            Label {
                text: qsTr("1575")
            }

            // RC 1
            Label {
                text: qsTr("RC")
            }

            ProgressBar {
                Layout.fillWidth: true
            }

            Label {
                text: qsTr("868 - 912")
            }

            // RC 2
            Label {
                text: qsTr("RC")
            }

            ProgressBar {
                Layout.fillWidth: true
            }

            Label {
                text: qsTr("433 - 434")
            }
        }
    }
}
