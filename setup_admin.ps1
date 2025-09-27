# Ejecutar como administrador
# Versión simplificada - Solo crea la base de datos vacía

Write-Host "Deteniendo servicio PostgreSQL..."
net stop postgresql-x64-17

Write-Host "Esperando 3 segundos..."
Start-Sleep -Seconds 3

Write-Host "Iniciando servicio PostgreSQL..."
net start postgresql-x64-17

Write-Host "Esperando 5 segundos para que inicie..."
Start-Sleep -Seconds 5

Write-Host "Creando base de datos vacía..."
& "C:\Program Files\PostgreSQL\17\bin\psql.exe" -U postgres -f "create_database_only.sql"

Write-Host "Base de datos vacía creada exitosamente."