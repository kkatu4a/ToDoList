import QtQuick 2.15
import QtQuick.Controls 2.15

Text {
    property string format: "dd.MM.yyyy"
    property bool autoUpdate: true

    Timer {
        interval: 60000
        running: parent.autoUpdate
        repeat: true
        onTriggered: parent.updateDate()
    }

    function updateDate() {
        var date = new Date()
        text = date.toLocaleDateString(Qt.locale(), format)
    }

    Component.onCompleted: updateDate()
}
