from testRFID import Rfid

rf = Rfid()
rf.inicializarModulo()

print(rf.lecturaTarjeta())
