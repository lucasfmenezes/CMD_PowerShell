# Relatórios no Microsoft Entra ID

Comandos úteis para exportar informações do Entra ID usando Microsoft Graph PowerShell.

## Conectar para relatórios

Abre uma sessão com permissões de leitura para gerar relatórios.

~~~powershell
Connect-MgGraph -Scopes "User.Read.All","Group.Read.All","Directory.Read.All","Organization.Read.All"
~~~

## Exportar usuários do tenant

Gera um CSV com dados básicos dos usuários.

~~~powershell
Get-MgUser -All -Property "displayName,userPrincipalName,mail,department,jobTitle,employeeId,accountEnabled" |
Select-Object DisplayName, UserPrincipalName, Mail, Department, JobTitle, EmployeeId, AccountEnabled |
Export-Csv "C:\Temp\relatorio_usuarios_entra.csv" -NoTypeInformation -Encoding UTF8
~~~

## Exportar usuários sem employeeId

Gera um relatório de usuários sem matrícula preenchida.

~~~powershell
Get-MgUser -All -Property "displayName,userPrincipalName,employeeId" |
Where-Object { [string]::IsNullOrWhiteSpace($_.EmployeeId) } |
Select-Object DisplayName, UserPrincipalName, EmployeeId |
Export-Csv "C:\Temp\usuarios_sem_employeeid_entra.csv" -NoTypeInformation -Encoding UTF8
~~~

## Exportar usuários desabilitados

Gera uma lista de contas bloqueadas para login.

~~~powershell
Get-MgUser -All -Property "displayName,userPrincipalName,accountEnabled" |
Where-Object { $_.AccountEnabled -eq $false } |
Select-Object DisplayName, UserPrincipalName, AccountEnabled |
Export-Csv "C:\Temp\usuarios_desabilitados_entra.csv" -NoTypeInformation -Encoding UTF8
~~~

## Exportar grupos do tenant

Gera uma planilha com os grupos existentes.

~~~powershell
Get-MgGroup -All |
Select-Object DisplayName, Id, MailEnabled, SecurityEnabled |
Export-Csv "C:\Temp\relatorio_grupos_entra.csv" -NoTypeInformation -Encoding UTF8
~~~

## Exportar membros de um grupo

Gera um relatório simples com os membros de um grupo.

~~~powershell
$grupo = Get-MgGroup -Filter "displayName eq 'Nome do Grupo'"
$membros = Get-MgGroupMember -GroupId $grupo.Id -All

$resultado = foreach ($membro in $membros) {
    Get-MgUser -UserId $membro.Id -ErrorAction SilentlyContinue |
    Select-Object DisplayName, UserPrincipalName
}

$resultado | Export-Csv "C:\Temp\membros_grupo_entra.csv" -NoTypeInformation -Encoding UTF8
~~~

## Exportar licenças consumidas

Gera um relatório de consumo das licenças do tenant.

~~~powershell
Get-MgSubscribedSku |
Select-Object SkuPartNumber, SkuId, ConsumedUnits,
@{Name="Total";Expression={$_.PrepaidUnits.Enabled}},
@{Name="Disponivel";Expression={$_.PrepaidUnits.Enabled - $_.ConsumedUnits}} |
Export-Csv "C:\Temp\relatorio_licencas_entra.csv" -NoTypeInformation -Encoding UTF8
~~~

## Exportar usuários e licenças

Gera uma visão simples de usuários com suas licenças.

~~~powershell
$usuarios = Get-MgUser -All -Property "displayName,userPrincipalName"

$resultado = foreach ($usuario in $usuarios) {
    $licencas = Get-MgUserLicenseDetail -UserId $usuario.UserPrincipalName -ErrorAction SilentlyContinue

    [PSCustomObject]@{
        DisplayName       = $usuario.DisplayName
        UserPrincipalName = $usuario.UserPrincipalName
        Licencas          = ($licencas.SkuPartNumber -join "; ")
    }
}

$resultado | Export-Csv "C:\Temp\usuarios_licencas_entra.csv" -NoTypeInformation -Encoding UTF8
~~~

## Ver tenant conectado

Ajuda a confirmar que você está gerando relatório no tenant certo.

~~~powershell
Get-MgContext
~~~
