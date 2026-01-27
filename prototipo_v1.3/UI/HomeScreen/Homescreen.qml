import QtQuick 
import QtQuick.Controls
import QtQuick.Layouts
import "../Components"

Rectangle {
    id:electricHomeScreen
    color:"transparent"

    Rectangle{
        id:leftContent
        anchors{
            top:parent.top
            left:parent.left
            bottom:parent.bottom
        }
        width:parent.width * 1/3
        color:"transparent"
        Rectangle{
            id:btnChnge
            width:parent.width * 0.7
            height:79
            radius:20
            anchors.centerIn:parent
            color:"#15FFFFFF"
            border.color:"#32CC27"
            border.width:2
            Text{
                id: lblchange
                anchors.centerIn:parent
                text:"MODO "  + (mode.getMode ? "HIBRIDO" :  "ELECTRICO")
                color: "#32cc27"
                font.pixelSize:14
                font.letterSpacing:1
                font.bold:true
                
            }
            MouseArea{
                anchors.fill:parent
                onClicked:{
                    mode.setMode(!mode.getMode)
                }
            }
        }
    }
    Rectangle{
        id:centerContent
        anchors{
            top:parent.top
            left:leftContent.right
            right:rightContent.left
            bottom: parent.bottom
        }
        color:"transparent"
        Rectangle{
            id:textlbl
            anchors{
                top:parent.top
                left:parent.left
                right:parent.right
                }
            height:parent.width / 7
            color:"transparent"
            Text{
                text:"Modo Actual: " + (mode.getMode ? "Hibrido" :  "Electrico")
                anchors.centerIn:parent
                font.pixelSize:20
                color:"white"
                font.bold:true
                
            }
        }
        Rectangle{
            id:imageContent
            anchors{
                top:textlbl.bottom
                left:parent.left
                right:parent.right
            }
            height:parent.height / 2
            color:"transparent"

            Image{
                id:electricImage
                width:150
                height:150
                anchors.centerIn:parent
                fillMode:Image.PreserveAspectFit
                source: mode.getMode ? assets + "h2car.png" : assets + "elecar.png"
            }

        }
        Rectangle{
            id:alert
            anchors{
                top:imageContent.bottom
                left:parent.left
                right:parent.right
                bottom:parent.bottom
            }
            color:"transparent"
            GridLayout{
                id:grdalert
                anchors.fill:parent
                anchors.margins:10
                columns:2
                columnSpacing:10
                rowSpacing:10
                Repeater{
                    model:alerts.getAlerts
                    Rectangle{
                        Layout.fillWidth:true
                        Layout.fillHeight:true
                        color:"transparent"
                        radius:10
                        
                        border.width:1
                        ColumnLayout{
                            anchors.centerIn:parent
                            spacing:5
                            visible:modelData.active

                            Image{
                                Layout.preferredWidth:40
                                Layout.preferredHeight:40
                                Layout.alignment:Qt.AlignHCenter
                                fillMode:Image.PreserveAspectFit
                                source:assets + modelData.image
                            }
                            Text{
                                text:modelData.text
                                Layout.alignment:Qt.AlignHCenter
                                color:"#FF2E63"
                                font.pixelSize:11
                                font.bold:true
                            }
                        }
                    }
                }
            }

        }
        
    }
   
    Rectangle{
        id:rightContent
        anchors{    
                top:parent.top
                right:parent.right
                bottom:parent.bottom
            }
            width:parent.width * 1/3
            color:"transparent"
        Column{
            spacing:20
            anchors.centerIn:parent
            SocProgress{
                id:h2Status
                size: 180
                lineWidth : 10
                value:tanks.Sho2
                primaryColor: value > 0.35 ? "#08ff93":
                               "#FF2E63"  
                label: "SoH2"
            }
            SocProgress{
                id:socStatus
                size: 180
                lineWidth : 10
                value:tanks.Soc
                 primaryColor: value > 0.35 ? "#08ff93":
                               "#FF2E63"  
               
                label: "SoC"
            }
        }


    }
    
         
}

