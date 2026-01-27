from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QUrl
import sys
import os
from pathlib import Path
from Controllers import Time, Tanks,Alerts,ModeChange

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    base_path = Path(__file__).resolve().parent /"UI"
    assets_url = QUrl.fromLocalFile(os.path.join(base_path,"assets/")).toString()
    time = Time.TimerClass()
    tanks = Tanks.TanksClass()
    alerts = Alerts.AlertClass()
    mode = ModeChange.ModeClass()
    engine.addImportPath(str(base_path))
    engine.rootContext().setContextProperty("assets",assets_url)
    engine.rootContext().setContextProperty("time",time)
    engine.rootContext().setContextProperty("tanks",tanks)
    engine.rootContext().setContextProperty("alerts",alerts)
    engine.rootContext().setContextProperty("mode",mode)
    engine.load(base_path / "main.qml")
    

    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec())
