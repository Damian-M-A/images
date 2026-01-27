from PySide6.QtCore import QObject,QThread, Property, Signal, Slot, QTimer
from BLEclass import Blueserver

class Worker(QObject):
    clientConected = Signal(bool)
    def __init__(self):
        super().__init__()
    
        self.serverBL = Blueserver()
        self.serverBL.inicializarServidor()
        self.timer = QTimer(self)
        self.timer.setInterval(1000)
        self.timer.timeout.connect(self.enviar_mensajes)
        self.datos_obt = None
        self.data_buffer = None
        
    @Slot()
    def start(self):
        self.timer.start()
    @Slot(object)
    def set_data(self,data):
        self.data_buffer = data
        
    @Slot(object)
    def enviar_mensajes(self):
        if not self.data_buffer:
            return

        temp,press,socs,fueldata =  self.data_buffer

        self.datos_obt = self.serverBL.data_requested(temp,press,socs,fueldata)
        self.serverBL.enviomensaje(self.datos_obt)

class BlueClass(QObject):
    sendChanged = Signal(object)
    def __init__(self):
        super().__init__()
        self.thread = QThread()
        self.worker = Worker()
        self.worker.moveToThread(self.thread)
        self.thread.started.connect(self.worker.start)
        self.sendChanged.connect(self.worker.set_data)
        self.thread.start()
    def update_data(self,temp,press,socs,fueldata):
        self.sendChanged.emit((temp,press,socs,fueldata))
