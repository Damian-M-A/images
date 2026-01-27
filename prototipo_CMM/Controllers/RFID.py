from PySide6.QtCore import QObject,QThread, Property, Signal, Slot, QTimer, QDateTime
from testRFID import Rfid

class Worker(QObject):
    uidDetect= Signal(str)

    def __init__(self):
        super().__init__()
        self.reader = Rfid()
        self.reader.inicializarModulo()

        self.timer = QTimer(self)
        self.timer.setInterval(500)
        self.timer.timeout.connect(self.read_rfid)
    @Slot()
    def start(self):
        self.timer.start()
    @Slot()
    def read_rfid(self):
        try:
            uid = self.reader.lecturaTarjeta()
            if uid:
                self.uidDetect.emit(str(uid))
        except Exception as e:
            print("error RFID")

class RfidClass(QObject):
    uidChanged = Signal()
    def __init__(self):
        super().__init__()
        self._uid = "111"
        self.thread = QThread()
        self.worker = Worker()
        self.worker.moveToThread(self.thread)
        self.worker.uidDetect.connect(self.on_uid_detected)
        self.thread.started.connect(self.worker.start)
        self.thread.start()
    @Slot(str)
    def on_uid_detected(self, uid):
        if self._uid !=uid:
            self._uid = uid
            self.uidChanged.emit()
    def getUid(self):
        return self._uid
    uid = Property(str, getUid, notify=uidChanged)
