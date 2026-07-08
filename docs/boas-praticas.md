# Boas práticas

Anotações simples para escrever comandos e scripts com mais segurança, clareza e organização.

## PowerShell

## Testar antes de alterar

Use `-WhatIf` quando o comando aceitar esse parâmetro.

~~~powershell
Disable-ADAccount -Identity "usuario.login" -WhatIf
~~~

## Usar comentários simples

Ajuda a lembrar por que o comando existe.

~~~powershell
# Consulta usuários sem employeeID preenchido
Get-ADUser -Filter * -Properties employeeID |
Where-Object { [string]::IsNullOrWhiteSpace($_.employeeID) }
~~~

## Usar variáveis no começo do script

Facilita alterar caminhos e parâmetros depois.

~~~powershell
$CaminhoCsv = "C:\Temp\usuarios.csv"
$CaminhoSaida = "C:\Temp\resultado.csv"
~~~

## Usar try/catch

Evita que o script pare inteiro por causa de um erro simples.

~~~powershell
try {
    Get-ADUser -Identity "usuario.login" -ErrorAction Stop
}
catch {
    Write-Host "Erro: $($_.Exception.Message)" -ForegroundColor Red
}
~~~

## Gerar logs

Ajuda a revisar o que aconteceu durante a execução.

~~~powershell
Start-Transcript -Path "C:\Temp\log_script.txt"

# comandos aqui

Stop-Transcript
~~~

## Evitar senha em texto puro

Nunca deixe senha escrita direto no script.

~~~powershell
$Senha = Read-Host -AsSecureString "Digite a senha"
~~~

## Bash e Shell

## Começar scripts com shebang

Define qual interpretador será usado.

~~~bash
#!/bin/bash
~~~

## Parar em erro quando fizer sentido

Evita que o script continue depois de uma falha importante.

~~~bash
set -e
~~~

## Usar variáveis

Ajuda a evitar repetição e facilita manutenção.

~~~bash
ORIGEM="/dados"
DESTINO="/backup"
~~~

## Validar arquivos antes de usar

Evita erro quando o arquivo não existe.

~~~bash
if [ ! -f "$ARQUIVO" ]; then
    echo "Arquivo não encontrado: $ARQUIVO"
    exit 1
fi
~~~

## Dar permissão de execução

Permite executar o script diretamente.

~~~bash
chmod +x script.sh
~~~

## Git

## Ver arquivos alterados

Mostra o que mudou antes do commit.

~~~bash
git status
~~~

## Ver diferenças

Mostra o conteúdo alterado nos arquivos.

~~~bash
git diff
~~~

## Adicionar arquivos

Adiciona arquivos para o próximo commit.

~~~bash
git add .
~~~

## Criar commit

Salva uma versão do projeto.

~~~bash
git commit -m "Mensagem do commit"
~~~

## Enviar para o GitHub

Envia os commits para o repositório remoto.

~~~bash
git push
~~~
