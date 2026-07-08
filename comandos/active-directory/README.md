# Comandos de Active Directory

Anotações rápidas de comandos PowerShell úteis para administração de Active Directory local.

A maior parte dos comandos depende do módulo `ActiveDirectory`, normalmente disponível em Domain Controllers ou em máquinas com RSAT instalado.

## Carregar o módulo do Active Directory

Carrega os cmdlets do Active Directory na sessão atual do PowerShell.

~~~powershell
Import-Module ActiveDirectory
~~~

## Verificar se o módulo está instalado

Ajuda a confirmar se a máquina tem o módulo de administração do AD disponível.

~~~powershell
Get-Module -ListAvailable ActiveDirectory
~~~

## Listar comandos do módulo ActiveDirectory

Mostra todos os cmdlets disponíveis para administração do AD.

~~~powershell
Get-Command -Module ActiveDirectory
~~~

## Ver informações do domínio

Mostra informações gerais do domínio atual.

~~~powershell
Get-ADDomain
~~~

## Ver informações da floresta

Mostra dados gerais da floresta do Active Directory.

~~~powershell
Get-ADForest
~~~

## Listar controladores de domínio

Lista todos os Domain Controllers encontrados no domínio.

~~~powershell
Get-ADDomainController -Filter *
~~~

## Ver as FSMO Roles do domínio

Mostra quem está segurando as funções principais do domínio.

~~~powershell
Get-ADDomain | Select-Object InfrastructureMaster, RIDMaster, PDCEmulator
~~~

## Ver as FSMO Roles da floresta

Mostra quem está segurando as funções principais da floresta.

~~~powershell
Get-ADForest | Select-Object DomainNamingMaster, SchemaMaster
~~~

## Dica rápida

Sempre valide o resultado de um comando de consulta antes de executar alterações em massa.
