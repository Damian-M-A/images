from bluedot.btcomm import BluetoothServer
import json

class Blueserver:
    def __init__(self):
        self.serverOn = None
        self.maxpress = 0.0
        self.maxtemp = 0.0
        self.datos = {}
        self.message = None
    def on_client_connected(self):
        return print("dispositivo conectado")
    def on_client_disconnected(self):
        return print("dispositivo desconectado")
    def inicializarServidor(self):
        self.serverOn = BluetoothServer(
            data_received_callback = None,
            when_client_connects = self.on_client_connected,
            when_client_disconnects = self.on_client_disconnected
        )
    def maxvalue(self,datos):
        max_value = 0
        for key, value in datos.items():
           ## print("Valores en for: ", value)
            if value > max_value:
                max_value = value    
        return max_value
    def data_requested(self,temp,press,socs,fueldata):
        self.maxtemp = self.maxvalue(temp)
        self.maxpress = self.maxvalue(press)
        self.datos = {
            "maxtemp":self.maxtemp,
            "maxpress":self.maxpress
        }
        dir1 = self.datos | socs
        print(dir1 | fueldata)
        return dir1 | fueldata 
    def enviomensaje(self, data):
        if self.serverOn.client_connected:
            self.message = json.dumps(data) + "\n"
            self.serverOn.send(self.message)
            return print(self.message)
        else:
            return False
    def cerrarServidor(self):
        self.serverOn.stop()
