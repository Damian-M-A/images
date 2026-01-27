import sys
import RPi.GPIO as GPIO
from mfrc522 import SimpleMFRC522

class Rfid:
    def __init__ (self):
        self.idRFID = 0
        self.reader = None

    def inicializarModulo(self):
        GPIO.setmode(GPIO.BCM)
        GPIO.setwarnings(False)
        self.reader = SimpleMFRC522()
    def lecturaTarjeta(self):
        tag_id, text = self.reader.read()
        self.idRFID = tag_id
        return self.idRFID
        
