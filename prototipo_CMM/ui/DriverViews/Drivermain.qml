import QtQuick 
import QtQuick.Controls
import "../components"
import "../TablesView"
import "../DriverViews"
Rectangle{
    id: driverMain
    anchors.fill:parent
    color: "transparent"
    SwipeView{
        id:view
        currentIndex:0
        anchors.fill : parent
        
    
    Item{
        id:firstPage
        Rectangle{
            id: centerContent
            anchors{
                top: parent.top
                right: parent.right
                left: parent.left
                topMargin: 30
                leftMargin: 30
                rightMargin: 30
                
            }
            height : parent.height * 2/3
            color: "transparent"
            Row {
                anchors.centerIn: parent
                
                spacing: 200
                //"este es el espacio para el SOC"
                Rectangle{
                    id: leftContent
                    width:250
                    height:250
                    color: "transparent"
                    

                    CircularProgreessBar{
                        id:socBar
                        size:220
                        lineWidth : 10
                        value: info.Soc
                        primaryColor: value > 0.5 ? "green" : "red"

                        Text{
                            anchors.centerIn: parent
                            text: "SoC" + " " + Math.round(socBar.value * 100) + "%"
                            font.pixelSize: 17
                            font.bold:true
                            color: "white"
                        }
                    }
                    
                }
                // este es el espacio para el SoH2
                Rectangle{
                    id:rightContent
                    width:250
                    height:250
                    color: "transparent"
                    

                    CircularProgreessBar{
                        id:sho2Bar
                        size: 220
                        lineWidth: 10
                        value: info.Sho2
                        primaryColor: value > 0.5 ? "green" : "red"

                        Text{
                            anchors.centerIn: parent
                            text: "SoH2" + " " + Math.round(sho2Bar.value * 100) + "%"
                            font.pixelSize: 17
                            font.bold: true
                            color: "white"
                        }
                    }
                }
            }
        }
        Rectangle{
            id: modeContent
            anchors{
                top:centerContent.bottom
                left:parent.left
                right: parent.right
                bottom: parent.bottom
            }
            color: "transparent"
            
            Row {
                anchors.centerIn:parent
                spacing:40
                Rectangle{
                    id:btnhybrid    
                    height:60
                    width: 220
                    radius: 8
                    color: "#139B4E"

                    Text{
                        id: changeTxt
                        anchors.centerIn:parent
                        text: "Cambiar a Hibrido"
                        font.pixelSize: 17
                        font.bold: true
                        color: "white"
                        }
                    MouseArea{
                         id:changeArea
                         anchors.fill:parent
                         onClicked:{
                             mode.Mode =!mode.Mode
                             stack2.push(hibridMode)
                         } 
                                 
                     }
                 }
 
            
            Rectangle{
                id:btnfuel
                height: 60
                width: 220
                radius: 8
                 color: "#139B4E"

                Text{
                    id: fuelTxt
                    anchors.centerIn:parent
                    text: "Modo Carga H2"
                    font.pixelSize: 17
                    font.bold: true
                    color: "white"
                    }
                MouseArea{
                     id:changefuel
                     anchors.fill:parent
                     onClicked:{
                         fuel.Mode =!fuel.Mode
                         stack2.push(fuelView)
                        } 

                         
                    }
                 }     
            }
         }

     }
    Item{
            id:secondpage
            Rectangle{
                anchors.fill: parent
                color: "transparent"
                H2Table {}
            }
        }
    }
}
