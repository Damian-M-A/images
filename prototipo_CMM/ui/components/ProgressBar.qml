import QtQuick
import QtQuick.Controls

Item{
    id: root
    property double maximum: 1
    property double value : 0
    property double minimum : 0
    property string title : ""
    property string type: ""
    property int margins: 0
    property real rvalue : 0.5
    property real gvalue : 0.6
    property bool textVisible : false
    Rectangle{
        id: progressbarContent
        anchors{
        
            top: parent.top
            right:parent.right
            left: parent.left
            bottom: parent.bottom
            
        }
        color: "transparent"
        Column{
            anchors.fill: parent
            anchors.topMargin: root.margins
            spacing: 30

            Text{
                id: textTitle
                anchors.horizontalCenter: parent.horizontalCenter
                text: root.title
                font.bold: true
                font.pixelSize: 20
                color: "white"
                
            }
            Rectangle{
                id: bar
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width / 1.2
                height: parent.height / 10
                border.width: 0.05 * height
                border.color: "white"
                radius: 0.5 * height
                color: "#1F2F2F"

                Rectangle{
                    id:fillRect
                    visible: root.value > root.minimum
                    x: 0.1 * parent.height
                    y: 0.1 * parent.height
                    width: Math.max(height,
                            Math.min((root.value - root.minimum) /
                                    (root.maximum - root.minimum) *
                                    (parent.width - 0.2 * parent.height),
                                    parent.width - 0.2 * parent.height))
                    height: 0.8 * parent.height
                    color: root.value > root.rvalue ? '#ff5252' :
                            root.value > root.grvalue ? '#fcfc03' :'#29b6f6'
                    radius: parent.radius
                }
                Text {
                    id: porcentTxt
                    visible: textVisible
                    topPadding: 40
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: root.value + " " + root.type
                    font.bold: true
                    font.pixelSize: 20
                    color: "white"
                }
                
                
            }
        }
        
    }
}
