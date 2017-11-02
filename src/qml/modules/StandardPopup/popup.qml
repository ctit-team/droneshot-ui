import QtQuick 2.7
import QtQuick.Controls 2.2

Popup {
    id: control
    x: 0
    y: -height
    width: parent.width
    height: parent.height
    dim: false
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape

    enter: Transition {
        SmoothedAnimation { property: "y"; from: -control.height; to: 0; velocity: 1200 }
    }

    exit: Transition {
        SmoothedAnimation { property: "y"; from: 0; to: -control.height; velocity: 1200 }
    }

    Item {
        RoundButton {
            x: -(width / 2 + control.leftPadding)
            y: control.availableHeight - (height / 2) + control.bottomPadding
            width: 200
            height: 200
        }
    }
}
