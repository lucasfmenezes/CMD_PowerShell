# Grupos no Microsoft Entra ID

Comandos úteis para consultar e administrar grupos no Entra ID usando Microsoft Graph PowerShell.

## Conectar para consultar grupos

Abre uma sessão com permissões de leitura para grupos.

~~~powershell
Connect-MgGraph -Scopes "Group.Read.All","User.Read.All","Directory.Read.All"
~~~

## Conectar para alterar grupos

Abre uma sessão com permissão para editar grupos.

~~~powershell
Connect-MgGraph -Scopes "Group.ReadWrite.All","User.Read.All","Directory.ReadWrite.All"
~~~

## Listar grupos

Mostra os grupos existentes no tenant.

~~~powershell
Get-MgGroup -All |
Select-Object DisplayName, Id, MailEnabled, SecurityEnabled
~~~

## Buscar grupo pelo nome exato

Localiza um grupo usando o nome de exibição.

~~~powershell
Get-MgGroup -Filter "displayName eq 'Nome do Grupo'"
~~~

## Buscar grupos por trecho do nome

Ajuda quando você não sabe o nome exato do grupo.

~~~powershell
Get-MgGroup -All |
Where-Object { $_.DisplayName -like "*VPN*" } |
Select-Object DisplayName, Id, MailEnabled, SecurityEnabled
~~~

## Ver detalhes de um grupo

Consulta propriedades básicas de um grupo específico.

~~~powershell
$grupo = Get-MgGroup -Filter "displayName eq 'Nome do Grupo'"
$grupo | Select-Object DisplayName, Id, MailEnabled, SecurityEnabled
~~~

## Ver membros de um grupo

Lista os membros de um grupo pelo ID.

~~~powershell
$grupo = Get-MgGroup -Filter "displayName eq 'Nome do Grupo'"

Get-MgGroupMember -GroupId $grupo.Id -All
~~~

## Ver membros de um grupo com nome de usuário

Traz os membros tentando mostrar dados mais fáceis de ler.

~~~powershell
$grupo = Get-MgGroup -Filter "displayName eq 'Nome do Grupo'"
$membros = Get-MgGroupMember -GroupId $grupo.Id -All

$membros | ForEach-Object {
    Get-MgUser -UserId $_.Id -ErrorAction SilentlyContinue
} | Select-Object DisplayName, UserPrincipalName
~~~

## Adicionar usuário a um grupo

Inclui um usuário como membro do grupo.

~~~powershell
$usuario = Get-MgUser -UserId "usuario@empresa.com.br"
$grupo = Get-MgGroup -Filter "displayName eq 'Nome do Grupo'"

New-MgGroupMember -GroupId $grupo.Id -DirectoryObjectId $usuario.Id
~~~

## Remover usuário de um grupo

Remove o usuário de um grupo específico.

~~~powershell
$usuario = Get-MgUser -UserId "usuario@empresa.com.br"
$grupo = Get-MgGroup -Filter "displayName eq 'Nome do Grupo'"

Remove-MgGroupMemberByRef -GroupId $grupo.Id -DirectoryObjectId $usuario.Id
~~~

## Criar grupo de segurança

Cria um grupo de segurança simples no Entra ID.

~~~powershell
New-MgGroup `
    -DisplayName "GRP-Sistema-Acesso" `
    -MailEnabled:$false `
    -MailNickname "grp-sistema-acesso" `
    -SecurityEnabled:$true
~~~

## Criar grupo Microsoft 365

Cria um grupo Microsoft 365 para colaboração.

~~~powershell
New-MgGroup `
    -DisplayName "Equipe Projeto" `
    -MailEnabled:$true `
    -MailNickname "equipe-projeto" `
    -SecurityEnabled:$false `
    -GroupTypes @("Unified")
~~~

## Exportar grupos para CSV

Gera uma planilha com os grupos do tenant.

~~~powershell
Get-MgGroup -All |
Select-Object DisplayName, Id, MailEnabled, SecurityEnabled |
Export-Csv "C:\Temp\grupos_entra.csv" -NoTypeInformation -Encoding UTF8
~~~
