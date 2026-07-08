# Usuários no Microsoft Entra ID

Comandos úteis para consultar e alterar usuários no Entra ID usando Microsoft Graph PowerShell.

## Conectar para consultar usuários

Abre uma sessão com permissões básicas de leitura.

~~~powershell
Connect-MgGraph -Scopes "User.Read.All","Directory.Read.All"
~~~

## Conectar para alterar usuários

Abre uma sessão com permissão para atualizar usuários.

~~~powershell
Connect-MgGraph -Scopes "User.ReadWrite.All","Directory.ReadWrite.All"
~~~

## Listar usuários

Mostra os usuários do tenant.

~~~powershell
Get-MgUser -All |
Select-Object DisplayName, UserPrincipalName, Id
~~~

## Buscar usuário por UPN

Consulta um usuário pelo login principal.

~~~powershell
Get-MgUser -UserId "usuario@empresa.com.br"
~~~

## Buscar usuário com propriedades específicas

Traz somente os campos mais úteis para consulta cadastral.

~~~powershell
Get-MgUser -UserId "usuario@empresa.com.br" -Property "id,displayName,userPrincipalName,mail,employeeId,department,jobTitle,accountEnabled" |
Select-Object DisplayName, UserPrincipalName, Mail, EmployeeId, Department, JobTitle, AccountEnabled
~~~

## Listar usuários com employeeId

Mostra usuários e o atributo de matrícula no Entra ID.

~~~powershell
Get-MgUser -All -Property "id,displayName,userPrincipalName,employeeId" |
Select-Object DisplayName, UserPrincipalName, EmployeeId
~~~

## Listar usuários sem employeeId

Ajuda a encontrar contas sem matrícula preenchida.

~~~powershell
Get-MgUser -All -Property "id,displayName,userPrincipalName,employeeId" |
Where-Object { [string]::IsNullOrWhiteSpace($_.EmployeeId) } |
Select-Object DisplayName, UserPrincipalName, EmployeeId
~~~

## Alterar employeeId

Atualiza o atributo de matrícula do usuário no Entra ID.

~~~powershell
Update-MgUser -UserId "usuario@empresa.com.br" -BodyParameter @{
    employeeId = "123456"
}
~~~

## Conferir employeeId

Valida se o valor foi gravado no usuário.

~~~powershell
Get-MgUser -UserId "usuario@empresa.com.br" -Property "displayName,userPrincipalName,employeeId" |
Select-Object DisplayName, UserPrincipalName, EmployeeId
~~~

## Alterar departamento

Atualiza o departamento do usuário.

~~~powershell
Update-MgUser -UserId "usuario@empresa.com.br" -Department "Tecnologia da Informação"
~~~

## Alterar cargo

Atualiza o cargo do usuário.

~~~powershell
Update-MgUser -UserId "usuario@empresa.com.br" -JobTitle "Analista de Infraestrutura"
~~~

## Alterar telefone comercial

Atualiza o telefone comercial do usuário.

~~~powershell
Update-MgUser -UserId "usuario@empresa.com.br" -BusinessPhones @("3222-0000")
~~~

## Desabilitar usuário

Bloqueia o login do usuário no Entra ID.

~~~powershell
Update-MgUser -UserId "usuario@empresa.com.br" -AccountEnabled:$false
~~~

## Habilitar usuário

Libera novamente o login do usuário.

~~~powershell
Update-MgUser -UserId "usuario@empresa.com.br" -AccountEnabled:$true
~~~

## Listar usuários desabilitados

Mostra contas que estão bloqueadas para login.

~~~powershell
Get-MgUser -All -Property "displayName,userPrincipalName,accountEnabled" |
Where-Object { $_.AccountEnabled -eq $false } |
Select-Object DisplayName, UserPrincipalName, AccountEnabled
~~~

## Exportar usuários para CSV

Gera uma planilha com dados básicos dos usuários.

~~~powershell
Get-MgUser -All -Property "id,displayName,userPrincipalName,mail,department,jobTitle,employeeId,accountEnabled" |
Select-Object DisplayName, UserPrincipalName, Mail, Department, JobTitle, EmployeeId, AccountEnabled |
Export-Csv "C:\Temp\usuarios_entra.csv" -NoTypeInformation -Encoding UTF8
~~~

## Ver detalhes de licenciamento do usuário

Mostra as licenças atribuídas ao usuário.

~~~powershell
Get-MgUserLicenseDetail -UserId "usuario@empresa.com.br" |
Select-Object SkuPartNumber, SkuId
~~~

## Observação para ambiente híbrido

Se o usuário é sincronizado do AD local, revise se o atributo deve ser alterado no AD local em vez de alterar direto na nuvem.
