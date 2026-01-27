import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: root
    property var enunciados: []        // Array de objetos: [{text: "Columna 1"}, {text: "Columna 2"}, ...]
    property var contenidos: []        // Array de objetos: [{col1: "valor", col2: "valor"}, ...]
    
    // Propiedad computada para obtener las claves del primer objeto (si existe)
    property var columnKeys: contenidos.length > 0 ? Object.keys(contenidos[0]) : []
    
    Rectangle {
        anchors.fill: parent
        color: "transparent"
        
        Rectangle {
            id: tablePanel
            width: parent.width * 0.9
            height: parent.height * 0.8
            anchors.centerIn: parent
            radius: 10
            color: "transparent"
            
            
            
            Column {
                anchors.fill: parent
                anchors.margins: 12
                spacing: 8
                
                // ENCABEZADO DE LA TABLA - Dinámico
                Rectangle {
                    width: parent.width
                    height: 42
                    radius: 6
                    color: "#1A8C82"
                    
                    Row {
                        anchors.fill: parent
                        spacing: 1
                        
                        // Muestra todos los encabezados definidos en 'enunciados'
                        Repeater {
                            model: root.enunciados
                            
                            delegate: Rectangle {
                                width: (parent.width - (root.enunciados.length - 1)) / root.enunciados.length
                                height: parent.height
                                color: "transparent"
                                
                                Text {
                                    anchors.centerIn: parent
                                    text: modelData.text || ""
                                    color: "white"
                                    font.bold: true
                                    font.pixelSize: 16
                                    elide: Text.ElideRight
                                }
                            }
                        }
                    }
                }
                
                // CONTENIDO DE LA TABLA - Completamente dinámico
                ListView {
                    id: tableView
                    width: parent.width
                    height: parent.height - 50
                    model: root.contenidos
                    clip: true
                    boundsBehavior: Flickable.StopAtBounds
                    
                    // Delegate para cada fila
                    delegate: Rectangle {
                        width: tableView.width
                        height: 60
                        property int rowIndex: index
                        color: index % 2 === 0 ? "#f0f0f0" : "#e0e0e0"
                        border.color: "#dddddd"
                        
                        Row {
                            anchors.fill: parent
                            spacing: 1
                            
                            // Muestra todas las columnas dinámicamente
                            // Usa 'enunciados' para saber cuántas columnas mostrar
                            Repeater {
                                model: root.enunciados
                                
                                delegate: Rectangle {
                                    width: (parent.width - (root.enunciados.length - 1)) / root.enunciados.length
                                    height: parent.height
                                    color: "transparent"
                                    
                                    Text {
                                        anchors.fill: parent
                                        anchors.margins: 5
                                        text: obtenerValorCelda(modelData.text, rowIndex)
                                        color: determinarColor(modelData.text, rowIndex)
                                        font.pixelSize: 14
                                        font.bold: modelData.text === "Estado"
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignHCenter
                                        elide: Text.ElideRight
                                    }
                                }
                            }
                        }
                    }
                    
                    // Barra de desplazamiento
                    ScrollBar.vertical: ScrollBar {
                        policy: ScrollBar.AsNeeded
                    }
                }
            }
        }
    }
    
    // FUNCIÓN: Obtener valor para una celda específica
    function obtenerValorCelda(nombreColumna, filaIndex) {
        if (filaIndex >= contenidos.length) return "";
        
        var datosFila = contenidos[filaIndex];
        if (!datosFila) return "";
        
        // Buscar la clave que coincida con el nombre de la columna
        var claves = Object.keys(datosFila);
        
        for (var i = 0; i < claves.length; i++) {
            var clave = claves[i];
            
            // Si el nombre de la columna coincide exactamente con la clave
            if (clave === nombreColumna) {
                return formatearValor(nombreColumna, datosFila[clave]);
            }
            
            // Si es la columna "Estado", también puede venir como "Estado"
            if (nombreColumna === "Estado" && clave.includes("Estado")) {
                return formatearValor(nombreColumna, datosFila[clave]);
            }
            
            // Si es la columna de temperatura, buscar variaciones
            if (nombreColumna.includes("Temperatura") && clave.includes("Temperatura")) {
                return formatearValor(nombreColumna, datosFila[clave]);
            }
            
            // Si es la columna de tanque, buscar variaciones
            if (nombreColumna.includes("Tanque") && clave.includes("Tanque")) {
                return formatearValor(nombreColumna, datosFila[clave]);
            }
        }
        
        return "";
    }
    
    // FUNCIÓN: Formatear valores especiales
    function formatearValor(nombreColumna, valor) {
        if (valor === undefined || valor === null) return "";
        
        // Para columna "Estado": convertir números a texto
        if (nombreColumna.includes("Estado")) {
            if (valor === 1 || valor === "1" || valor === true) return "Normal";
            if (valor === 0 || valor === "0" || valor === false) return "Crítico";
            return valor.toString();
        }
        
        // Para columnas de temperatura: añadir °C si es número
        if (nombreColumna.includes("Temperatura")) {
            if (!isNaN(valor)) {
                return parseFloat(valor).toFixed(1) + "°C";
            }
        }
        
        // Para otros valores, devolver como string
        return valor.toString();
    }
    
    // FUNCIÓN: Determinar color basado en contenido
    function determinarColor(nombreColumna, filaIndex) {
        if (nombreColumna.includes("Estado")) {
            var datosFila = contenidos[filaIndex];
            if (!datosFila) return "black";
            
            var claves = Object.keys(datosFila);
            for (var i = 0; i < claves.length; i++) {
                var clave = claves[i];
                if (clave.includes("Estado")) {
                    var valor = datosFila[clave];
                    if (valor === 1 || valor === "1" || valor === true) return "green";
                    if (valor === 0 || valor === "0" || valor === false) return "red";
                }
            }
        }
        return "black";
    }
}
