from PySide6.QtCore import QObject, Property, Signal, Slot

class ModeClass(QObject):
    modeChanged = Signal()

    def __init__(self, parent=None):
        super().__init__(parent)
        self._btnMode = False # False: Eléctrico, True: Híbrido

   
    def getMode(self):
        return self._btnMode

   
    def setMode(self, value):
        if self._btnMode != value:
            self._btnMode = value
            self.modeChanged.emit()
    @Slot()
    def updateMode(self):
        self.setMode(not self._btnMode)

    Mode = Property(bool, getMode, setMode, notify=modeChanged)
