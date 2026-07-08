# Gera relatório de usuários inativos no Active Directory.
# Ajuste o TimeSpan conforme a política do ambiente.

Import-Module ActiveDirectory

$Dias = 90
$CaminhoSaida = "C:\Temp\usuarios_inativos_$Dias-dias.csv"

Search-ADAccount -UsersOnly -AccountInactive -TimeSpan "$Dias.00:00:00" |
Select-Object Name, SamAccountName, LastLogonDate, Enabled |
Export-Csv $CaminhoSaida -NoTypeInformation -Encoding UTF8

Write-Host "Relatório gerado em: $CaminhoSaida"
