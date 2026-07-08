# Troubleshooting de Active Directory

Comandos úteis para investigação de problemas comuns em domínio Windows.

## Ver usuário atual

Confirma qual conta está usando a sessão atual.

~~~cmd
whoami
~~~

## Ver grupos do usuário atual

Mostra os grupos de segurança presentes no token da sessão.

~~~cmd
whoami /groups
~~~

## Ver privilégios do usuário atual

Mostra privilégios administrativos ou especiais da sessão.

~~~cmd
whoami /priv
~~~

## Ver informações da máquina

Mostra dados gerais do sistema operacional e domínio.

~~~cmd
systeminfo
~~~

## Ver detalhes de um usuário do domínio

Consulta informações básicas de uma conta do domínio pelo CMD.

~~~cmd
net user usuario.login /domain
~~~

## Listar usuários do domínio

Lista usuários do domínio pelo comando `net`.

~~~cmd
net user /domain
~~~

## Listar grupos do domínio

Lista grupos do domínio pelo comando `net`.

~~~cmd
net group /domain
~~~

## Ver membros de um grupo do domínio

Mostra membros de um grupo usando CMD.

~~~cmd
net group "Domain Admins" /domain
~~~

## Ver administradores locais

Mostra quem está no grupo de administradores locais da máquina.

~~~cmd
net localgroup administrators
~~~

## Diagnóstico geral do Domain Controller

Executa testes básicos de saúde do DC.

~~~cmd
dcdiag
~~~

## Salvar diagnóstico do DC em arquivo

Gera um arquivo com a saída detalhada do diagnóstico.

~~~cmd
dcdiag /v > C:\Temp\dcdiag.txt
~~~

## Ver resumo de replicação

Mostra um resumo do estado de replicação do AD.

~~~cmd
repadmin /replsummary
~~~

## Ver detalhes da replicação

Mostra os parceiros de replicação do Domain Controller.

~~~cmd
repadmin /showrepl
~~~

## Forçar sincronização da replicação

Força replicação entre controladores de domínio.

~~~cmd
repadmin /syncall /AdeP
~~~

## Buscar SPNs duplicados

Ajuda a encontrar problemas de Kerberos causados por SPN duplicado.

~~~cmd
setspn -X
~~~

## Ver SPNs de uma conta

Mostra os SPNs associados a uma conta de serviço ou computador.

~~~cmd
setspn -L usuario_ou_servico
~~~

## Buscar SPN específico

Ajuda a confirmar se um SPN já existe no domínio.

~~~cmd
setspn -Q HTTP/servidor.empresa.local
~~~

## Ver eventos de logon bem-sucedido

Busca eventos recentes de logon com sucesso.

~~~powershell
Get-WinEvent -FilterHashtable @{
    LogName = "Security"
    Id = 4624
    StartTime = (Get-Date).AddDays(-7)
} | Select-Object TimeCreated, Id, ProviderName, Message
~~~

## Ver falhas de logon

Busca eventos recentes de tentativa de logon com erro.

~~~powershell
Get-WinEvent -FilterHashtable @{
    LogName = "Security"
    Id = 4625
    StartTime = (Get-Date).AddDays(-7)
} | Select-Object TimeCreated, Id, ProviderName, Message
~~~
