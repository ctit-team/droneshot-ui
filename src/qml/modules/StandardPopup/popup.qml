import QtGraphicalEffects 1.0
import QtQuick 2.7
import QtQuick.Controls 2.2

Popup {
    default property alias contents: content.data

    property alias title: title.text

    id: control
    width: parent.width
    height: parent.height
    parent: ApplicationWindow.overlay
    dim: false
    modal: true
    focus: true
    opacity: 0.0
    closePolicy: Popup.CloseOnEscape

    enter: Transition {
        NumberAnimation { property: "opacity"; from: 0.0; to: 1.0 }
    }

    exit: Transition {
        NumberAnimation { property: "opacity"; from: 1.0; to: 0.0 }
    }

    Item {
        Rectangle {
            id: titleBar
            x: -(control.leftPadding - 1)
            y: -(control.topPadding - 1)
            width: control.width - 2
            height: 80
            color: "#303030"

            Label {
                id: title
                font.pointSize: 30
                font.bold: true
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: control.leftPadding
            }

            Item {
                id: closeButton
                width: 60
                height: 60
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: control.rightPadding

                Image {
                    id: closeImage
                    source: "qrc:/resources/icons/multiply.svg"
                    sourceSize.width: width
                    sourceSize.height: height
                    anchors.fill: parent
                }

                ColorOverlay {
                    source: closeImage
                    color: "#FFFFFF"
                    anchors.fill: closeImage
                }
            }

            MouseArea {
                onClicked: control.close()
                anchors.fill: closeButton
            }
        }

        Item {
            id: content
            width: control.availableWidth
            height: control.availableHeight - (titleBar.height - control.topPadding)
            anchors.top: titleBar.bottom
            anchors.topMargin: control.topPadding
        }
    }
}
