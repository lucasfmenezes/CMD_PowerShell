# Testa conectividade TCP com base em um CSV.
# CSV esperado: Host,Porta

$CaminhoCsv = "C:\Temp\portas.csv"
$CaminhoSaida = "C:\Temp\resultado_portas.csv"

$Itens = Import-Csv $CaminhoCsv
$Resultado = @()

foreach ($Item in $Itens) {
    $Teste = Test-NetConnection $Item.Host -Port $Item.Porta -WarningAction SilentlyContinue

    $Resultado += [PSCustomObject]@{
        Host       = $Item.Host
        Porta      = $Item.Porta
        TcpTest    = $Teste.TcpTestSucceeded
        RemoteAddr = $Teste.RemoteAddress
    }

    Write-Host "$($Item.Host):$($Item.Porta) => $($Teste.TcpTestSucceeded)"
}

$Resultado | Export-Csv $CaminhoSaida -NoTypeInformation -Encoding UTF8

Write-Host "Relatório gerado em: $CaminhoSaida"
