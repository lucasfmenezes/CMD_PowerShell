#!/bin/sh

# Verifica se um processo está em execução.
# Uso: ./verificar-processo.sh nginx

PROCESSO="$1"

if [ -z "$PROCESSO" ]; then
    echo "Uso: $0 nome-do-processo"
    exit 1
fi

if ps aux | grep "$PROCESSO" | grep -v grep > /dev/null 2>&1; then
    echo "Processo encontrado: $PROCESSO"
else
    echo "Processo não encontrado: $PROCESSO"
fi
