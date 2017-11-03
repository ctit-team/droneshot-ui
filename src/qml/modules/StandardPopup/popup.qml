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
    dim: false
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape
    clip: true

    enter: Transition {
        SmoothedAnimation { property: "y"; from: -control.height; to: 0; velocity: 1200 }
    }

    exit: Transition {
        SmoothedAnimation { property: "y"; from: 0; to: -control.height; velocity: 1200 }
    }

    Item {
        Label {
            id: title
            anchors.bottom: closeButton.bottom
            font.pointSize: 40
            font.bold: true
        }

        Item {
            id: content
            width: control.availableWidth
            height: control.availableHeight - control.topPadding - title.height
            anchors.top: title.bottom
            anchors.topMargin: control.topPadding
        }

        RoundButton {
            id: closeButton
            x: control.availableWidth + control.rightPadding - width / 2
            y: -(height / 2 + control.topPadding)
            width: 150
            height: 150
            onClicked: control.close()
        }
    }
}
