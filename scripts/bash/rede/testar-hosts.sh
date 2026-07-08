#!/bin/bash

# Testa conectividade ICMP com uma lista de hosts.
# Uso: ./testar-hosts.sh hosts.txt

ARQUIVO="$1"

if [ -z "$ARQUIVO" ]; then
    echo "Uso: $0 hosts.txt"
    exit 1
fi

if [ ! -f "$ARQUIVO" ]; then
    echo "Arquivo não encontrado: $ARQUIVO"
    exit 1
fi

while read -r HOST; do
    if [ -z "$HOST" ]; then
        continue
    fi

    if ping -c 2 -W 2 "$HOST" > /dev/null 2>&1; then
        echo "$HOST OK"
    else
        echo "$HOST FALHOU"
    fi
done < "$ARQUIVO"
