import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../Components"

// en este caso como es para la informacion de los tanques no deberia
// influir la regla del codo, no asi la regla de la informacion 
//(esta expresa que el conductor no debe gastar mas de 3 seg en encontrar y entender la info que requiere)
// por ende si nos fijamos en la forma de entregar informacion de la 
// pantalla de carga, muestra los tanques de manera visual, asi como tambien
// unicamente unos testigos para la presion y la temperatura
Rectangle {
    id: tanksViews
    color: "transparent"
    
   
    readonly property color highlightColor: "#08ff93"
    readonly property int textMargin: 15

    
    Rectangle {
        id: leftContent
        anchors { 
            top: parent.top;
            left: parent.left;  
            bottom: parent.bottom 
            }
        width: parent.width * 0.5
        color: "transparent"

        Text {
            id: lbltext
            text: "ESTADO DE CARGA"
            anchors { 
                top: parent.top; 
                topMargin: 20; 
                horizontalCenter: parent.horizontalCenter 
                }
            color: "white"
            font { 
                pixelSize: 18; 
                bold: true; 
                letterSpacing: 2
                 }
        }

        GridLayout {
            anchors { 
                top: lbltext.bottom; 
                bottom: parent.bottom; 
                left: parent.left; 
                right: parent.right; 
                margins: 20 
                }
            columns: 2
            columnSpacing: 15
            rowSpacing: 15

            Repeater {
                model: tanks.getTanks
               
                ProgressBar {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 90
                    title: modelData.text 
                    type: " %"
                    value: modelData.value * 100
                    textVisible: true
                }
            }
        }
    }

   
    Rectangle {
        width: 1; height: parent.height * 0.6
        color: "#22ffffff"
        anchors.centerIn: parent
    }

  
    Rectangle {
        id: rightContent
        anchors { 
            top: parent.top; 
            left: leftContent.right; 
            right: parent.right; 
            bottom: parent.bottom 
            }
        color: "transparent"

        Text {
            id: lblmetrics
            text: "MÉTRICAS CRÍTICAS"
            anchors {
                 top: parent.top;
                 topMargin: 20; 
                 horizontalCenter: parent.horizontalCenter
                  }
            color: "white"
            font {
                 pixelSize: 18;
                  bold: true; 
                  letterSpacing: 2
                   }
        }

        GridLayout {
            anchors { 
                top: lblmetrics.bottom; 
                left: parent.left;
                right: parent.right;
                bottom: parent.bottom;
                margins: 20
                 }
            columns: 2
            columnSpacing: 12
            rowSpacing: 12

            Repeater {
                model: tanks.getTanks
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 90
                    color: "transparent" 
                    radius: 8

                    ColumnLayout {
                        anchors.centerIn: parent
                        spacing: 2

                        Text {
                            text: modelData.text
                            Layout.alignment: Qt.AlignHCenter
                            color: highlightColor
                            font { 
                                pixelSize: 12;
                                 bold: true 
                                 }
                        }

                        
                        RowLayout {
                            spacing: 15
                            
                            
                            Column {
                                Image{
                                    width:50
                                    height:50
                                    
                                    fillMode: Image.PreserveAspectFit
                                    
                                    source: modelData.temp > 79 ? assets + "red-temperature.png" :
                                            modelData.temp > 59 ? assets + "yellow-temperature.png":
                                             assets + "green-temperature.png"
                                }

                            }

                            
                            Rectangle { width: 1; height: 20; color: "#33ffffff" }

                            
                            Column {
                                Image{
                                    width:50
                                    height:50
                                    
                                    fillMode: Image.PreserveAspectFit
                                    
                                    source: modelData.press > 600 ? assets + "red-gauge.png" :
                                            modelData.temp > 379 ? assets + "yellow-gauge.png":
                                             assets + "green-gauge.png"
                                    }
                                                        
  
                            }
                        }
                        
            
                    }
                }
            }
        }
    }
}
