## Este controlador se encargara unicamente de la gestion de fecha-hora
## separare funciones en distintas clases para ver si el codigo funciona de mejor manera, a su vez queda mas sencillo de actualizar

from PySide6.QtCore import QObject, Property, Signal,Slot, QTimer, QDateTime

class TimerClass(QObject):
    DateTimeChanged = Signal()
    def __init__(self, parent = None):
        super().__init__(parent)
        self._time = "00:00"
        self._timer = QTimer()
        self._timer.setInterval(1000)
        self._timer.timeout.connect(self._updateTime)
        self._timer.start()
        self._updateTime()
    def _updateTime(self):
        self._time = QDateTime.currentDateTime().toString("dd-MM-yy HH:mm:ss AP")
        self.DateTimeChanged.emit()
    def getTime(self):
        return self._time
    CurrentTime = Property(str, getTime, notify= DateTimeChanged)
