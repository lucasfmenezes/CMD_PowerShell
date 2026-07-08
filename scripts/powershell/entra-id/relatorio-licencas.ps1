# Gera relatório de licenças disponíveis e consumidas no Microsoft 365.

Connect-MgGraph -Scopes "Organization.Read.All","Directory.Read.All"

$CaminhoSaida = "C:\Temp\relatorio_licencas_m365.csv"

Get-MgSubscribedSku |
Select-Object SkuPartNumber, SkuId, ConsumedUnits,
@{Name="Total";Expression={$_.PrepaidUnits.Enabled}},
@{Name="Disponivel";Expression={$_.PrepaidUnits.Enabled - $_.ConsumedUnits}} |
Export-Csv $CaminhoSaida -NoTypeInformation -Encoding UTF8

Write-Host "Relatório gerado em: $CaminhoSaida"
