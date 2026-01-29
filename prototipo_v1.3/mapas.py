from PySide6.QtCore import QCoreApplication
from PySide6.QtLocation import QGeoServiceProvider

# Necesario para inicializar el motor de Qt
app = QCoreApplication([])

# Obtener la lista de plugins instalados
plugins = QGeoServiceProvider.availableServiceProviders()

print("--- Proveedores de Mapas Disponibles ---")
for plugin in plugins:
    print(f"-> Proveedor encontrado: {plugin}")
    
    # Opcional: Verificar qué puede hacer cada uno
    provider = QGeoServiceProvider(plugin)
    print(f"   Mapping: {provider.mappingFeatures()}")
    print(f"   Routing: {provider.routingFeatures()}")
    print("-" * 40)
