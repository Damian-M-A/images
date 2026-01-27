import QtQuick 2.15

Item {
    id: root
    property var tanksLevel    // [{ text: "", value: 0.0 }, ...]
    property color tanksColor: "#00cc88"

    Rectangle {
        id: tanksbar
        anchors.fill: parent
        color: "transparent"

        Row {
            anchors.centerIn: parent
            spacing: 10

            Repeater {
                model: root.tanksLevel

                delegate: Rectangle {
                    id: tankcontent
                    width: tanksbar.width * 0.20
                    height: tanksbar.height * 0.50
                    radius: width / 5
                    color: "#1A1A1A"
                    border.color: "#333333"
                    border.width: 2

                    property real level: modelData.value

                    // Fondo interior
                    Rectangle {
                        anchors.fill: parent
                        anchors.margins: 2
                        radius: parent.radius - 2
                        color: "#0A0A0A"
                    }

                    // Nivel
                    Rectangle {
                        id: fill
                        width: parent.width - 8
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 4
                        radius: width / 5
                        color: tankcontent.level > 0.5 ? "green" : "red"

                        height: Math.max(0, (parent.height - 8) * tankcontent.level)

                        Behavior on height {
                            NumberAnimation {
                                duration: 500
                                easing.type: Easing.InOutQuad
                            }
                        }
                    }

                    // Nombre del tanque
                    Text {
                        anchors {
                            bottom: parent.top
                            bottomMargin: 5
                            horizontalCenter: parent.horizontalCenter
                        }
                        text: modelData.text
                        color: "white"
                        font.pixelSize: 14
                        font.bold: true
                    }

                    // Porcentaje
                    Text {
                        anchors {
                            top: parent.top
                            topMargin: 5
                            horizontalCenter: parent.horizontalCenter
                        }
                        text: Math.round(tankcontent.level * 100) + "%"
                        color: "white"
                        font.pixelSize: 16
                        font.bold: true
                    }
                }
            }
        }
    }
}
