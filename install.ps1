# Definir la ruta de configuración
$configDir = "$env:LOCALAPPDATA\DeltaNvim"

# Crear el directorio de configuración
if (-not (Test-Path $configDir)) {
    New-Item -ItemType Directory -Path $configDir | Out-Null
}

# Copiar archivos necesarios
Copy-Item -Path ".\init.lua" -Destination $configDir
Copy-Item -Path ".\lua" -Destination $configDir -Recurse
Copy-Item -Path ".\bin" -Destination $configDir -Recurse

# Hacer que el script dnvim.bat sea ejecutable (no es necesario en Windows, pero lo marcamos como ejecutable)
$dnvimPath = "$configDir\bin\dnvim.bat"
if (Test-Path $dnvimPath) {
    Set-ItemProperty -Path $dnvimPath -Name IsReadOnly -Value $false
}

# Agregar al PATH del usuario
$binPath = "$configDir\bin"
$userPath = [Environment]::GetEnvironmentVariable('Path', 'User')

if ($userPath -notmatch [Regex]::Escape($binPath)) {
    [Environment]::SetEnvironmentVariable('Path', "$userPath;$binPath", 'User')
    Write-Host "DeltaNvim has been added to your PATH. Please restart your terminal."
} else {
    Write-Host "DeltaNvim is already in your PATH."
}
