# CMD - Domínio Active Directory

Comandos úteis para consulta e troubleshooting de domínio Windows.

## Ver usuário atual

Confirma qual conta está usando a sessão atual.

~~~cmd
whoami
~~~

## Ver usuário atual com domínio

Mostra o usuário no formato domínio\usuário.

~~~cmd
whoami /user
~~~

## Ver grupos do usuário atual

Mostra os grupos carregados no token da sessão.

~~~cmd
whoami /groups
~~~

## Ver privilégios do usuário atual

Mostra privilégios disponíveis na sessão.

~~~cmd
whoami /priv
~~~

## Ver domínio da sessão atual

Mostra o domínio associado ao usuário logado.

~~~cmd
echo %USERDOMAIN%
~~~

## Ver servidor de logon

Mostra qual servidor autenticou o usuário.

~~~cmd
echo %LOGONSERVER%
~~~

## Ver nome do computador

Mostra o nome da máquina local.

~~~cmd
hostname
~~~

## Ver informações completas do sistema

Ajuda a ver domínio, versão do Windows e configurações gerais.

~~~cmd
systeminfo
~~~

## Listar usuários do domínio

Lista usuários do domínio usando o comando net.

~~~cmd
net user /domain
~~~

## Ver detalhes de um usuário do domínio

Mostra informações básicas da conta do usuário no domínio.

~~~cmd
net user usuario.login /domain
~~~

## Listar grupos do domínio

Mostra grupos disponíveis no domínio.

~~~cmd
net group /domain
~~~

## Ver membros de um grupo do domínio

Mostra quem faz parte de um grupo específico.

~~~cmd
net group "Domain Admins" /domain
~~~

## Ver grupos locais da máquina

Lista grupos locais do computador.

~~~cmd
net localgroup
~~~

## Ver administradores locais

Mostra quem tem permissão administrativa local na máquina.

~~~cmd
net localgroup administrators
~~~

## Adicionar usuário como administrador local

Inclui um usuário do domínio no grupo de administradores locais.

~~~cmd
net localgroup administrators DOMINIO\usuario.login /add
~~~

## Remover usuário dos administradores locais

Remove um usuário do grupo de administradores locais.

~~~cmd
net localgroup administrators DOMINIO\usuario.login /delete
~~~

## Descobrir Domain Controller do domínio

Ajuda a validar se a máquina consegue localizar um DC.

~~~cmd
nltest /dsgetdc:empresa.local
~~~

## Listar Domain Controllers

Mostra os controladores de domínio conhecidos.

~~~cmd
nltest /dclist:empresa.local
~~~

## Ver canal seguro com o domínio

Confirma se a máquina mantém relação de confiança com o domínio.

~~~cmd
nltest /sc_query:empresa.local
~~~

## Verificar canal seguro com o domínio

Testa se o canal seguro da máquina está funcionando.

~~~cmd
nltest /sc_verify:empresa.local
~~~

## Ver informações de confiança

Mostra relações de confiança conhecidas pelo domínio.

~~~cmd
nltest /domain_trusts
~~~

## Forçar redescoberta de DC

Ajuda quando a máquina está usando um DC errado ou antigo.

~~~cmd
nltest /dsgetdc:empresa.local /force
~~~

## Consultar site do AD

Ajuda em troubleshooting de sites e sub-redes do AD.

~~~cmd
nltest /dsgetsite
~~~

## Ver compartilhamentos da máquina

Mostra os compartilhamentos SMB locais.

~~~cmd
net share
~~~

## Ver sessões abertas na máquina

Mostra sessões SMB conectadas ao servidor.

~~~cmd
net session
~~~

## Ver arquivos abertos por rede

Mostra arquivos abertos via compartilhamento.

~~~cmd
openfiles /query
~~~

## Ativar rastreamento de arquivos abertos

Habilita o controle de arquivos abertos, geralmente exige reinício.

~~~cmd
openfiles /local on
~~~

## Ver hora do domínio

Consulta o horário do domínio.

~~~cmd
net time /domain
~~~

## Ver fonte de horário

Mostra de onde a máquina está sincronizando hora.

~~~cmd
w32tm /query /source
~~~

## Ver status do horário

Mostra detalhes da sincronização de tempo.

~~~cmd
w32tm /query /status
~~~

## Forçar sincronização de horário

Tenta sincronizar o horário novamente.

~~~cmd
w32tm /resync
~~~

## Diagnóstico geral do Domain Controller

Executa testes de saúde no controlador de domínio.

~~~cmd
dcdiag
~~~

## Salvar diagnóstico do DC em arquivo

Gera um arquivo de texto com o diagnóstico detalhado.

~~~cmd
dcdiag /v > C:\Temp\dcdiag.txt
~~~

## Ver resumo de replicação

Mostra um resumo do estado de replicação entre DCs.

~~~cmd
repadmin /replsummary
~~~

## Ver detalhes de replicação

Mostra parceiros e status de replicação do DC.

~~~cmd
repadmin /showrepl
~~~

## Forçar replicação

Força sincronização entre controladores de domínio.

~~~cmd
repadmin /syncall /AdeP
~~~

## Ver fila de replicação

Mostra se existem operações de replicação pendentes.

~~~cmd
repadmin /queue
~~~
