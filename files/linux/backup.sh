#!/bin/bash
# backup.sh - Script de ejemplo para backup
# Realiza copia de /data a /backup

SRC="/data"
DEST="/backup"
mkdir -p "$DEST"
rsync -a "$SRC/" "$DEST/"
echo "Backup completado: $(date)"