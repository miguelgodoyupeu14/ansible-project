#!/bin/bash
# cleanup.sh - Script de ejemplo para limpieza de logs
# Elimina archivos .log antiguos en /data/logs

LOGPATH="/data/logs"
find "$LOGPATH" -type f -name "*.log" -mtime +30 -exec rm -f {} \;
echo "Limpieza de logs completada: $(date)"