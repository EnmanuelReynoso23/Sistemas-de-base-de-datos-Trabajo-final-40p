#Requires -RunAsAdministrator

# Script simple para crear base de datos
Write-Host "Verificando PostgreSQL..."
$service = Get-Service -Name "postgresql-x64-17" -ErrorAction SilentlyContinue
if ($service -and $service.Status -eq "Running") {
    Write-Host "PostgreSQL esta corriendo"
} else {
    Write-Host "Iniciando PostgreSQL..."
    net start postgresql-x64-17
    Start-Sleep -Seconds 3
}

Write-Host "Creando base de datos..."
& "C:\Program Files\PostgreSQL\17\bin\psql.exe" -U postgres -f "create_database_only.sql"
if ($LASTEXITCODE -eq 0) {
    Write-Host "Base de datos creada!"
} else {
    Write-Host "Error al crear la base de datos. Código de salida: $LASTEXITCODE"
}