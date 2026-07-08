#!/bin/bash

# Faz backup compactado de um diretório.
# Uso: ./backup-diretorio.sh /origem /destino

set -e

ORIGEM="$1"
DESTINO="$2"
DATA=$(date +"%Y%m%d_%H%M%S")

if [ -z "$ORIGEM" ] || [ -z "$DESTINO" ]; then
    echo "Uso: $0 /origem /destino"
    exit 1
fi

if [ ! -d "$ORIGEM" ]; then
    echo "Diretório de origem não encontrado: $ORIGEM"
    exit 1
fi

mkdir -p "$DESTINO"

NOME_BACKUP="backup_$(basename "$ORIGEM")_$DATA.tar.gz"

tar -czf "$DESTINO/$NOME_BACKUP" "$ORIGEM"

echo "Backup criado em: $DESTINO/$NOME_BACKUP"
