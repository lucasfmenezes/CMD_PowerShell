# Licenças no Microsoft Entra ID e Microsoft 365

Comandos úteis para consultar e atribuir licenças usando Microsoft Graph PowerShell.

## Conectar para consultar licenças

Abre uma sessão com permissões básicas de leitura.

~~~powershell
Connect-MgGraph -Scopes "User.Read.All","Directory.Read.All","Organization.Read.All"
~~~

## Conectar para alterar licenças

Abre uma sessão com permissão para atribuir e remover licenças.

~~~powershell
Connect-MgGraph -Scopes "User.ReadWrite.All","Directory.ReadWrite.All","Organization.Read.All"
~~~

## Listar SKUs disponíveis

Mostra os produtos/licenças disponíveis no tenant.

~~~powershell
Get-MgSubscribedSku |
Select-Object SkuPartNumber, SkuId, ConsumedUnits
~~~

## Ver licenças de um usuário

Mostra as licenças atribuídas a um usuário específico.

~~~powershell
Get-MgUserLicenseDetail -UserId "usuario@empresa.com.br" |
Select-Object SkuPartNumber, SkuId
~~~

## Atribuir licença a um usuário

Adiciona uma licença ao usuário usando o SKU do tenant.

~~~powershell
$sku = Get-MgSubscribedSku | Where-Object { $_.SkuPartNumber -eq "ENTERPRISEPACK" }

Set-MgUserLicense -UserId "usuario@empresa.com.br" `
    -AddLicenses @{ SkuId = $sku.SkuId } `
    -RemoveLicenses @()
~~~

## Remover licença de um usuário

Remove uma licença específica do usuário.

~~~powershell
$sku = Get-MgSubscribedSku | Where-Object { $_.SkuPartNumber -eq "ENTERPRISEPACK" }

Set-MgUserLicense -UserId "usuario@empresa.com.br" `
    -AddLicenses @() `
    -RemoveLicenses @($sku.SkuId)
~~~

## Listar usuários com uma licença específica

Ajuda a encontrar quem está usando determinado produto.

~~~powershell
$sku = Get-MgSubscribedSku | Where-Object { $_.SkuPartNumber -eq "ENTERPRISEPACK" }

Get-MgUser -All -Property "displayName,userPrincipalName,assignedLicenses" |
Where-Object { $_.AssignedLicenses.SkuId -contains $sku.SkuId } |
Select-Object DisplayName, UserPrincipalName
~~~

## Exportar relatório de licenças disponíveis

Cria uma planilha com consumo de licenças do tenant.

~~~powershell
Get-MgSubscribedSku |
Select-Object SkuPartNumber, SkuId, ConsumedUnits,
@{Name="Total";Expression={$_.PrepaidUnits.Enabled}},
@{Name="Disponivel";Expression={$_.PrepaidUnits.Enabled - $_.ConsumedUnits}} |
Export-Csv "C:\Temp\licencas_m365.csv" -NoTypeInformation -Encoding UTF8
~~~

## Observação sobre nomes de licença

O nome técnico da licença aparece em `SkuPartNumber`, por exemplo `ENTERPRISEPACK` para Microsoft 365 E3 em muitos tenants.
