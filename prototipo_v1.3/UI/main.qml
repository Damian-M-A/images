import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Window 2.15

import "Components"
import "StartScreen"
import "HomeScreen"
import "TanksView"
Window{
    id:root
    width:1024
    height:600
    visible:true
    title: qsTr("Prototipo con Buenas Practicas")
    color : "black"

    StackView {
        id:stack
        anchors.fill: parent
        initialItem : startWindow
    }
    Component{
        id: startWindow
        Startwindow {}
    }
    Component{
        id:template
        Item{
            Rectangle{
                id:lateralBar
                anchors {
                    top:parent.top
                    left:parent.left
                    bottom: parent.bottom
                    
                }
                width: parent.width / 9
                color: "transparent"
                

                Column{
                id:columnsBtn
                    anchors.centerIn:parent
                    spacing: 20


                    Rectangle{
                        id:bttwo
                        width: 76
                        height:76
                        radius: 8
                        border.color:"white"
                        border.width : 2
                        color:"transparent"
                        Image{
                            anchors.centerIn:parent
                            fillMode: Image.PreserveAspectFit
                            source: assets + "tankes.png"
                        }
                        MouseArea{
                            anchors.fill:parent
                            onClicked:{templeteStack.push(tankScreen)}
                        }
                    }
                    Rectangle{
                        id:btthree
                        width: 76
                        height:76
                        radius: 8
                        border.color:"white"
                        border.width : 2
                        color:"transparent"
                        Image{
                            anchors.centerIn:parent
                            fillMode: Image.PreserveAspectFit
                            source: assets + "home.png"
                        }
                        MouseArea{
                            anchors.fill:parent
                            onClicked:{templeteStack.push(electricHome)}
                        }
                    }
                    Rectangle{
                        id:btnfour
                        width: 76
                        height:76
                        radius: 8
                        border.color:"white"
                        border.width : 2
                        color:"transparent"
                        Image{
                            anchors.centerIn:parent
                            fillMode: Image.PreserveAspectFit
                            source: assets + "settings.png"
                        }
                    }

                    
                }
            }
            Rectangle{
                id:topBar
                anchors{
                    top:parent.top
                    left:lateralBar.right
                    right:parent.right
                }
                height:parent.height / 10
                color: "transparent"
                Rectangle{
                    id:hourContent
                    anchors{
                        right:parent.right
                        top:parent.top
                        bottom:parent.bottom
                        
                    }
                    width:parent.width / 4 
                    color:"transparent"
                    Rectangle{
                        id:daylbl
                        anchors{
                            top:parent.top
                            left:parent.left
                            right:parent.right
                            
                        }
                        height: parent.height / 2
                        color:"transparent"
                        Text{
                            text:time.CurrentDate
                            anchors.centerIn:parent
                            color:"white"
                            font.pixelSize:16
                            font.bold:true
                        }
                    }
                    Rectangle{
                        id:hourlbl
                        anchors{
                            top:daylbl.bottom
                            left:parent.left
                            right:parent.right
                            bottom:parent.bottom
                        }
                        
                        height: parent.height 
                        color:"transparent"
                        Text{
                            text:time.CurrentTime
                            anchors.centerIn:parent
                            color:"white"
                            font.pixelSize:18
                            font.bold:true
                        }
                        
                    }
                }
                Rectangle{
                    id: notificationBar
                    anchors{
                        top:parent.top
                        left:parent.left
                        bottom:parent.bottom
                        right:hourContent.left
                    }
                    color:"transparent"
                    Rectangle{
                        id: modeNotification
                        anchors{
                            top:parent.top
                            bottom: parent.bottom
                            left:parent.left
                        }
                        width: parent.width / 2
                        color: "transparent"
          
                        Text{
                            text:"Modo Actual: " + (mode.Mode ? "Hibrido" :  "Electrico")
                            anchors.centerIn:parent
                            font.pixelSize:20
                            color:"white"
                            font.bold:true
                                
                            }
                        }
                    }
        
            }
            Rectangle{
                id:templateContent
                anchors{
                    top:topBar.bottom
                    left:lateralBar.right
                    right:parent.right
                    bottom:parent.bottom
                }
                color:"transparent"
                StackView{
                    id:templeteStack
                    anchors.fill: parent
                    initialItem: electricHome
                }
                Component{
                    id:electricHome
                    Homescreen {}
                }
                Component {
                    id:tankScreen
                    Tanksview {}
                    
                }
                
            }
        }

        
    }
    Timer {
        interval: 3000
        running:true
        repeat:false
        onTriggered: stack.replace(template)
    }
}
