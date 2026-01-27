import QtQuick 
import QtQuick.Controls
import "../components"

Rectangle{
    id:fuelview
    anchors.fill : parent
    color: "transparent"

    Rectangle{
        id:toplabel
        anchors{
            top:parent.top
            left:parent.left
            right:parent.right
        }
        height: parent.height / 7
        color: "transparent"
        Text{
            id:toptext
            anchors.centerIn : parent
            text: "Temperatura de Carga"
            font.pixelSize : 30
            font.bold: true
            color: "white"
        }
    }
    Rectangle{
         id: circle
         anchors{
             top: toplabel.bottom
             left:parent.left
             right: parent.right
             topMargin: 20

         }
         height: parent.height / 2
        
         color:"transparent"
          Text{
             id:tempvalue
             anchors.centerIn: parent
             text: (fuel.temp * 100).toFixed(1) +" C"
             font.pixelSize: 25
             font.bold:true
             color:"white"
         }
         CircularProgreessBar{
             anchors.centerIn: parent
             id:tempfuel
             size: 250
             lineWidth : 12
             value : fuel.temp
             primaryColor: value > 0.5 ? "red" : "green"
             
             
         }
        
     
    }
    Rectangle{
        id:btnback
        anchors {
            top: circle.bottom
            left: parent.left
            right: parent.right
            topMargin: 20
        }
        width: parent.width /6
        height: parent.height /6
        color: "transparent"
        Rectangle{
            anchors.centerIn: parent
            width: parent.width /4
            height: parent.height /2
            color: "#139B4E"
            radius: 8
            Text{
                id: fuelTxt
                anchors.centerIn:parent
                text: "Volver"
                font.pixelSize: 17
                font.bold: true
                color: "white"
                }
            MouseArea{
                 id:changefuel
                 anchors.fill:parent
                 onClicked:{
                     fuel.Mode =!fuel.Mode
                     stack2.push(driver)
                    }
            
          }       }
    }
 
    
}
