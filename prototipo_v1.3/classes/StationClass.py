import requests
import json 
import math

class ClassFuel:
    def __init__(self, parent= None):
        self.hd = {}
        self.token = ""
        self.user = ""
        self.passw = ""
        self.payload = {}
        self.url = "https://api.cne.cl"
        self.result = {}
        
    def obtenerToken(self):
        self.token = ""
        self.user = "a.z23384.12@gmail.com"
        self.passw = "Narut@123"
        self.payload = {
            "email":self.user,
            "password":self.passw
        }
        valor = requests.post(f"{self.url}/api/login/",json=self.payload,headers = self.hd)
        if valor.status_code == 200:
            a = valor.json()
            self.token=(a['token'])
           ## print(self.token)
            return self.token
        else:
            return 1
    @staticmethod
    def distancias(lat,lon,fuel_lat,fuel_lon):
        radio = 6371.0
        phi1,phi2 = math.radians(lat),math.radians(fuel_lat)
        dph1 = math.radians(fuel_lat-lat)
        dlambda = math.radians(fuel_lon-lon)
    
        a = math.sin(dph1 / 2)**2 + math.cos(phi2)*math.sin(dlambda / 2)**2
        c = math.atan2(math.sqrt(a),math.sqrt(1-a))
    
        return radio * c

    def getStations(self,latitud,longitud):
        tk = self.obtenerToken()
       ## print(tk)
        if tk == 1:
            return 1
        
            
        self.hd = {
            'Authorization': f'Bearer{tk}',
            'Content-type': 'application/json'
        }
        response = requests.get(f"{self.url}/api/v4/estaciones",headers= self.hd)
        if response.status_code == 200:
            datos = response.json()
           
            estaciones =[]
            lat =latitud
            lon =longitud
            for i,fuel in  enumerate(datos):  
                fuel_lat = float(fuel['ubicacion']['latitud'].replace(',','.'))
                fuel_lon = float(fuel['ubicacion']['longitud'].replace(',','.'))
                km = self.distancias(lat,lon,fuel_lat,fuel_lon)
                estaciones.append({
                    "distribuidor": fuel['distribuidor']['marca'],
                    "direccion":    fuel['ubicacion']['direccion'],
                    "punto_electrico": fuel['punto_electrico'],
                    "latitud":round( float(fuel['ubicacion']['latitud'].replace(',','.')),2),
                    "longitud":round( float(fuel['ubicacion']['longitud'].replace(',','.')),2), 
                    "km": km
                    
                })
            estaciones.sort(key=lambda x:x["km"])
            return estaciones[:5]    
            
        else:
            return 1       
    
