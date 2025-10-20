# cleanup.ps1 - Script de ejemplo para limpieza
# Elimina archivos temporales antiguos

$tempPath = "C:\Temp"
$daysOld = 30
Get-ChildItem -Path $tempPath -Recurse -File | 
    Where-Object {$_.LastWriteTime -lt (Get-Date).AddDays(-$daysOld)} | 
    Remove-Item -Force
Write-Output "Limpieza completada: $(Get-Date)"