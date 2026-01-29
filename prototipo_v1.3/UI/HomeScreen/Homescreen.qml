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
            width:79
            height:79
            radius:20
            anchors{
                bottom:parent.bottom
                left:parent.left
                right:parent.right
                bottomMargin: 50
            }
            color:"#15FFFFFF"
            border.color:"#32CC27"
            border.width:2
            Text{
                id: lblchange
                anchors.centerIn:parent
                text:"CAMBIAR A "  + (!mode.Mode ? "HIBRIDO" :  "ELECTRICO")
                color: "#32cc27"
                font.pixelSize:14
                font.letterSpacing:1
                font.bold:true
                
            }
            MouseArea{
                anchors.fill:parent
                onClicked:{
                    mode.updateMode()
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
            id:imageContent
            anchors{
                top:parent.top
                left:parent.left
                right:parent.right
                topMargin: 30
            }
            height:parent.height / 3
            color:"transparent"

            Image{
                id:electricImage
                width:150
                height:150
                anchors.centerIn:parent
                fillMode:Image.PreserveAspectFit
                source: mode.Mode ? assets + "h2car.png" : assets + "elecar.png"
            }

        }
        Rectangle{
            id:rectAutonomy
            visible: mode.Mode ? true : false
            anchors{
                top:imageContent.bottom
                left:parent.left
                right:parent.right
                
                bottom:alert.top
                
            }
            color:"transparent"
            ProgressBar{
                id:autonomy
                anchors.centerIn:parent
                width:parent.height *0.9
                height:parent.height
                title: "Autonomia"
                value: 200
                maximum:600
                
            }
            
        }
        Rectangle{
            id:alert
            anchors{
                bottom:parent.bottom
                left:parent.left
                right:parent.right
                
            }
            height: parent.height / 4
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
                        border.color:modelData.active ? "white" : "transparent"
                        border.width:2
                        
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

                        }
                        MouseArea{
                            anchors.fill:parent
                            onClicked:{
                                popups.open()
                            }
                        PopupWindow{
                        id:popups
                            title: "Advertencia"
                            body: "Se a detectado " + modelData.text
                            anchors.centerIn:Overlay.overlay

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

