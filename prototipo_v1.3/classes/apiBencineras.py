import requests
import json
import math 
url = "https://api.cne.cl"
token = ""

hd = {}
user = ""
passw = ""
payload = {
    "email":user,
    "password":passw
}
def obtenertoken(token):
    token = token
    valor = requests.post(f"{url}/api/login/",json=payload,headers =hd)
    if valor.status_code ==200:
        a = valor.json()
        token = (a['token'])
        return token
    else:
        print("error")

def distancias(lat,lon,fuel_lat,fuel_lon):
    radio = 6371.0
    phi1,phi2 = math.radians(lat),math.radians(fuel_lat)
    dph1 = math.radians(fuel_lat-lat)
    dlambda = math.radians(fuel_lon-lon)

    a = math.sin(dph1 / 2)**2 + math.cos(phi2)*math.sin(dlambda / 2)**2
    c = math.atan2(math.sqrt(a),math.sqrt(1-a))

    return radio * c

    

def getStations(token):
    headers = {
            'Authorization': f'Bearer {token}',
            'Content-Type': 'application/json'
        }
    response = requests.get(f"{url}/api/v4/estaciones", headers=headers)
    if response.status_code == 200:
        datos = response.json()

       # print(datos)   
        estaciones =[]
        lat =-33.3163806
        lon =-70.7552783
        for i,fuel in  enumerate(datos):  
            fuel_lat = float(fuel['ubicacion']['latitud'].replace(',','.'))
            fuel_lon = float(fuel['ubicacion']['longitud'].replace(',','.'))
            dist = distancias(lat,lon,fuel_lat,fuel_lon)
            fuel['km'] = dist
            estaciones.append(fuel)
        ordenadas = sorted(estaciones,key=lambda x:x['km'])
        for i,orden in enumerate(ordenadas[:5],start = 1):
            print(f"{i} - {orden['distribuidor']['marca']} - {orden['ubicacion']['direccion']} - {orden['km']}")
    else:
        print("eeeeeerror")

getStations(obtenertoken(token))    
