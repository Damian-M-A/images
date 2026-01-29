import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
Popup{
		id:popup
		//property int extx: 100
		//property int exty:100
		property int extwidth: contentWidth + padding * 2
		property int extheight: contentHeight + padding * 2
		property string title: "test"
		property string body: "test"
		width:extwidth
		height:extheight
		modal:true
		focus:true
		
		closePolicy: Popup.CloseOnPressOutsideParent
		padding:10

		background:Rectangle{
			color: "#111f11"
			radius:10
			border.color: "white"
			border.width: 4
			layer.enabled:true
			
		}

			
		contentItem:ColumnLayout{
			spacing:12
			Text{
				text: popup.title
				Layout.fillWidth: true
				horizontalAlignment: Text.AlignHCenter
				verticalAlignment:Text.AlingVCenter
				wrapMode: Text.Wordwrap
				color: "red"
				font.pixelSize: 30
				font.weight: Font.Medium
				
			}
			Text{
				text: popup.body
				horizontalAlignment: Text.AlignHCenter
				Layout.fillWidth: true
				wrapMode: Text.Wordwrap
				color: "white"
				font.pixelSize: 20
				font.weight: Font.Medium
				
			}
			Text{
				text:"Presiona en cualquier parte para salir"
				horizontalAlignment: Text.AlignHCenter
				Layout.fillWidth: true
				wrapMode: Text.Wordwrap
				color: "white"
				font.pixelSize: 12
				font.weight: Font.Medium
				
			}
			
			
		}


		
		
		
}

