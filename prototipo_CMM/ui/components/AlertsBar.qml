import QtQuick

Item {
    id: root
    property var alertas

    Row {
        anchors.centerIn: parent
        spacing: 40

        Repeater {
            model: alertas

            Row {
                spacing: 30
                visible: modelData.active
                opacity: modelData.active ? 1.0 : 0.0

                Rectangle {
                    width: 30
                    height: 30
                    radius: width / 2
                    color: modelData.color
                }

                Text {
                    color: "white"
                    font.pixelSize: 15
                    font.bold: true
                    text: qsTr(modelData.text)
                }
            }
        }
    }
}
