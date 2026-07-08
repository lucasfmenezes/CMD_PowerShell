# Grupos no Active Directory

Comandos úteis para consulta e administração de grupos no AD.

## Listar todos os grupos

Mostra os grupos existentes no domínio.

~~~powershell
Get-ADGroup -Filter * |
Select-Object Name, SamAccountName, GroupCategory, GroupScope
~~~

## Buscar grupo pelo nome

Ajuda a localizar grupos usando parte do nome.

~~~powershell
Get-ADGroup -Filter "Name -like '*VPN*'"
~~~

## Ver detalhes de um grupo

Mostra informações completas de um grupo específico.

~~~powershell
Get-ADGroup -Identity "NomeDoGrupo" -Properties *
~~~

## Ver membros de um grupo

Lista usuários, computadores ou grupos que são membros diretos.

~~~powershell
Get-ADGroupMember -Identity "NomeDoGrupo"
~~~

## Ver membros de um grupo de forma recursiva

Inclui membros que estão dentro de grupos aninhados.

~~~powershell
Get-ADGroupMember -Identity "NomeDoGrupo" -Recursive |
Select-Object Name, SamAccountName, ObjectClass
~~~

## Exportar membros de um grupo

Gera um CSV com os membros de um grupo.

~~~powershell
Get-ADGroupMember -Identity "NomeDoGrupo" -Recursive |
Select-Object Name, SamAccountName, ObjectClass |
Export-Csv "C:\Temp\membros_grupo.csv" -NoTypeInformation -Encoding UTF8
~~~

## Ver grupos de um usuário

Mostra os grupos em que o usuário está associado.

~~~powershell
Get-ADPrincipalGroupMembership -Identity "usuario.login" |
Select-Object Name, GroupCategory, GroupScope
~~~

## Adicionar usuário a um grupo

Inclui um usuário como membro de um grupo.

~~~powershell
Add-ADGroupMember -Identity "NomeDoGrupo" -Members "usuario.login"
~~~

## Remover usuário de um grupo

Remove um usuário de um grupo sem pedir confirmação.

~~~powershell
Remove-ADGroupMember -Identity "NomeDoGrupo" -Members "usuario.login" -Confirm:$false
~~~

## Criar grupo de segurança global

Cria um grupo comum para controle de acesso.

~~~powershell
New-ADGroup `
    -Name "GRP-Sistema-Acesso" `
    -SamAccountName "GRP-Sistema-Acesso" `
    -GroupCategory Security `
    -GroupScope Global `
    -Path "OU=Grupos,DC=empresa,DC=local" `
    -Description "Grupo de acesso ao sistema"
~~~

## Criar grupo de distribuição

Cria um grupo usado para distribuição de mensagens.

~~~powershell
New-ADGroup `
    -Name "DL-Comunicados" `
    -SamAccountName "DL-Comunicados" `
    -GroupCategory Distribution `
    -GroupScope Global `
    -Path "OU=Grupos,DC=empresa,DC=local" `
    -Description "Lista de distribuição para comunicados"
~~~

## Ver grupos administrativos importantes

Ajuda a revisar grupos sensíveis do domínio.

~~~powershell
$grupos = @(
    "Domain Admins",
    "Enterprise Admins",
    "Schema Admins",
    "Administrators"
)

foreach ($grupo in $grupos) {
    Get-ADGroupMember -Identity $grupo -Recursive |
    Select-Object @{Name="Grupo";Expression={$grupo}}, Name, SamAccountName, ObjectClass
}
~~~

## Comparar membros entre dois grupos

Ajuda a ver diferenças entre grupos parecidos.

~~~powershell
$grupoA = Get-ADGroupMember "GrupoA" -Recursive | Select-Object -ExpandProperty SamAccountName
$grupoB = Get-ADGroupMember "GrupoB" -Recursive | Select-Object -ExpandProperty SamAccountName

Compare-Object $grupoA $grupoB
~~~
