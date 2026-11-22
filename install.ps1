<#
.SYNOPSIS
    Phalanx Sovereign DevSecOps Suite — Universal 1-Click Installer
.DESCRIPTION
    Descarga, instala y configura Phalanx en el PATH de Windows sin requerir Python ni dependencias.
.EXAMPLE
    irm https://raw.githubusercontent.com/IAFOREVER/phalanx/main/install.ps1 | iex
#>

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "================================================================================" -ForegroundColor Cyan
Write-Host "🛡️  PHALANX SOVEREIGN DEVSECOPS SUITE — INSTALADOR OFICIAL" -ForegroundColor Cyan
Write-Host "   Arquitectura Nativa C++ (Nuitka) | IAFOREVER Protocolo Dave Rensin EGM" -ForegroundColor DarkCyan
Write-Host "================================================================================" -ForegroundColor Cyan
Write-Host ""

# 1. Directorio de instalación en el perfil de usuario (cero permisos admin requeridos)
$InstallDir = Join-Path $env:LOCALAPPDATA "Phalanx\bin"
if (-not (Test-Path $InstallDir)) {
    New-Item -ItemType Directory -Path $InstallDir -Force | Out-Null
}

$TargetExe = Join-Path $InstallDir "phalanx.exe"

# 2. Obtener el binario (localmente si existe o desde GitHub Releases)
$LocalCandidate1 = Join-Path $PSScriptRoot "APP\bin\phalanx.exe"
$LocalCandidate2 = Join-Path $PSScriptRoot "bin\phalanx.exe"
$LocalCandidate3 = Join-Path $PSScriptRoot "phalanx.exe"

$SourceFound = $false
foreach ($cand in @($LocalCandidate1, $LocalCandidate2, $LocalCandidate3)) {
    if ($cand -and (Test-Path $cand)) {
        Write-Host "📦 Copiando binario local desde $cand..." -ForegroundColor Green
        Copy-Item -Path $cand -Destination $TargetExe -Force
        $SourceFound = $true
        break
    }
}

if (-not $SourceFound) {
    Write-Host "⬇️ Descargando último binario oficial de Phalanx v3.0.0..." -ForegroundColor Yellow
    $ReleaseUrl = "https://github.com/IAFOREVER/phalanx/releases/latest/download/phalanx.exe"
    try {
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 -bor [Net.SecurityProtocolType]::Tls13
        Invoke-WebRequest -Uri $ReleaseUrl -OutFile $TargetExe -UseBasicParsing
    } catch {
        Write-Warning "No se pudo descargar automáticamente de GitHub ($($_.Exception.Message))."
        Write-Host "Por favor descarga 'phalanx.exe' manualmente de https://github.com/IAFOREVER/phalanx/releases" -ForegroundColor Red
        return
    }
}

# 3. Registrar de forma permanente en el PATH de usuario
$UserPath = [Environment]::GetEnvironmentVariable("Path", "User")
$CleanPath = if ($UserPath) { $UserPath.TrimEnd(";") } else { "" }

if ($CleanPath -notlike "*$InstallDir*") {
    $NewPath = if ($CleanPath) { "$CleanPath;$InstallDir" } else { $InstallDir }
    [Environment]::SetEnvironmentVariable("Path", $NewPath, "User")
    Write-Host "✨ Phalanx añadido permanentemente al PATH de Windows: $InstallDir" -ForegroundColor Green
} else {
    Write-Host "✅ Phalanx ya se encuentra en el PATH de Windows: $InstallDir" -ForegroundColor Green
}

# 4. Actualizar el PATH del proceso actual para ejecución inmediata
if ($env:Path -notlike "*$InstallDir*") {
    $env:Path = "$InstallDir;$env:Path"
}

# 5. Notificar a Windows del cambio de entorno (WM_SETTINGCHANGE)
try {
    Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public class WinEnvBroadcaster {
    [DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
    public static extern IntPtr SendMessageTimeout(IntPtr hWnd, uint Msg, UIntPtr wParam, string lParam, uint fuFlags, uint uTimeout, out UIntPtr lpdwResult);
}
"@ -ErrorAction SilentlyContinue | Out-Null
    $result = [UIntPtr]::Zero
    [WinEnvBroadcaster]::SendMessageTimeout([IntPtr]0xffff, 0x001A, [UIntPtr]::Zero, "Environment", 2, 1000, [ref]$result) | Out-Null
} catch {}

Write-Host ""
Write-Host "================================================================================" -ForegroundColor Cyan
Write-Host "🎉 ¡INSTALACIÓN COMPLETADA CON ÉXITO!" -ForegroundColor Green
Write-Host "   El comando 'phalanx' ya está disponible globalmente en todo tu sistema." -ForegroundColor White
Write-Host "================================================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Para iniciar la auditoría y abrir el Cockpit Web de escritorio y móvil, ejecuta:" -ForegroundColor Yellow
Write-Host "   phalanx" -ForegroundColor Green -NoNewline
Write-Host "   (o phalanx C:\Ruta\A\Tu\Proyecto)" -ForegroundColor Gray
Write-Host ""
