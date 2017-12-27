import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import File 1.0
import StandardPopup 1.0

StandardPopup {
    id: root
    title: qsTr("About Drone Shot")

    // Legal Notices.
    GroupBox {
        title: qsTr("Legal Notices")
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right:rightPane.left
        anchors.bottom: parent.bottom

        Label {
            text: File.read("qrc:/resources/legal-notices.txt")
            wrapMode: Text.WordWrap
            anchors.fill: parent
        }
    }

    // System Information.
    GroupBox {
        id: rightPane
        title: qsTr("System Information")
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        GridLayout {
            columns: 2

            // Uptime.
            Label {
                text: qsTr("Uptime:")
                font.bold: true
            }

            Label {
                text: systemInformation.uptime
            }

            // IP Address.
            Label {
                text: qsTr("IP Address:")
                font.bold: true
            }

            Label {
                text: systemInformation.ipAddress
            }

            // Total Memory.
            Label {
                text: qsTr("Total Memory:")
                font.bold: true
            }

            Label {
                text: systemInformation.totalMemory
            }

            // Available Memory.
            Label {
                text: qsTr("Available Memory:")
                font.bold: true
            }

            Label {
                text: systemInformation.availableMemory
            }

            // Total Storage.
            Label {
                text: qsTr("Total Storage:")
                font.bold: true
            }

            Label {
                text: systemInformation.totalStorage
            }

            // Available Storage.
            Label {
                text: qsTr("Available Storage:")
                font.bold: true
            }

            Label {
                text: systemInformation.availableStorage
            }
        }
    }
}
