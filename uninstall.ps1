$AppName = 'SysAdminCheat'
$InstallDir = Join-Path $env:LOCALAPPDATA $AppName
$StartupDir = [Environment]::GetFolderPath('Startup')
$ShortcutPath = Join-Path $StartupDir "$AppName.lnk"
Get-Process $AppName -ErrorAction SilentlyContinue | Stop-Process -Force
Remove-Item $ShortcutPath -Force -ErrorAction SilentlyContinue
Remove-Item $InstallDir -Recurse -Force -ErrorAction SilentlyContinue
Write-Host "$AppName removed"
