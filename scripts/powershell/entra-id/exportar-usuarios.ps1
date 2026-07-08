# Exporta usuários do Microsoft Entra ID para CSV.
# Antes de executar, conecte com uma conta autorizada.

Connect-MgGraph -Scopes "User.Read.All","Directory.Read.All"

$CaminhoSaida = "C:\Temp\usuarios_entra.csv"

Get-MgUser -All -Property "id,displayName,userPrincipalName,mail,department,jobTitle,employeeId,accountEnabled" |
Select-Object DisplayName, UserPrincipalName, Mail, Department, JobTitle, EmployeeId, AccountEnabled |
Export-Csv $CaminhoSaida -NoTypeInformation -Encoding UTF8

Write-Host "Relatório gerado em: $CaminhoSaida"
