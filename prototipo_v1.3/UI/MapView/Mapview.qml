import QtQuick 
import QtQuick.Controls
import QtQuick.Layouts
import QtLocation 
import QtPositioning 

Rectangle{
	id:mapView
	color:"transparent"

	Rectangle{
		id:mapinfo
		anchors{
			top:parent.top
			right:parent.right
			bottom: parent.bottom
			
		}
		width:parent.width * 2/3
		Plugin{
			id:mapPlugin
			name: "osm"

	
			
		}

		Map{
			id:mapview
			anchors.fill: parent
			plugin: mapPlugin
			center:QtPositioning.coordinate(40.4146,-37038)
			zoomLevel:12
			//activeMapType:supportedMapTypes[4] 
		
			}
	}
}
Map {
        id: map
        anchors.fill: parent
        plugin: mapPlugin
        
        PinchHandler {
            id: pinch
            target: null
            onActiveChanged: if (active) map.startCentroid = map.toCoordinate(pinch.centroid.position)
            onScaleChanged: (delta) => map.zoomLevel += Math.log2(delta)
        }

        DragHandler {
            id: drag
            target: null
            onTranslationChanged: (delta) => map.pan(-delta.x, -delta.y)
        }
    }		
