import QtQuick 2.15
import QtQuick.Controls 2.15
import "../components"
import "../TablesView"

Rectangle {
    id: hibridMode
    anchors.fill: parent
    color: "transparent"

    SwipeView {
        id: hview
        currentIndex: 0
        anchors.fill: parent

        Item {
            Rectangle {
                id: contentAll
                anchors.fill: parent
                color: "transparent"

                Rectangle {
                    id: leftContents
                    anchors {
                        top: parent.top
                        left: parent.left
                        bottom: parent.bottom
                    }
                    width: parent.width / 3
                    color: "transparent"
                    Rectangle{
                        id:btnContent
                        height: parent.height / 2
                        width: parent.width / 2
                        anchors.centerIn: parent
                        color:"transparent"
                        Rectangle{
                            id:btnChange
                            width: parent.width
                            height: parent.height / 4
                            anchors.centerIn: parent
                            anchors.margins: 10
                            radius: 8
                            color:"#139B4E"
                            Text{
                                id:lblChange
                                anchors.centerIn: parent
                                text: "Cambiar a Electrico"
                                font.pixelSize: 15
                                font.bold: true
                                color: "white"
                                
                            }

                            
                        }
                        MouseArea{
                                   id:changeArea
                                   anchors.fill: parent
                                   onClicked:{
                                       mode.Mode = !mode.Mode
                                       stack2.pop()
                                   }

                               }
                    }
                }

                Rectangle {
                    id: centerContents
                    anchors {
                        top: parent.top
                        left: leftContents.right
                        right: rightContents.left
                        bottom: parent.bottom
                    }
                    color: "transparent"
                    Rectangle{
                        id:kwhContent
                        anchors{
                            top: parent.top
                            left:parent.left
                            right:parent.right
                            
                        }
                        height: parent.height / 2
                        color: "transparent"
                        ProgressBar{
                            id: kwh
                            
                            anchors.centerIn: parent
                            width: parent.width * 0.9
                            height: parent.height 
                            title: "KWh / Km"
                            value: bars.Kwh
                            margins: 30
                            
                        }
                    }
                    Rectangle{
                        id:autonomyContent
                        anchors{
                            top:kwhContent.bottom
                            left: parent.left
                            right: parent.right
                            bottom: parent.bottom
                        }
                        color:"Transparent"
                        ProgressBar{
                            id:autonomy
                            anchors.centerIn: parent
                            width: parent.width * 0.9
                            height: parent.height
                            title: "Autonomia"
                            type: "Km"
                            value: bars.Autonomy
                            textVisible: true
                            rvalue:450
                            gvalue:240
                            margins: 10
                        }
                    }
                }

                Rectangle {
                    id: rightContents
                    anchors {
                        top: parent.top
                        right: parent.right
                        bottom: parent.bottom
                    }
                    width: parent.width / 3
                    color: "transparent"
                    Rectangle{
                        id:socContent
                        anchors{
                            top:parent.top
                            left:parent.left
                            right: parent.right
                            
                        }
                        color:"transparent"
                        height: parent.height / 2
                        CircularProgreessBar{
                            id:socBar
                            anchors.centerIn:parent
                            size: 200
                            lineWidth: 10
                            value: info.Soc
                            primaryColor: value > 0.5 ? "green" : "red"
                            Text{
                                id:socText
                                anchors.centerIn: parent
                                text: "SoC"+" "+ Math.round(socBar.value *100)+"%"
                                color: "white"
                                font.pixelSize: 15
                                font.bold: true
                            }
                        }
                    }
                    Rectangle{
                        id:soh2Content
                        anchors{
                            top:socContent.bottom
                            right:parent.right
                            left: parent.left
                            bottom: parent.bottom
                        }
                        color: "transparent"
                        CircularProgreessBar{
                            id:soh2Bar
                            anchors.centerIn: parent
                            size: 200
                            value: info.Sho2
                            primaryColor: value > 0.5 ? "green" : "red"
                            lineWidth: 10
                            
                            Text{
                                id:lblsho2
                                anchors.centerIn: parent
                                text: "SoH2"+" "+Math.round(soh2Bar.value *100) +"%"
                                color: "white"
                                font.pixelSize:15
                                font.bold:true
                            }
                            
                        }
                    }
                    
                }
            }
        }

        Item {
            Rectangle {
                id: tablesViews
                anchors.fill: parent
                color: "transparent"
                H2Table {}
            }
        }
    }
}
