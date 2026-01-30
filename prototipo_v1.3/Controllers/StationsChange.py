from PySide6.QtCore import QObject, QThread, Property, Signal, Slot, QTimer
from classes.StationClass import ClassFuel

class Worker(QObject):
    data_send = Signal(list)
    
    def __init__(self):
        super().__init__()
        self.stations = ClassFuel()
        self.timer = QTimer(self)
        self.timer.setInterval(120000)
        self.timer.timeout.connect(self.updatesFuels)
        self.data_buffer = (-33.3163806, -70.7552783)  # Valores por defecto

    @Slot()
    def start(self):
        self.timer.start()
        self.updatesFuels()  # Actualizar inmediatamente

    @Slot(float, float)
    def set_data(self, lat, lon):
        self.data_buffer = (lat, lon)
        self.updatesFuels()

    @Slot()
    def updatesFuels(self):
        latitud, longitud = self.data_buffer
        data = self.stations.getStations(latitud, longitud)
        self.data_send.emit(data if data else [])

class StationsMaps(QObject):
    infoChanged = Signal()
    
    def __init__(self):
        super().__init__()
        self._data = []
        self.thread = QThread()
        self.worker = Worker()
        self.worker.moveToThread(self.thread)
        
        self.thread.started.connect(self.worker.start)
        self.worker.data_send.connect(self.getdata)
        
        self.thread.start()

    def update_maps(self, lat, lon):
        self.worker.set_data(lat, lon)
    
    @Slot(list)
    def getdata(self, data):
        self._data = data
        self.infoChanged.emit()

    @Property(list, notify=infoChanged)
    def data(self):
        return self._data
