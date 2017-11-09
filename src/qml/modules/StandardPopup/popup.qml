import QtGraphicalEffects 1.0
import QtQuick 2.7
import QtQuick.Controls 2.2

Popup {
    default property alias contents: content.data

    property alias title: title.text

    id: control
    x: 0
    y: -height
    width: parent.width
    height: parent.height
    parent: ApplicationWindow.overlay
    dim: false
    modal: true
    focus: true
    clip: true
    closePolicy: Popup.CloseOnEscape

    enter: Transition {
        SmoothedAnimation { property: "y"; from: -control.height; to: 0; velocity: 1200 }
    }

    exit: Transition {
        SmoothedAnimation { property: "y"; from: 0; to: -control.height; velocity: 1200 }
    }

    Item {
        Rectangle {
            id: titleBar
            x: -control.leftPadding
            y: -control.topPadding
            width: control.width
            height: 80
            color: "#303030"

            Label {
                id: title
                font.pointSize: 40
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
