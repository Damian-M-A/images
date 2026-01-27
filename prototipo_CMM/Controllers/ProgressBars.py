from PySide6.QtCore import QObject, Property, Signal, Slot, QTimer, QDateTime
import random

class BarsClass(QObject):
    kwhChanged = Signal()
    autonomyChanged = Signal()

    def __init__(self, parent = None):
        super().__init__(parent)
        self._kwh = 0.0
        self._autonomy = 0.0
        self._timer = QTimer()
        self._timer.setInterval(2000)
        self._timer.timeout.connect(self._updateData)
        self._timer.start()
        self._updateData()
            
    def _updateData(self):
    
        self._kwh = random.uniform(0.0, 1.0)
        self.kwhChanged.emit()

        self._autonomy = random.randint(0,600)
        self.autonomyChanged.emit()

    def getKwh(self):
        return self._kwh
    def getAutonomy(self):
        return self._autonomy

    Kwh = Property (float, getKwh,notify = kwhChanged)
    Autonomy = Property(float, getAutonomy, notify = autonomyChanged)
