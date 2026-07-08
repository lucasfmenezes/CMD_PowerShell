# GPO no Active Directory

Comandos úteis para consulta e troubleshooting de políticas de grupo.

## Atualizar políticas de grupo

Força a atualização das GPOs no computador.

~~~cmd
gpupdate /force
~~~

## Ver resumo das políticas aplicadas

Mostra um resumo das GPOs aplicadas ao usuário e ao computador.

~~~cmd
gpresult /r
~~~

## Gerar relatório HTML de GPO

Cria um relatório visual com as políticas aplicadas.

~~~cmd
gpresult /h C:\Temp\gpresult.html
~~~

## Ver políticas aplicadas ao usuário

Mostra apenas o resultado das políticas aplicadas ao usuário.

~~~cmd
gpresult /scope user /r
~~~

## Ver políticas aplicadas ao computador

Mostra apenas o resultado das políticas aplicadas ao computador.

~~~cmd
gpresult /scope computer /r
~~~

## Listar todas as GPOs pelo PowerShell

Mostra as políticas existentes no domínio.

~~~powershell
Get-GPO -All
~~~

## Buscar GPO pelo nome

Consulta uma política específica pelo nome.

~~~powershell
Get-GPO -Name "Nome da GPO"
~~~

## Gerar relatório de uma GPO em HTML

Cria um relatório detalhado de uma política específica.

~~~powershell
Get-GPOReport -Name "Nome da GPO" -ReportType Html -Path "C:\Temp\gpo.html"
~~~

## Gerar relatório de todas as GPOs

Exporta um relatório geral das políticas do domínio.

~~~powershell
Get-GPOReport -All -ReportType Html -Path "C:\Temp\todas_gpos.html"
~~~

## Fazer backup de todas as GPOs

Cria backup das políticas para uma pasta.

~~~powershell
Backup-GPO -All -Path "C:\Backup\GPO"
~~~

## Fazer backup de uma GPO específica

Cria backup de uma política específica.

~~~powershell
Backup-GPO -Name "Nome da GPO" -Path "C:\Backup\GPO"
~~~

## Ver links de GPO em uma OU

Mostra as GPOs vinculadas a uma OU.

~~~powershell
Get-GPInheritance -Target "OU=Usuarios,DC=empresa,DC=local"
~~~
