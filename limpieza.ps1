[CmdletBinding()]
param(
    [switch]$WhatIf,
    [switch]$Confirm
)

function Test-IsAdmin {
    $id = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $p = New-Object System.Security.Principal.WindowsPrincipal($id)
    return $p.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
}

if (-not (Test-IsAdmin)) {
    Write-Warning "No se estan ejecutando privilegios administrativos. Algunas rutas del sistema podrian fallar."
}

function Remove-Entries {
    param(
        [string[]]$Paths
    )

    foreach ($p in $Paths) {
        if ($WhatIf) { Write-Host "[Simulacion] Eliminar: $p"; continue }

        if ($Confirm) {
            $ans = Read-Host "Eliminar '$p'? (S/N)"
            if ($ans -notin @('S','s','Si','SI','sí','Sí')) { continue }
        }

        try {
            if ($p -like '*places.sqlite' -or $p -like '*History') {
                Get-ChildItem -Path $p -Force -ErrorAction SilentlyContinue | ForEach-Object {
                    try { Remove-Item -LiteralPath $_.FullName -Force -ErrorAction Stop }
                    catch { Write-Verbose "No se pudo eliminar $($_.FullName): $($_.Exception.Message)" }
                }
            }
            else {
                Remove-Item -Path $p -Recurse -Force -ErrorAction SilentlyContinue
            }
        }
        catch {
            Write-Verbose "Error al procesar $p : $($_.Exception.Message)"
        }
    }
}

function Clean-Temp {
    Write-Host "Limpiando temporales..." -ForegroundColor Cyan
    $paths = @(
        "$env:TEMP\*",
        "$env:USERPROFILE\AppData\Local\Temp\*",
        "$env:USERPROFILE\AppData\Local\Temp\*.log",
        "$env:SystemRoot\Temp\*"
    )
    Remove-Entries -Paths $paths
}

function Clean-Chrome {
    Write-Host "Limpiando Google Chrome..." -ForegroundColor Cyan
    $paths = @(
        "$env:USERPROFILE\AppData\Local\Google\Chrome\User Data\Default\Cache\*",
        "$env:USERPROFILE\AppData\Local\Google\Chrome\User Data\Default\History"
    )
    Remove-Entries -Paths $paths
}

function Clean-Edge {
    Write-Host "Limpiando Microsoft Edge..." -ForegroundColor Cyan
    $paths = @(
        "$env:USERPROFILE\AppData\Local\Microsoft\Edge\User Data\Default\Cache\*",
        "$env:USERPROFILE\AppData\Local\Microsoft\Edge\User Data\Default\History"
    )
    Remove-Entries -Paths $paths
}

function Clean-Firefox {
    Write-Host "Limpiando Mozilla Firefox..." -ForegroundColor Cyan
    $paths = @(
        "$env:USERPROFILE\AppData\Local\Mozilla\Firefox\Profiles\*\cache2\*",
        "$env:USERPROFILE\AppData\Local\Mozilla\Firefox\Profiles\*\places.sqlite"
    )
    Remove-Entries -Paths $paths
}

function Clean-SystemCaches {
    Write-Host "Limpiando caches del sistema (prefetch, thumbcache, icon cache, font cache)..." -ForegroundColor Cyan
    $paths = @(
        "$env:SystemRoot\Prefetch\*",
        "$env:USERPROFILE\AppData\Local\Microsoft\Windows\Explorer\thumbcache_*.db",
        "$env:USERPROFILE\AppData\Local\IconCache.db",
        "$env:SystemRoot\ServiceProfiles\LocalService\AppData\Local\FontCache\*",
        "$env:LOCALAPPDATA\CrashDumps\*"
    )
    Remove-Entries -Paths $paths
}

function Clean-WindowsUpdates {
    Write-Host "Eliminando descargas de actualizaciones de Windows..." -ForegroundColor Cyan
    $paths = @("$env:SystemRoot\SoftwareDistribution\Download\*")
    Remove-Entries -Paths $paths
}

function Clear-DNSCache {
    Write-Host "Eliminando cache DNS..." -ForegroundColor Cyan
    if ($WhatIf) { Write-Host "[Simulacion] ipconfig /flushdns"; return }
    try { Clear-DnsClientCache -ErrorAction SilentlyContinue } catch { ipconfig /flushdns | Out-Null }
}

function Empty-RecycleBin {
    Write-Host "Vaciando la papelera de reciclaje..." -ForegroundColor Cyan
    if ($WhatIf) { Write-Host "[Simulacion] Clear-RecycleBin -Force"; return }
    try { Clear-RecycleBin -Force -ErrorAction SilentlyContinue } catch { Write-Verbose "No se pudo vaciar la papelera: $($_.Exception.Message)" }
}

function Run-All {
    Clean-Temp
    Clean-Chrome
    Clean-Edge
    Clean-Firefox
    Clean-SystemCaches
    Clean-WindowsUpdates
    Clear-DNSCache
    Empty-RecycleBin
}

function Show-Menu {
    Clear-Host
    Write-Host "=== Menu de limpieza ===" -ForegroundColor Yellow
    Write-Host "1) Limpiar temporales"
    Write-Host "2) Limpiar Google Chrome"
    Write-Host "3) Limpiar Microsoft Edge"
    Write-Host "4) Limpiar Mozilla Firefox"
    Write-Host "5) Limpiar caches del sistema"
    Write-Host "6) Limpiar descargas de actualizaciones de Windows"
    Write-Host "7) Eliminar cache DNS"
    Write-Host "8) Vaciar papelera de reciclaje"
    Write-Host "9) Ejecutar todo"
    Write-Host "0) Salir"
}

while ($true) {
    Show-Menu
    $choice = Read-Host "Seleccione una opcion (0-9)"
    switch ($choice) {
        '1' { Clean-Temp }
        '2' { Clean-Chrome }
        '3' { Clean-Edge }
        '4' { Clean-Firefox }
        '5' { Clean-SystemCaches }
        '6' { Clean-WindowsUpdates }
        '7' { Clear-DNSCache }
        '8' { Empty-RecycleBin }
        '9' { Run-All }
        '0' { break }
        default { Write-Host "Opcion no valida." -ForegroundColor Red }
    }

    Read-Host -Prompt "Accion completada. Presione Enter para continuar"
}

Write-Host "Limpieza finalizada. Saliendo..." -ForegroundColor Green

