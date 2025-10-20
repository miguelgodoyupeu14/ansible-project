# backup.ps1 - Script de ejemplo para backup
# Realiza copia de seguridad de C:\data a C:\Backup

$source = "C:\data"
$destination = "C:\Backup"
if (!(Test-Path $destination)) {
    New-Item -ItemType Directory -Path $destination
}
Copy-Item -Path $source\* -Destination $destination -Recurse -Force
Write-Output "Backup completado: $(Get-Date)"