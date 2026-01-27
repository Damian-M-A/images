import QtQuick 2.15
    import QtQuick.Controls 2.15

Rectangle {

    id: loginWindow
    anchors.fill: parent
    color: "black"

    Rectangle {
        id: rfidArea
        width: parent.width * 3 / 8
        height: parent.height / 2
        radius: 8
        anchors.centerIn: parent

        gradient: Gradient {
            GradientStop { position: 0.0; color: "#043f3c" }
            GradientStop { position: 0.5; color: "#087c77" }
            GradientStop { position: 1.0; color: "#0fb9b2" }
        }

        Text {
            id: rfidText
            anchors.centerIn: parent
            color: "#00ffaa"
            font {
                family: "Courier New"
                pixelSize: 32
                bold: true
                letterSpacing: 3
            }
            text: "Acerca Tarjeta"
        }
    }

    // Esto luego será reemplazado por el lector RFID real
    Connections{
        target: rfid
        function onUidChanged(){
            if(rfid.uid === "129041009647"){
                stack2.push(driver)
            }
            if(rfid.uid === "751119518774"){
                stack2.push(admin)
            }
        }
    }
}

