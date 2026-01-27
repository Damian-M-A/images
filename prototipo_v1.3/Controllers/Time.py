## Este controlador se encargara unicamente de la gestion de fecha-hora
## separare funciones en distintas clases para ver si el codigo funciona de mejor manera, a su vez queda mas sencillo de actualizar

from PySide6.QtCore import QObject, Property, Signal,Slot, QTimer, QDateTime

class TimerClass(QObject):
    TimeChanged = Signal()
    DateChanged = Signal()
    def __init__(self, parent = None):
        super().__init__(parent)
        self._time = "00:00"
        self._date = ""
        self._timer = QTimer()
        self._timer.setInterval(1000)
        self._timer.timeout.connect(self._updateTime)
        self._timer.start()
        self._updateTime()
    def _updateTime(self):
        self._time = QDateTime.currentDateTime().toString(" HH:mm:ss AP")
        self._date = QDateTime.currentDateTime().toString("dd/MM/yy")
        self.TimeChanged.emit()
        self.DateChanged.emit()
    def getTime(self):
        return self._time
    def getDate(self):
        return self._date
    CurrentTime = Property(str, getTime, notify= TimeChanged)
    CurrentDate = Property(str,getDate,notify=DateChanged)
