# DNS e domínio no Active Directory

Comandos úteis para diagnóstico de DNS, domínio, Kerberos e controladores de domínio.

## Ver configuração IP

Mostra IP, DNS, gateway e demais informações da interface de rede.

~~~cmd
ipconfig /all
~~~

## Limpar cache DNS

Remove entradas antigas do cache DNS local.

~~~cmd
ipconfig /flushdns
~~~

## Registrar DNS novamente

Força a máquina a registrar seus dados no DNS.

~~~cmd
ipconfig /registerdns
~~~

## Testar resolução do domínio

Confirma se o nome do domínio está resolvendo no DNS.

~~~cmd
nslookup empresa.local
~~~

## Testar resolução de um DC

Confirma se o nome do Domain Controller resolve corretamente.

~~~cmd
nslookup dc01.empresa.local
~~~

## Ver servidor de logon atual

Mostra qual servidor autenticou a sessão atual.

~~~cmd
echo %LOGONSERVER%
~~~

## Ver domínio do usuário atual

Mostra o domínio associado à sessão atual.

~~~cmd
echo %USERDOMAIN%
~~~

## Descobrir Domain Controller do domínio

Ajuda a validar se a máquina consegue localizar um DC.

~~~cmd
nltest /dsgetdc:empresa.local
~~~

## Listar DCs do domínio

Mostra os controladores de domínio conhecidos.

~~~cmd
nltest /dclist:empresa.local
~~~

## Verificar canal seguro com o domínio

Confirma se a máquina mantém relação de confiança com o domínio.

~~~cmd
nltest /sc_query:empresa.local
~~~

## Validar canal seguro com o domínio

Testa se o canal seguro está funcionando.

~~~cmd
nltest /sc_verify:empresa.local
~~~

## Testar porta LDAP

Confirma se a porta LDAP está acessível no DC.

~~~powershell
Test-NetConnection dc01.empresa.local -Port 389
~~~

## Testar porta LDAPS

Confirma se a porta LDAPS está acessível no DC.

~~~powershell
Test-NetConnection dc01.empresa.local -Port 636
~~~

## Testar porta Kerberos

Confirma se a porta Kerberos está acessível no DC.

~~~powershell
Test-NetConnection dc01.empresa.local -Port 88
~~~

## Testar porta SMB

Confirma se a porta SMB está acessível no servidor.

~~~powershell
Test-NetConnection servidor-arquivos.empresa.local -Port 445
~~~

## Ver tickets Kerberos

Mostra os tickets Kerberos da sessão atual.

~~~cmd
klist
~~~

## Limpar tickets Kerberos

Remove tickets Kerberos antigos da sessão.

~~~cmd
klist purge
~~~

## Ver fonte de horário

Mostra de onde o Windows está sincronizando o horário.

~~~cmd
w32tm /query /source
~~~

## Ver status do horário

Mostra informações detalhadas do serviço de tempo.

~~~cmd
w32tm /query /status
~~~

## Forçar sincronização de horário

Tenta sincronizar o horário novamente.

~~~cmd
w32tm /resync
~~~
