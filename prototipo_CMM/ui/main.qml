import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15

import "components"
import "StartWindow"
import "LoginView"
import "DriverViews"
import "AdminViews"
import "FuelView"
Window {
    id: root
    width: 1024
    height: 600
    visible: true
    title: qsTr("Prototipo para RPI")
    color: "black"

    StackView {
        id: stack
        anchors.fill: parent
        initialItem: startWindow
    }

    Component {
        id: startWindow
        Startwindow {}
    }

    
    Component {
        id: template

        Item {
            anchors.fill: parent

            
            Rectangle {
                id: topView
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }
                height: parent.height / 9

                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#111111" }
                    GradientStop { position: 0.5; color: "#0a0a0a" }
                    GradientStop { position: 1.0; color: "#000000" }
                }

                Rectangle {
                    id: display
                    anchors.centerIn: parent
                    width: parent.width / 2
                    height: parent.height * 0.9
                    radius: 8
                    border.color: "#00cc88"
                    border.width: 2

                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "#002211" }
                        GradientStop { position: 0.5; color: "#001a0a" }
                        GradientStop { position: 1.0; color: "#001100" }
                    }

                    Rectangle {
                        anchors.fill: parent
                        radius: parent.radius
                        gradient: Gradient {
                            GradientStop { position: 0.0; color: "#30ffffff" }
                            GradientStop { position: 1.0; color: "#08ffffff" }
                        }
                    }

                    DigitalClock {
                        anchors.centerIn: parent
                        hora: time.CurrentTime
                    }
                }
            }

            
            Rectangle {
                id: centerTemplate
                anchors {
                    top: topView.bottom
                    bottom: bottomView.top
                    left: parent.left
                    right: parent.right
                }
                color: "transparent"

                StackView {
                    id: stack2
                    anchors.fill: parent
                    initialItem: loginView

                    /* Animaciones correctas */
                    pushEnter: Transition {
                        PropertyAnimation {
                            property: "opacity"
                            from: 0
                            to: 1
                            duration: 200
                        }
                    }

                    pushExit: Transition {
                        PropertyAnimation {
                            property: "opacity"
                            from: 1
                            to: 0
                            duration: 200
                        }
                    }

                    popEnter: Transition {
                        PropertyAnimation {
                            property: "opacity"
                            from: 0
                            to: 1
                            duration: 200
                        }
                    }

                    popExit: Transition {
                        PropertyAnimation {
                            property: "opacity"
                            from: 1
                            to: 0
                            duration: 200
                        }
                    }
                }

                Component {
                    id: loginView
                     //Loginview {}

                     // los comentados son para bypass sin pasar
                     // por el lector de tarjetas
                     // Adminhome {}
                     //DriverHybrid {}
                    Drivermain {}
                }

                Component {
                    id: driver
                    Drivermain {}
                }

                Component {
                    id:admin
                    Adminhome {}
                }

                Component {
                    id: hibridMode
                    DriverHybrid {}
                }
                Component {
                    id:fuelView
                    Fuelview {}
                }
            }

            
            Rectangle {
                id: bottomView
                anchors {
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }
                height: parent.height / 9
                radius: 8

                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#002211" }
                    GradientStop { position: 0.5; color: "#001a0a" }
                    GradientStop { position: 1.0; color: "#001100" }
                }

                AlertsBar {
                    anchors.fill: parent
                    alertas: alerts.getAlerts
                }
            }
        }
    }

    
    Timer {
        interval: 3000
        running: true
        repeat: false
        onTriggered: stack.replace(template)
    }
}
