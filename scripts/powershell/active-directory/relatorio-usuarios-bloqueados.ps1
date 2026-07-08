# Gera relatório de usuários bloqueados no Active Directory.
# Útil para rotina de suporte e troubleshooting de senha.

Import-Module ActiveDirectory

$Data = Get-Date -Format "yyyy-MM-dd_HH-mm"
$CaminhoSaida = "C:\Temp\usuarios_bloqueados_$Data.csv"

Search-ADAccount -LockedOut -UsersOnly |
Select-Object Name, SamAccountName, LockedOut |
Export-Csv $CaminhoSaida -NoTypeInformation -Encoding UTF8

Write-Host "Relatório gerado em: $CaminhoSaida"
