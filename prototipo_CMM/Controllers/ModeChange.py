from PySide6.QtCore import QObject, Property, Signal, Slot, QTimer, QDateTime

class ModeClass(QObject):
    ModeChanged= Signal(bool)

    def __init__(self, parent = None):
        super().__init__(parent)
        self ._btnMode = False

    def getMode(self):
        return self._btnMode
    def setMode(self,value):
        if self._btnMode != value:
            self._btnMode = value
            self.ModeChanged.emit(self._btnMode)
    Mode = Property(bool, getMode, setMode,notify = ModeChanged)
       
