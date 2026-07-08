# Computadores no Active Directory

Comandos úteis para consultar e administrar contas de computadores no AD.

## Listar computadores do domínio

Mostra as contas de computadores cadastradas no AD.

~~~powershell
Get-ADComputer -Filter * |
Select-Object Name, Enabled
~~~

## Buscar computador pelo nome

Ajuda a localizar computadores usando parte do nome.

~~~powershell
Get-ADComputer -Filter "Name -like '*SRV*'" -Properties OperatingSystem |
Select-Object Name, OperatingSystem, Enabled
~~~

## Ver detalhes de um computador

Mostra propriedades completas de uma conta de computador.

~~~powershell
Get-ADComputer -Identity "NOME-COMPUTADOR" -Properties *
~~~

## Listar computadores com sistema operacional

Gera uma visão rápida de máquinas e sistemas operacionais.

~~~powershell
Get-ADComputer -Filter * -Properties OperatingSystem, LastLogonDate |
Select-Object Name, OperatingSystem, LastLogonDate, Enabled
~~~

## Exportar computadores para CSV

Cria uma planilha com computadores do domínio.

~~~powershell
Get-ADComputer -Filter * -Properties OperatingSystem, LastLogonDate |
Select-Object Name, OperatingSystem, LastLogonDate, Enabled |
Export-Csv "C:\Temp\computadores_ad.csv" -NoTypeInformation -Encoding UTF8
~~~

## Listar computadores inativos há mais de 90 dias

Ajuda a encontrar máquinas antigas ou sem uso.

~~~powershell
$limite = (Get-Date).AddDays(-90)

Get-ADComputer -Filter * -Properties LastLogonDate |
Where-Object { $_.LastLogonDate -lt $limite } |
Select-Object Name, LastLogonDate, Enabled
~~~

## Desativar conta de computador

Desativa a conta do computador no Active Directory.

~~~powershell
Disable-ADAccount -Identity "NOME-COMPUTADOR$"
~~~

## Ativar conta de computador

Reativa a conta do computador no Active Directory.

~~~powershell
Enable-ADAccount -Identity "NOME-COMPUTADOR$"
~~~

## Mover computador para outra OU

Move a conta do computador para uma OU específica.

~~~powershell
Get-ADComputer -Identity "NOME-COMPUTADOR" |
Move-ADObject -TargetPath "OU=Computadores,DC=empresa,DC=local"
~~~

## Remover computador do AD

Remove a conta do computador do Active Directory.

~~~powershell
Remove-ADComputer -Identity "NOME-COMPUTADOR" -Confirm:$false
~~~

## Testar canal seguro da máquina

Verifica se a máquina ainda conversa corretamente com o domínio.

~~~powershell
Test-ComputerSecureChannel
~~~

## Reparar canal seguro da máquina

Tenta corrigir a relação de confiança da máquina com o domínio.

~~~powershell
Test-ComputerSecureChannel -Repair -Credential empresa\administrador
~~~
