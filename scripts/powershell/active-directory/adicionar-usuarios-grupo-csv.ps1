# Adiciona usuários em grupos do Active Directory usando CSV.
# CSV esperado: SamAccountName,Grupo

Import-Module ActiveDirectory

$CaminhoCsv = "C:\Temp\grupos.csv"
$Linhas = Import-Csv $CaminhoCsv

foreach ($Linha in $Linhas) {
    try {
        Add-ADGroupMember -Identity $Linha.Grupo -Members $Linha.SamAccountName -ErrorAction Stop
        Write-Host "Adicionado $($Linha.SamAccountName) em $($Linha.Grupo)" -ForegroundColor Green
    }
    catch {
        Write-Host "Erro ao adicionar $($Linha.SamAccountName) em $($Linha.Grupo): $($_.Exception.Message)" -ForegroundColor Red
    }
}
