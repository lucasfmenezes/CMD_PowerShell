#!/bin/bash

# Limpa arquivos temporários simples do Linux.
# Use com cuidado e revise antes de executar em produção.

echo "Limpando /tmp..."
find /tmp -type f -mtime +7 -print -delete

echo "Limpeza concluída."
