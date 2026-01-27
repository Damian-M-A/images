import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root
    property double maximum: 100
    property double value: 80
    property double minimum: 0
    property string title: "AUTONOMÍA"
    property string type: " km"
    property bool textVisible: true
    
    width: 350
    height: 100

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        // Título superior
        Text {
            text: root.title
            Layout.alignment: Qt.AlignCenter
            font.pixelSize: 14
            font.letterSpacing: 1
            font.bold: true
            color: "#A0A0A0"
        }

        RowLayout {
            spacing: 0
            Layout.fillWidth: true

            // Cuerpo de la pila
            Rectangle {
                id: batteryBody
                Layout.fillWidth: true
                Layout.preferredHeight: 45
                color: "#15FFFFFF" // Fondo semi-transparente
                border.color: "white"
                border.width: 2
                radius: 6

                // Relleno de energía
                Rectangle {
                    id: fillRect
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.margins: 4
                    
                    // Cálculo de ancho basado en valor
                    width: Math.max(0, (parent.width - 8) * (root.value / root.maximum))
                    
                    radius: 3
                    
                    // Degradado dinámico
                    gradient: Gradient {
                        orientation: Gradient.Horizontal
                        GradientStop { position: 0.0; color: root.value < 20 ? "#FF2E63" : "#08ff93" }
                        GradientStop { position: 1.0; color: root.value < 20 ? "#FF5555" : "#00F2FF" }
                    }

                    // Líneas de segmentación
                    Row {
                        anchors.fill: parent
                        Repeater {
                            model: 10 // 10 segmentos de autonomía
                            Rectangle {
                                width: 2
                                height: parent.height
                                color: "#1A1A1A"
                                opacity: 0.5
                                x: (index + 1) * (batteryBody.width / 10)
                                visible: (index + 1) < 10
                            }
                        }
                    }
                }
            }

            // Borne de la pila (extremo derecho)
            Rectangle {
                width: 8
                height: 20
                color: "white"
                radius: 2
                Layout.alignment: Qt.AlignVCenter
            }
        }

        // Indicador numérico
        Text {
            id: porcentTxt
            visible: root.textVisible
            Layout.alignment: Qt.AlignCenter
            text: root.value.toFixed(0) + root.type
            font.pixelSize: 16
            font.family: "Monospace"
            font.bold: true
            color: root.value < 20 ? "#FF2E63" : "white"
        }
    }
}
