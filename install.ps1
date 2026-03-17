# Definir la ruta de configuración
$configDir = "$env:LOCALAPPDATA\dnd"

# Crear el directorio de configuración
if (-not (Test-Path $configDir)) {
    New-Item -ItemType Directory -Path $configDir | Out-Null
}

# Copiar archivos necesarios
Copy-Item -Path ".\init.lua" -Destination $configDir
Copy-Item -Path ".\lua" -Destination $configDir -Recurse
Copy-Item -Path ".\bin" -Destination $configDir -Recurse

# Hacer que el script dnvim.bat sea ejecutable (no es necesario en Windows, pero lo marcamos como ejecutable)
$dndPath = "$configDir\bin\dnd.bat"
if (Test-Path $dndPath) {
    Set-ItemProperty -Path $dndPath -Name IsReadOnly -Value $false
}

# Agregar al PATH del usuario
$binPath = "$configDir\bin"
$userPath = [Environment]::GetEnvironmentVariable('Path', 'User')

if ($userPath -notmatch [Regex]::Escape($binPath)) {
    [Environment]::SetEnvironmentVariable('Path', "$userPath;$binPath", 'User')
    Write-Host "dnd (DeltanvimDocs) has been added to your PATH. Please restart your terminal."
} else {
    Write-Host "dnd (DeltanvimDocs) is already in your PATH."
}
