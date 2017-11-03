import QtQuick 2.0
import QtQuick.Controls 2.2

import File 1.0
import StandardPopup 1.0

StandardPopup {
    title: qsTr("Legal Notices")

    Label {
        text: File.read("qrc:/resources/legal-notices.txt")
        wrapMode: Text.WordWrap
        anchors.fill: parent
    }
}
