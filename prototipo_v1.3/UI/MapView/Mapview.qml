import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtLocation
import QtPositioning


// esto es muy complejo de incorporar al 100%, por el momento es lo mejor que se puede conseguir
// falta corroborar su funcionamiento una vez que se pueda tener acceso al gps del  dispositivo
// esto significa que si la pantalla se mueve el mapa deberia cambiar sus valores
// 
// toda la logica del mapa esta encargada por el plugin usandio "osm"
// del backend solo se obtienen las ubicaciones de los puntos mas cercanos usando la api oficial del cne
// el gps se obtiene de la antena integrada a la pantalla

Rectangle {
    id: mapRoot
    anchors.fill: parent
    color: "transparent"


    property var fakeCoords: QtPositioning.coordinate(-33.3163806, 	-70.7552783) 
    property var currentInstruction: null // Guardará el giro actual

   
    Plugin {
        id: mapPlugin
        name: "osm"
    }

    RouteModel {
        id: routeModel
        plugin: mapPlugin
        query: RouteQuery { id: routeQuery }
        onStatusChanged: {
            if (status === RouteModel.Ready && count > 0) {
                var route = get(0)
                routePathLine.path = route.path
                mapview.visibleRegion = route.bounds 
                
                // Extraer la primera maniobra de la ruta
                if (route.segments && route.segments.length > 0) {
                    currentInstruction = route.segments[0]
                }
            }
        }
    }

    
    Rectangle {
        id: controlPanel
        width: parent.width * 0.28
        anchors { 
            top: parent.top; 
            left: parent.left; 
            bottom: 
            parent.bottom 
            }
        color: "transparent"
        z: 10

        ColumnLayout {
            anchors.fill: parent
            spacing: 0

            Rectangle {
                Layout.fillWidth: true; 
                height: 60; 
                color: "#252526"
                radius:8
                Text { 
                    anchors.centerIn: parent;
                    text: "Estaciones Cercanas"; 
                    color: "white";
                    font.pixelSize:20 
                    font.bold: true 
                 }
            }

            ListView {
                id: stationsList
                Layout.fillWidth: true; Layout.fillHeight: true
                model: stations.data
                clip: true; spacing: 8; topMargin: 10
                delegate: ItemDelegate {
                    width: stationsList.width - 20; height: 70
                    anchors.horizontalCenter: parent.horizontalCenter
                    
                    background: Rectangle {
                        color: parent.pressed ? "#333" : (parent.hovered ? "#3a3a3c" : "#2d2d30")
                        radius: 10
                    }

                    contentItem: Column {
                        spacing: 2
                        Text { text: modelData.direccion || "Cargador"; color: "white"; font.bold: true; elide: Text.ElideRight; width: parent.width }
                        Text { text: modelData.distribuidor || "Operador"; color: "#aaa"; font.pixelSize: 11 }
                        Text { text: "Click para navegar"; color: "#00c3ff"; font.pixelSize: 10; font.bold: true }
                    }

                    onClicked: {
                        var lat = parseFloat(modelData.latitud)
                        var lon = parseFloat(modelData.longitud)
                        if (!isNaN(lat) && !isNaN(lon)) {
                            routeQuery.clearWaypoints()
                            routeQuery.addWaypoint(fakeCoords) // Inicio
                            routeQuery.addWaypoint(QtPositioning.coordinate(lat, lon)) // Destino
                            routeModel.update()
                        }
                    }
                }
            }
        }
    }

    
    Rectangle {
        id: mapContainer
        anchors { 
            top: parent.top; 
            right: parent.right; 
            bottom: parent.bottom; 
            left: controlPanel.right 
            }
            radius:10

        Map {
            id: mapview
            anchors.fill: parent
            plugin: mapPlugin
            center: fakeCoords
            zoomLevel: 15
            

            // Dibujo del camino (Calles)
            MapPolyline {
                id: routePathLine
                line.width: 6; line.color: "#007AFF"; opacity: 0.8
            }

            // Marcador Vehículo (Waze Style)
            MapQuickItem {
                coordinate: fakeCoords
                anchorPoint: Qt.point(20, 20)
                sourceItem: Rectangle {
                    width: 35; height: 35; color: "black"; radius: 17.5; border.width: 3; border.color: "white"
                    Image { 
                        anchors.centerIn: parent;
                        width:20
                        height:20
                        fillMode: Image.PreserveAspectFit
                        source: assets + "h2car.png"
                        }
                }
            }

            
            MapItemView {
                model: stations.data
                delegate: MapQuickItem {
                    coordinate: QtPositioning.coordinate(modelData.latitud, modelData.longitud)
                    anchorPoint: Qt.point(12, 12)
                    sourceItem: Rectangle {
                    width: 35; height: 35; color: "black"; radius: 17.5; border.width: 3; border.color: "white" 
                    Image {
                        anchors.centerIn:parent
                        width:20
                        height:20
                        fillMode:Image.PreserveAspectFit
                        source: assets + "fuel-mode.png"
                        }
                     }
                }
            }
        }

        
        Rectangle {
            id: maneuverVisor
            anchors {bottom: parent.bottom; horizontalCenter: parent.horizontalCenter; margins: 20 }
            width: parent.width * 0.85; height: 85
            color: "black"
            radius: 18
            visible: currentInstruction !== null
            z: 100

            RowLayout {
                anchors.fill: parent; anchors.margins: 15; spacing: 15


                ColumnLayout {
                    spacing: 2
                    Text {
                        text: currentInstruction ? "En " + Math.round(currentInstruction.distance) + " metros" : ""
                        color: "#e0e0e0"; font.pixelSize: 13
                    }
                    Text {
                        text: currentInstruction ? currentInstruction.maneuver.instructionText : "Siga la ruta"
                        color: "white"; font.pixelSize: 18; font.bold: true
                        Layout.fillWidth: true; elide: Text.ElideRight
                    }
                }
            }
        }

        // Botón Re-centrar
        RoundButton {
            anchors.bottom: parent.bottom; anchors.right: parent.right; anchors.margins: 20
            text: "🎯"; font.pixelSize: 20; width: 50; height: 50
            onClicked: mapview.center = fakeCoords
        }
    }
}
