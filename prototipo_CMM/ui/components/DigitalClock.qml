
import QtQuick

Item{
    id: root
    property string hora: "test"    
    
 
    Text {
        id: timeText
        anchors.centerIn: parent
        color: "#00ffaa"
        font {
            family: "Courier New"
            pixelSize: 32
            bold: true
            letterSpacing: 3
            }
        text: root.hora
    }
        
}

