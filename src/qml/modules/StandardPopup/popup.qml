import QtGraphicalEffects 1.0
import QtQuick 2.7
import QtQuick.Controls 2.2

Popup {
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

    default property alias contents: content.data
    property alias title: title.text

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

            Button {
                id: closeButton
                width: 60 + leftPadding + rightPadding
                height: 60 + topPadding + bottomPadding
                flat: true
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: control.rightPadding
                onClicked: control.close()

                contentItem: Item {
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
            }
        }

        Item {
            id: content
            width: control.availableWidth
            height: control.availableHeight - (titleBar.height - control.topPadding) - control.topPadding
            anchors.top: titleBar.bottom
            anchors.topMargin: control.topPadding
        }
    }
}
