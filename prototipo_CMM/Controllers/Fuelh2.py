from PySide6.QtCore import QObject, Property, Signal, Slot, QTimer, QDateTime
import random

class FuelClass(QObject):
    fuelChanged = Signal()
    modeChanged = Signal(bool)
    def __init__(self, parent = None):
        super().__init__(parent)
        self._btnMode = False
        self._temp = 0.0
        self._timer = QTimer(self)
        self._timer.setInterval(1000)
        self._timer.timeout.connect(self._updateData)
        self._timer.start()
        self._updateData()
    def _updateData(self):
        self._temp = random.uniform(0.1,1.0)
        self.fuelChanged.emit()
    def getTemp(self):
        return self._temp
    @Slot(float)
    def setTemp(self, value):
        if self._temp !=value:
            self._temp = value
            self.fuelChanged.emit()
    def getMode(self):
        return self._btnMode
    @Slot(bool)
    def setMode(self,value):
        if self._btnMode != value:
            self._btnMode = value
            self.modeChanged.emit(bool)
    Mode = Property(bool,getMode,setMode,notify = modeChanged)
    temp = Property(float,getTemp,setTemp,notify=fuelChanged)
