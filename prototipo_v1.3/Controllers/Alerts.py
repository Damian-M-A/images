from PySide6.QtCore import QObject, Property, Signal, Slot, QTimer, QDateTime

class AlertClass(QObject):
    alertStateChanged = Signal()
    def __init__(self, parent = None):
        super().__init__(parent)
        self._alertState = [
                {"text": "Nivel de H2 bajo", "image": "fuel-station.png", "active": True},
                {"text": "Presión de H2 alta", "image": "gauge.png", "active": True},
                {"text": "Temperatura H2 alta", "image": "temperature-control.png", "active": False},
                {"text": "Fuga de H2", "image": "caution.png", "active": False}
            ]
    @Property(list, notify = alertStateChanged)
    def getAlerts(self):
        
        return self._alertState
    def setAlerts(self, index , state):
        if 0 <= index < len(self._alertState):
            self._alertState[index]["active"] = state
            self.alertStateChanged.emit()
    @Slot(int,bool)
    def updateAlert(self,index,state):
        self.setAlerts(index,state)
        
