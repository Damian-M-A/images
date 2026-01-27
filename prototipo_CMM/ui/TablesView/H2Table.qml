import QtQuick
import QtQuick.Controls
import "../components"

Rectangle{
    id: tablesView
    anchors.fill: parent
    color: "transparent"

    Rectangle{
        id:leftContent
        anchors{
            top: parent.top
            left: parent.left
            bottom:parent.bottom
        }
        width: parent.width / 2
        color: "transparent"

        Rectangle{
            id:tanksContent
            anchors.fill: parent
            color: "transparent"
            Text{
                id:h2Label
                anchors{
                    top: parent.top
                    horizontalCenter: parent.horizontalCenter
                    leftMargin: 30
                    topMargin: 20
                    
                }

                font.pixelSize: 25
                font.bold: true
                color: "white"
                text:"Nivel de Hidrogeno"
            }
            TanksBar{
                anchors.fill: parent
                tanksLevel: info.getTanks
            }   
        }
    }
    Rectangle{
        id:rightContent
        anchors{
            top:parent.top
            bottom:parent.bottom
            left:leftContent.right
            right:parent.right
        }
        color: "transparent"
        SwipeView{
            id:tablesSwipe
            anchors.fill: parent
            clip:true // no olvidar esto, ya que como estamos usando la mitad de la pantalla debe "esconderse" debajo de los tanques al pasar
            currentIndex: 0

            Item{
                id: tempView
                Rectangle{
                    id:tempRect
                    anchors.fill: parent
                    color: "transparent"

                    Text{
                        id:lblTemp
                        anchors{
                            top:parent.top
                            horizontalCenter: parent.horizontalCenter
                            topMargin: 20
                        }
                        text: "Temperatura de Tanques"
                        font.pixelSize: 25
                        font.bold:true
                        color: "white"
                    }
                    GraficTables{
                        id: tempTables
                        
                        anchors.fill: parent
                        enunciados: [{"text":"N° Tanque"},{"text":"Temperatura (°C)"}]
                        contenidos: [{ "N° Tanque": "Tanque 1", "Temperatura (°C)": (Math.random()*100).toFixed(1) },
                                     { "N° Tanque": "Tanque 2", "Temperatura (°C)": (Math.random()*100).toFixed(1) },
                                     { "N° Tanque": "Tanque 3", "Temperatura (°C)": (Math.random()*100).toFixed(1) },
                                     { "N° Tanque": "Tanque 4", "Temperatura (°C)": (Math.random()*100).toFixed(1) }
                                    ]
                        
                    }
                    
                }
            }
            Item{
                id:pressView
                Rectangle{
                    id:pressRect
                    anchors.fill: parent
                    color:"transparent"
                    Text{
                        id:lblPress
                        anchors{
                            top:parent.top
                            topMargin: 20
                            horizontalCenter: parent.horizontalCenter
                        }
                        text: "Presion de Tanques"
                        font.bold:true
                        font.pixelSize:25
                        color: "white"
                    }
                    GraficTables{
                        id: pressTables
                        anchors.fill: parent
                        enunciados: [{"text":"N° Tanque"},{"text":"Presion (Kpa)"}]
                        contenidos: [{ "N° Tanque": "Tanque 1", "Presion (Kpa)": (Math.random()*180).toFixed(1) },
                                     { "N° Tanque": "Tanque 2", "Presion (Kpa)": (Math.random()*180).toFixed(1) },
                                     { "N° Tanque": "Tanque 3", "Presion (Kpa)": (Math.random()*180).toFixed(1) },
                                     { "N° Tanque": "Tanque 4", "Presion (Kpa)": (Math.random()*180).toFixed(1) }
                                    ]

                    }

                }
            }
        }
        
    }
}
