import QtQuick
import QtQuick.Effects // Para efectos de brillo si usas Qt 6

Item {
    id: root
    property int size: 200
    property int lineWidth: 8
    property real value: 0.75 // 0.0 a 1.0
    property string label :""
    property color primaryColor: "#00F2FF"   // Cian neón
    property color secondaryColor: "#1A2634" // Fondo oscuro azulado
    property color accentColor: "#E0F7FA"

    width: size
    height: size

    // Transformamos el valor 0-1 a grados de un arco (ej. 240 grados)
    readonly property real angleOffset: 135 // Empieza abajo a la izquierda
    readonly property real maxArc: 270

    Canvas {
        id: canvas
        anchors.fill: parent
        antialiasing: true
        property real animValue: root.value

        onPaint: {
            var ctx = getContext("2d")
            ctx.reset()

            var x = width / 2
            var y = height / 2
            var radius = (size / 2) - lineWidth

            // Convertir ángulos a radianes
            var startRad = (Math.PI / 180) * angleOffset
            var fullRad = (Math.PI / 180) * (angleOffset + maxArc)
            var progressRad = (Math.PI / 180) * (angleOffset + (maxArc * animValue))

            // 1. Fondo del arco (Pista)
            ctx.beginPath()
            ctx.arc(x, y, radius, startRad, fullRad)
            ctx.lineCap = 'round'
            ctx.lineWidth = root.lineWidth
            ctx.strokeStyle = root.secondaryColor
            ctx.stroke()

            // 2. Brillo exterior (Sutil)
            ctx.beginPath()
            ctx.arc(x, y, radius, startRad, progressRad)
            ctx.lineWidth = root.lineWidth + 2
            ctx.strokeStyle = "rgba(0, 242, 255, 0.2)"
            ctx.stroke()

            // 3. Progreso Principal (Gradiente)
            var gradient = ctx.createRadialGradient(x, y, radius - 5, x, y, radius + 5)
            gradient.addColorStop(0, root.accentColor)
            gradient.addColorStop(1, root.primaryColor)

            ctx.beginPath()
            ctx.arc(x, y, radius, startRad, progressRad)
            ctx.lineWidth = root.lineWidth
            ctx.lineCap = 'round'
            ctx.strokeStyle = gradient
            ctx.stroke()
        }

        Behavior on animValue { 
            NumberAnimation { duration: 600; easing.type: Easing.OutCubic } 
        }
        
        onAnimValueChanged: requestPaint()
    }

    // --- Elementos Visuales Centrales ---
    Column {
        anchors.centerIn: parent
        spacing: -5

        Text {
            text: root.label
            anchors.horizontalCenter: parent.horizontalCenter
            color: root.primaryColor
            font.pixelSize: root.size * 0.15
            font.bold: true
        }

        Text {
            text: Math.round(root.value * 100) + "%"
            anchors.horizontalCenter: parent.horizontalCenter
            color: "white"
            font.pixelSize: root.size * 0.2
            font.family: "Monospace" // Estilo digital
        }
        
        Text {
            text: "FUEL LEVEL"
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#66FFFFFF"
            font.pixelSize: root.size * 0.06
            font.letterSpacing: 1
        }
    }
}
