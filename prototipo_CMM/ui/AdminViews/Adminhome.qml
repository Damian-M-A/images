import QtQuick 
import QtQuick.Controls
import "../components"
import "../TablesView"

Rectangle{
    id:adminHome
    anchors.fill :parent
    color : "transparent"
    SwipeView{
        id:view
        currentIndex:0
        anchors.fill:parent

        Item{
            id:firstPage
            Rectangle{
                anchors.fill: parent
                 color :"transparent"                
            }
            Rectangle{
                id: leftContent
                anchors{
                    top:parent.top
                    left:parent.left
                    bottom: parent.bottom
                }
                width: parent.width / 2
                color:"transparent"

                Rectangle{
                    id:lblTitle
                    anchors{
                        top:parent.top
                        right: parent.right
                        left:parent.left
                    }
                    height: parent.height / 7
                    color:"transparent"
                    Text{
                        anchors.centerIn:parent
                        text: "FC STATUS"
                        font.pixelSize: 40
                        font.bold:true
                        color:"white"
                    }
                }
                GraficTables{
                    id: fcTables
                    
                    anchors.fill: parent
                    enunciados: [{"text":"info"},{"text":"value"}]
                   contenidos: [
                                    { "info": "Stack Voltage",      "value": (Math.random() * 100).toFixed(1) + "V" },
                                    { "info": "Low Side Voltage",   "value": (Math.random() * 100).toFixed(1) +"V" },
                                    { "info": "Power",              "value": (Math.random() * 100).toFixed(1) +"kW"},
                                    { "info": "Power Max Lim",      "value": (Math.random() * 100).toFixed(1) +"kW"},
                                    { "info": "Fuel Consumpsion",   "value": (Math.random() * 100).toFixed(1) },
                                    { "info": "H2 Inlet FC Pres",   "value": (Math.random() * 100).toFixed(1) +"Kpa" },
                                    { "info": "Coolant Temp",       "value": (Math.random() * 100).toFixed(1) +"C"},
                                    { "info": "Isolation",          "value": Math.random().toFixed(1) },
                                    { "info": "Start Up",           "value": Math.random().toFixed(1) }, 
                                    { "info": "Run Cmd",            "value": Math.random().toFixed(1) }, 
                                    { "info": "Power Min Cmd",      "value": Math.random().toFixed(1) },
                                    { "info": "Shutdown",           "value": Math.random().toFixed(1) },
                                    { "info": "HVIL Reac Req",      "value": Math.random().toFixed(1) }
                                ]
                    
                }
            }
             Rectangle{
                id:rightContent
                anchors{
                    top:parent.top
                    left:leftContent.right
                    right:parent.right
                    bottom:parent.bottom
                }
                color:"transparent"
                Rectangle{
                    id:elecTop
                    anchors{
                        top: parent.top
                        left:parent.left
                        right: parent.right
                    }
                    height: parent.height / 7
                    color:"transparent"
                    Text{
                        anchors.centerIn:parent
                        text:"ELECTRIC STATUS"
                        font.pixelSize: 40
                        font.bold:true
                        color:"white"
                    }

                }
                GraficTables{
                    id: fcTables2
                    
                    anchors.fill: parent
                    enunciados: [{"text":"info"},{"text":"value"}]
                   contenidos: [
                                    { "info": "RESS SoC",      "value": (Math.random() * 100).toFixed(1) + "%" },
                                    { "info": "RESS Voltage",   "value": (Math.random() * 1000).toFixed(1) +"V" },
                                    { "info": "Cell Max Voltage",   "value": (Math.random() * 10000).toFixed(1) +"V"},
                                    { "info": "Cell Min Voltage",      "value": (Math.random() * 10000).toFixed(1) +"V"},
                                    { "info": "Cell Max Temp",   "value": (Math.random() * 100).toFixed(1) +"°C"},
                                    { "info": "Cell Min Temp",   "value": (Math.random() * 100).toFixed(1) +"°C" },
                                    { "info": "RESS Cool Temp",       "value": (Math.random() * 100).toFixed(1) +"C"},
                                    { "info": "Isolation",          "value": Math.random().toFixed(1) },
 
                                ]
                    
                }
             }
        }
        Item{
            id:secondPage
            Rectangle{
                anchors.fill:parent
                color:"green"
            }
        }
    }
    
}
