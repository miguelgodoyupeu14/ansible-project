# cleanup.ps1 - Script de ejemplo para limpieza de logs
# Elimina archivos .log antiguos en C:\data\logs

$logPath = "C:\data\logs"
$days = 30
Get-ChildItem -Path $logPath -Filter *.log | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-$days) } | Remove-Item -Force
Write-Output "Limpieza de logs completada: $(Get-Date)"
