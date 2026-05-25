# SysAdminCheat installer
# Usage from GitHub raw:
# powershell -ExecutionPolicy Bypass -Command "iwr https://raw.githubusercontent.com/USER/REPO/main/install.ps1 | iex"

$ErrorActionPreference = 'Stop'
$AppName = 'SysAdminCheat'
$InstallDir = Join-Path $env:LOCALAPPDATA $AppName
$ExeUrl = 'https://github.com/USER/REPO/releases/latest/download/SysAdminCheat.exe'
$ExePath = Join-Path $InstallDir 'SysAdminCheat.exe'
$StartupDir = [Environment]::GetFolderPath('Startup')
$ShortcutPath = Join-Path $StartupDir "$AppName.lnk"

New-Item -ItemType Directory -Force -Path $InstallDir | Out-Null
Write-Host "Downloading $AppName..."
Invoke-WebRequest -Uri $ExeUrl -OutFile $ExePath

$WshShell = New-Object -ComObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut($ShortcutPath)
$Shortcut.TargetPath = $ExePath
$Shortcut.WorkingDirectory = $InstallDir
$Shortcut.Save()

Start-Process $ExePath
Write-Host "$AppName installed to $InstallDir"
Write-Host "Autostart shortcut created: $ShortcutPath"
