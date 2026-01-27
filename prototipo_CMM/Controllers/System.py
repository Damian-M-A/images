from PySide6.QtCore import QObject, Property, Signal, Slot, QTimer, QDateTime
import random
from testRFID import Rfid

class System(QObject):
    ##Encargado de gestionar Fecha y Hora
    DateTimeChanged = Signal() 
    ## Encargado de lanzar los testigos de las alertas
    alertStateChanged = Signal()
    ## Encargado de los cambios de SOH2
    soh2Changed = Signal()
    ## Encargado de los cambios de SOC
    socChanged = Signal()
    ## Encargado del cambio de modo (Electrico - Hibrido)
    modeChanged = Signal()
    ## Encargado de la actualizacion de KWh / Km
    kwhChanged = Signal()
    ## Encargado en la actualizacion de la autonomia 
    autonomyChanged = Signal()
    ## Encargado de actualizar en nivel de los tanques
    tanksChanged = Signal()
    ## Encargado de la actualizacion por lectura de RFID
    iudChanged = Signal()
    
    def __init__(self, parent=None):
        super().__init__(parent)
        
        ## Ordenar por seccion para no perderme / proxima actualizacion clases independientes
        ## Todo esto es solo el tiempo
        self._time = ""
        self._timerCT = QTimer()
        self._timerCT.setInterval(100)
        self._timerCT.timeout.connect(self._updateTime)
        self._timerCT.start()
        self._updateTime()
        ################################
        
        ## Todo esto es el SOH2
        ## Modo demo, en la version funcional se debe actualizar via Can 
        ## Codigo similar al que esta implementado en los testigos de alertas
        self._soh2 = 0.0
        self._sho2Timer = QTimer()
        self._sho2Timer.setInterval(800)
        self._sho2Timer.timeout.connect(self._updateSho2)
        self._sho2Timer.start()
        self._updateSho2()
        #################################
        
        ##Todo esto es del SOC (Mismo principio del SHO2)
        self._soc = 0.0
        self._socTimer = QTimer()
        self._socTimer.setInterval(800)
        self._socTimer.timeout.connect(self._updateSoc)
        self._socTimer.start()
        self._updateSoc()
        ################################
        
        ## Contador de KWh, esto y el de la autonomia esta en total modo demo
        ## no se sabe como sera aun
        self._kwh = 0.0
        self._KwhTimer = QTimer()
        self._KwhTimer.setInterval(200)
        self._KwhTimer.timeout.connect(self._updateKwh)
        self._KwhTimer.start()
        self._updateKwh()
        #################################
        
        ##Contador de Autonomia (Misma Situacion del Kwh)
        self._autonomy = 0.0
        self._AutonomyTimer = QTimer()
        self._AutonomyTimer.setInterval(3000)
        self._AutonomyTimer.timeout.connect(self._updateAutonomy)
        self._AutonomyTimer.start()
        self._updateAutonomy()
        #################################
        
        #### Contador de los tanques de H2, proxima actualizacion simulacion de obtencion de datos via can
        self._tanks = [
            {"text": "Tanque 1", "value": 0},
            {"text": "Tanque 2", "value": 0},
            {"text": "Tanque 3", "value": 0},
            {"text": "Tanque 4", "value": 0}
        ]  ## armado para que sea como lista
        self._TanksTimer = QTimer()
        self._TanksTimer.setInterval(10000)
        self._TanksTimer.timeout.connect(self._updateTanks)
        self._TanksTimer.start()
        self._updateTanks()
        ##################################
        
        ## variable para el btn
        self._btnMode = False
        ## variable para los estados
        self._alertState = [
            {"text": "Nivel de H2 bajo", "color": "#E53935", "active": True},
            {"text": "Presión de H2 alta", "color": "#00BCD4", "active": True},
            {"text": "Temperatura H2 alta", "color": "#FFC107", "active": False},
            {"text": "Fuga de H2", "color": "#FF5722", "active": False}
        ]
        ## variable para el RFID
        self._rfid = 00
        
        # Inicializar RFID si está disponible
        try:
            self.rfid_reader = Rfid()
        except:
            self.rfid_reader = None
    
    #### Time
    def _updateTime(self):
        self._time = QDateTime.currentDateTime().toString("dd-MM-yy HH:mm:ss AP")
        self.DateTimeChanged.emit()
    
    def getTime(self):
        return self._time
    
    CurrentTime = Property(str, getTime, notify=DateTimeChanged)
    
    ###################################
    ##alertas
    @Property("QVariantList", notify=alertStateChanged)
    def getAlerts(self):
        return self._alertState
    
    ##en este def es de donde se deberian obtener los datos can
    def setAlerts(self, index, state):
        if 0 <= index < len(self._alertState):
            self._alertState[index]["active"] = state
            self.alertStateChanged.emit()
    
    @Slot(int, bool)
    def updateAlert(self, index, state):
        self.setAlerts(index, state)
    
    ###################################
    ## SOH2
    def _updateSho2(self):
        # Simulación de datos para demo
        self._soh2 = random.uniform(90.0, 100.0)
        self.soh2Changed.emit()
    
    def getSoh2(self):
        return round(self._soh2, 1)
    
    Soh2 = Property(float, getSoh2, notify=soh2Changed)
    
    ###################################
    ## SOC
    def _updateSoc(self):
        # Simulación de datos para demo
        self._soc = random.uniform(20.0, 100.0)
        self.socChanged.emit()
    
    def getSoc(self):
        return round(self._soc, 1)
    
    Soc = Property(float, getSoc, notify=socChanged)
    
    ###################################
    ## Modo
    def getMode(self):
        return self._btnMode
    
    def setMode(self, value):
        if self._btnMode != value:
            self._btnMode = value
            self.modeChanged.emit()
    
    @Slot()
    def toggleMode(self):
        self.setMode(not self._btnMode)
    
    Mode = Property(bool, getMode, setMode, notify=modeChanged)
    
    ###################################
    ## KWh
    def _updateKwh(self):
        # Simulación de datos para demo
        self._kwh = random.uniform(0.5, 1.5)
        self.kwhChanged.emit()
    
    def getKwh(self):
        return round(self._kwh, 2)
    
    Kwh = Property(float, getKwh, notify=kwhChanged)
    
    ###################################
    ## Autonomía
    def _updateAutonomy(self):
        # Simulación de datos para demo
        self._autonomy = random.uniform(100.0, 500.0)
        self.autonomyChanged.emit()
    
    def getAutonomy(self):
        return round(self._autonomy, 1)
    
    Autonomy = Property(float, getAutonomy, notify=autonomyChanged)
    
    ###################################
    ## Tanques
    def _updateTanks(self):
        # Simulación de datos para demo
        for i in range(len(self._tanks)):
            self._tanks[i]["value"] = random.randint(0, 100)
        self.tanksChanged.emit()
    
    @Property("QVariantList", notify=tanksChanged)
    def getTanks(self):
        return self._tanks
    
    @Slot()
    def updateTanks(self):
        self._updateTanks()
    
    ###################################
    ## RFID
    def getRfid(self):
        return self._rfid
    
    def setRfid(self, value):
        if self._rfid != value:
            self._rfid = value
            self.iudChanged.emit()
    
    @Slot()
    def readRfid(self):
        if self.rfid_reader:
            try:
                rfid_data = self.rfid_reader.read()
                self.setRfid(rfid_data)
            except Exception as e:
                print(f"Error leyendo RFID: {e}")
        else:
            # Simulación para demo
            self.setRfid(random.randint(10000, 99999))
    
    rfid = Property(str, getRfid, setRfid, notify=iudChanged)
