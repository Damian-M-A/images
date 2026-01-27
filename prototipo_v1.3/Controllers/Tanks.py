from PySide6.QtCore import QObject, Property, Signal, Slot, QTimer, QDateTime
import random

class TanksClass(QObject):
    tanksChanged = Signal()
    soh2Changed = Signal()
    socChanged = Signal()

    def __init__(self, parent = None):
        super().__init__(parent)
        self._tanksLevel = [
        { "text": "Tanque 1","value": 0},
        { "text": "Tanque 2","value": 0},
        { "text": "Tanque 3","value": 0},
        { "text": "Tanque 4","value": 0}

        ]
        self._soc = 0.0
        self._soh2 = 0.0
        self._timer = QTimer()
        self._timer.setInterval(1000)
        self._timer.timeout.connect(self._updateData)
        self._timer.start()
        self._updateData()

    def _updateData(self):
        
        self._soc = random.uniform(0.0,1.0)
        self.socChanged.emit()
        
        self._soh2 = random.uniform(0.0,1.0)
        self.soh2Changed.emit()
        
        for i in range(len(self._tanksLevel)):
            self._tanksLevel[i]["value"] = random.uniform(0.0, 1.0)
        self.tanksChanged.emit()

    def getSoc(self):
        return self._soc
    @Slot(float)
    def setSoc(self,value):
        if self._soc != value:
            self._soc = value
            self.socChanged.emit()
    @Slot(float)
    def setSho2(self,value):
        if self._soh2 != value:
            self._soh2 = value
            self.soh2Changed.emit()           
    def getSho2(self):
        return self._soh2

    @Property("QVariant", notify = tanksChanged)
    def getTanks(self):
        return self._tanksLevel

    Soc = Property (float, getSoc, notify = socChanged)
    Sho2 = Property (float, getSho2, notify = soh2Changed)

                  
