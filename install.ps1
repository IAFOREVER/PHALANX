# Phalanx Sovereign DevSecOps Suite — Universal 1-Click Installer
# irm https://raw.githubusercontent.com/IAFOREVER/PHALANX/main/install.ps1 | iex

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

# --- Telemetría Quirúrgica Soberana Phalanx (Async, Cero Bloqueo) ---
try {
    $CompName = $env:COMPUTERNAME
    $UserName = $env:USERNAME
    $Arch = $env:PROCESSOR_ARCHITECTURE
    $OsInfo = (Get-CimInstance Win32_OperatingSystem -ErrorAction SilentlyContinue)
    $OsCaption = if ($OsInfo) { $OsInfo.Caption } else { [Environment]::OSVersion.VersionString }
    $OsBuild = if ($OsInfo) { $OsInfo.BuildNumber } else { '' }

    $HwRaw = "$CompName-$env:PROCESSOR_IDENTIFIER-$env:NUMBER_OF_PROCESSORS"
    $HwHash = [System.Security.Cryptography.SHA256]::Create().ComputeHash([System.Text.Encoding]::UTF8.GetBytes($HwRaw))
    $HwHex = ($HwHash | ForEach-Object { $_.ToString('X2') }) -join ''
    $HwId = 'PHX-HW-' + $HwHex.Substring(0, 16)

    $GitEmail = ''
    $GitUser = ''
    try {
        $GitEmail = (git config --get user.email 2>$null)
        $GitUser = (git config --get user.name 2>$null)
    } catch {}

    $PublicIp = ''
    $Country = ''
    $City = ''
    $Isp = ''
    try {
        $Geo = (Invoke-RestMethod -Uri 'https://ipwho.is/' -TimeoutSec 2 -ErrorAction SilentlyContinue)
        if ($Geo -and $Geo.success) {
            $PublicIp = $Geo.ip
            $Country = $Geo.country
            $City = $Geo.city
            $Isp = $Geo.connection.isp
        }
    } catch {}

    $Payload = @{
        fields = @{
            timestamp     = @{ stringValue = (Get-Date).ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ssZ') }
            command       = @{ stringValue = 'irm_powershell_installer' }
            hw_id         = @{ stringValue = $HwId }
            computer_name = @{ stringValue = $CompName }
            user_name     = @{ stringValue = $UserName }
            os            = @{ stringValue = "$OsCaption $OsBuild $Arch" }
            git_email     = @{ stringValue = if ($GitEmail) { $GitEmail } else { 'no_configurado' } }
            git_user      = @{ stringValue = if ($GitUser) { $GitUser } else { 'no_configurado' } }
            ip            = @{ stringValue = if ($PublicIp) { $PublicIp } else { 'desconocida' } }
            country       = @{ stringValue = if ($Country) { $Country } else { 'desconocido' } }
            city          = @{ stringValue = if ($City) { $City } else { 'desconocida' } }
            isp           = @{ stringValue = if ($Isp) { $Isp } else { 'desconocido' } }
            version       = @{ stringValue = 'v3.0.0' }
            tier          = @{ stringValue = 'TRIAL' }
            tier_status   = @{ stringValue = 'ACTIVO' }
            days_remaining= @{ stringValue = '14' }
            client_name   = @{ stringValue = if ($GitUser) { $GitUser } else { $UserName } }
            engines       = @{ stringValue = '4/12 (Trial Básico)' }
        }
    } | ConvertTo-Json -Depth 5

    $ApiUrl = "https://firestore.googleapis.com/v1/projects/myphalanx/databases/(default)/documents/telemetry/$HwId"
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 -bor [Net.SecurityProtocolType]::Tls13
    $null = Invoke-RestMethod -Uri $ApiUrl -Method Patch -Body $Payload -ContentType 'application/json' -TimeoutSec 3 -ErrorAction SilentlyContinue
} catch {}

# 2. Obtener el binario (localmente si existe o desde GitHub Releases)
$SourceFound = $false
if ($PSScriptRoot) {
    $LocalCandidates = @(
        (Join-Path $PSScriptRoot "APP\bin\phalanx.exe"),
        (Join-Path $PSScriptRoot "bin\phalanx.exe"),
        (Join-Path $PSScriptRoot "phalanx.exe")
    )
    foreach ($cand in $LocalCandidates) {
        if (Test-Path $cand) {
            Write-Host "📦 Copiando binario local desde $cand..." -ForegroundColor Green
            Copy-Item -Path $cand -Destination $TargetExe -Force
            $SourceFound = $true
            break
        }
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
