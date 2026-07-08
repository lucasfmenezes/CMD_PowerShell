# CMD - Kerberos

Comandos úteis para troubleshooting de Kerberos, autenticação e SPN no Windows.

## Listar tickets Kerberos

Mostra os tickets Kerberos carregados na sessão atual.

~~~cmd
klist
~~~

## Limpar tickets Kerberos

Remove os tickets Kerberos atuais da sessão.

~~~cmd
klist purge
~~~

## Ver tickets com detalhes

Mostra informações mais completas dos tickets Kerberos.

~~~cmd
klist tickets
~~~

## Ver cache Kerberos

Mostra o cache de tickets Kerberos.

~~~cmd
klist sessions
~~~

## Ver informações de logon

Ajuda a confirmar usuário, domínio e grupos da sessão.

~~~cmd
whoami /all
~~~

## Ver servidor de logon

Mostra qual servidor autenticou a sessão atual.

~~~cmd
echo %LOGONSERVER%
~~~

## Ver status de horário

Kerberos depende muito de horário correto.

~~~cmd
w32tm /query /status
~~~

## Ver fonte de horário

Mostra de onde a máquina está sincronizando hora.

~~~cmd
w32tm /query /source
~~~

## Forçar sincronização de horário

Tenta corrigir diferença de horário com a fonte configurada.

~~~cmd
w32tm /resync
~~~

## Buscar SPNs duplicados

Ajuda a encontrar um dos problemas mais comuns de Kerberos.

~~~cmd
setspn -X
~~~

## Ver SPNs de uma conta

Mostra os nomes de serviço registrados em uma conta.

~~~cmd
setspn -L usuario_ou_servico
~~~

## Buscar SPN específico

Confirma se um SPN já está registrado no domínio.

~~~cmd
setspn -Q HTTP/servidor.empresa.local
~~~

## Adicionar SPN em uma conta

Registra um SPN em uma conta de serviço.

~~~cmd
setspn -S HTTP/servidor.empresa.local DOMINIO\conta.servico
~~~

## Remover SPN de uma conta

Remove um SPN registrado incorretamente.

~~~cmd
setspn -D HTTP/servidor.empresa.local DOMINIO\conta.servico
~~~

## Ver DC usado pela máquina

Ajuda a entender qual DC está respondendo autenticação.

~~~cmd
nltest /dsgetdc:empresa.local
~~~

## Testar canal seguro

Confirma se a máquina confia corretamente no domínio.

~~~cmd
nltest /sc_verify:empresa.local
~~~

## Ver eventos de falha de logon

Busca falhas de autenticação recentes no log de segurança.

~~~cmd
powershell -Command "Get-WinEvent -FilterHashtable @{LogName='Security'; Id=4625; StartTime=(Get-Date).AddDays(-1)} | Select-Object TimeCreated, Id, Message"
~~~

## Ver logons bem-sucedidos

Busca eventos recentes de logon com sucesso.

~~~cmd
powershell -Command "Get-WinEvent -FilterHashtable @{LogName='Security'; Id=4624; StartTime=(Get-Date).AddDays(-1)} | Select-Object TimeCreated, Id, Message"
~~~

## Ver logons com privilégios especiais

Ajuda a identificar logons administrativos.

~~~cmd
powershell -Command "Get-WinEvent -FilterHashtable @{LogName='Security'; Id=4672; StartTime=(Get-Date).AddDays(-1)} | Select-Object TimeCreated, Id, Message"
~~~

## Abrir políticas de segurança local

Útil para revisar políticas relacionadas a autenticação.

~~~cmd
secpol.msc
~~~

## Abrir visualizador de eventos

Usado para investigar falhas de Kerberos e autenticação.

~~~cmd
eventvwr.msc
~~~
