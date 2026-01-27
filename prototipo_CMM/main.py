import sys
import threading
from pathlib import Path
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine

from testRFID import Rfid
from Controllers import Time, System, Alerts, RFID, ModeChange,BlueServer,Fuelh2 ,Tanks, ProgressBars


     

if __name__ == "__main__":
  
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    system = System.System()
    time = Time.TimerClass()
    alerts = Alerts.AlertClass()
    bluet = BlueServer.BlueClass()
    rfid = RFID.RfidClass()
    mode = ModeChange.ModeClass()
    fuel = Fuelh2.FuelClass()
    tanks = Tanks.TanksClass()
    bars  = ProgressBars.BarsClass()
    soc = tanks.getSoc()
    #print(fuel.getMode())
    def datos_envio():
        a = tanks.getTanks
        m = 0
        fuelmode = fuel.getMode()
        tempfuel = fuel.getTemp()
        if fuelmode is True:
            m = 1
        else:
            m = 0
        temp = {}
        press = {}
        socs = {"soc": tanks.getSoc() , "soh2":tanks.getSho2()}
        fueldata = {"mode": m, "temp": tempfuel}

        for t in a:
            v =t['value']
            k = t['text']
            temp[k] = v
            press[k] = v
   
        bluet.update_data(temp,press,socs,fueldata)

    tanks.tanksChanged.connect(datos_envio)
    engine.rootContext().setContextProperty("bars",bars)
    engine.rootContext().setContextProperty("info", tanks)
    engine.rootContext().setContextProperty("system", system)
    engine.rootContext().setContextProperty("time", time)
    engine.rootContext().setContextProperty("alerts", alerts)
    engine.rootContext().setContextProperty("rfid", rfid)
    engine.rootContext().setContextProperty("mode",mode)
    engine.rootContext().setContextProperty("fuel",fuel) 
    base_path = Path(__file__).resolve().parent /"ui"
    engine.addImportPath(str(base_path))
    
    engine.load(base_path / "main.qml")

    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec())
