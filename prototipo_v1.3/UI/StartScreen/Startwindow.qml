import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: startWindow
//    anchors.fill: parent
    color: "black"

    // Efecto de fondo dinámico (como luces de neón)
    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#000000" }
            GradientStop { position: 0.5; color: "#0a0a0a" }
            GradientStop { position: 1.0; color: "#000000" }
        }
        opacity: 0.3
    }

    // Logo principal con animación
    Image {
        id: fidelli
        width: 210
        height: 240
        anchors.centerIn: parent
        scale: 0.1 // Comienza muy pequeño
        transformOrigin: Item.Center
        fillMode: Image.PreserveAspectFit
        source: "https://static1.squarespace.com/static/68894be54c1349234a8208f6/t/688be9cd4ff4d815e355d0e1/1756924841262/"
        opacity: 0 // Comienza invisible

        // Efecto de brillo alrededor del logo
        Rectangle {
            id: glowEffect
            anchors.fill: parent
            radius: width / 2
            color: "transparent"
            border.color: "#087c77"
            border.width: 3
            opacity: 0
            scale: 1.1

            SequentialAnimation on opacity {
                running: true
                loops: Animation.Infinite
                PauseAnimation { duration: 1500 }
                NumberAnimation {
                    to: 0.5
                    duration: 800
                    easing.type: Easing.InOutQuad
                }
                NumberAnimation {
                    to: 0
                    duration: 800
                    easing.type: Easing.InOutQuad
                }
            }
        }

        // Animación secuencial de encendido
        SequentialAnimation {
            id: startupAnimation
            running: true

            // 1. Fade in inicial (como pre-encendido)
            ParallelAnimation {
                NumberAnimation {
                    target: fidelli
                    property: "opacity"
                    to: 0.3
                    duration: 600
                    easing.type: Easing.InOutQuad
                }
                NumberAnimation {
                    target: fidelli
                    property: "scale"
                    to: 0.5
                    duration: 600
                    easing.type: Easing.InOutBack
                }
            }

            PauseAnimation { duration: 300 }

            // 2. Pulso de energía (como chispa de encendido)
            ParallelAnimation {
                NumberAnimation {
                    target: fidelli
                    property: "opacity"
                    to: 0.8
                    duration: 200
                    easing.type: Easing.InCubic
                }
                NumberAnimation {
                    target: fidelli
                    property: "scale"
                    to: 0.7
                    duration: 200
                    easing.type: Easing.InCubic
                }
            }

            NumberAnimation {
                target: fidelli
                property: "opacity"
                to: 0.4
                duration: 150
                easing.type: Easing.OutCubic
            }

            PauseAnimation { duration: 200 }

            // 3. Encendido completo (arranque del motor)
            ParallelAnimation {
                NumberAnimation {
                    target: fidelli
                    property: "opacity"
                    to: 1.0
                    duration: 800
                    easing.type: Easing.OutBack
                }
                NumberAnimation {
                    target: fidelli
                    property: "scale"
                    to: 2.0
                    duration: 800
                    easing.type: Easing.OutBack
                }

                // Efecto de vibración sutil (como vibración del motor)
                SequentialAnimation {
                    NumberAnimation {
                        target: fidelli
                        property: "rotation"
                        to: 0.5
                        duration: 50
                    }
                    NumberAnimation {
                        target: fidelli
                        property: "rotation"
                        to: -0.5
                        duration: 50
                    }
                    NumberAnimation {
                        target: fidelli
                        property: "rotation"
                        to: 0
                        duration: 50
                    }
                }
            }

            // 4. Animación de respiración (idle del motor)
            onFinished: {
                idleAnimation.start()
            }
        }

        // Animación de respiración permanente (idle)
        SequentialAnimation {
            id: idleAnimation
            loops: Animation.Infinite

            ParallelAnimation {
                NumberAnimation {
                    target: fidelli
                    property: "scale"
                    to: 1.98
                    duration: 2000
                    easing.type: Easing.InOutSine
                }
                NumberAnimation {
                    target: fidelli
                    property: "opacity"
                    to: 0.95
                    duration: 2000
                    easing.type: Easing.InOutSine
                }
            }

            ParallelAnimation {
                NumberAnimation {
                    target: fidelli
                    property: "scale"
                    to: 2.02
                    duration: 2000
                    easing.type: Easing.InOutSine
                }
                NumberAnimation {
                    target: fidelli
                    property: "opacity"
                    to: 1.0
                    duration: 2000
                    easing.type: Easing.InOutSine
                }
            }
        }

        // Efecto de partículas (opcional, como chispas)
        Canvas {
            id: sparkCanvas
            anchors.fill: parent
            opacity: 0.3
            onPaint: {
                var ctx = getContext("2d")
                ctx.clearRect(0, 0, width, height)
                ctx.fillStyle = "#087c77"

                // Dibujar pequeñas partículas aleatorias
                for (var i = 0; i < 5; i++) {
                    var x = Math.random() * width
                    var y = Math.random() * height
                    var size = Math.random() * 3
                    ctx.beginPath()
                    ctx.arc(x, y, size, 0, Math.PI * 2)
                    ctx.fill()
                }
            }

            Timer {
                interval: 100
                running: true
                repeat: true
                onTriggered: sparkCanvas.requestPaint()
            }
        }
    }

}
