# Atualiza o employeeID de usuários do Active Directory usando um arquivo CSV.
# CSV esperado: SamAccountName,EmployeeID

Import-Module ActiveDirectory

$CaminhoCsv = "C:\Temp\usuarios_employeeid.csv"
$CaminhoResultado = "C:\Temp\resultado_employeeid.csv"

$Usuarios = Import-Csv $CaminhoCsv
$Resultado = @()

foreach ($Usuario in $Usuarios) {
    try {
        $ADUser = Get-ADUser -Identity $Usuario.SamAccountName -Properties employeeID -ErrorAction Stop

        Set-ADUser -Identity $ADUser.SamAccountName -EmployeeID $Usuario.EmployeeID

        $Resultado += [PSCustomObject]@{
            Usuario       = $Usuario.SamAccountName
            EmployeeIDOld = $ADUser.employeeID
            EmployeeIDNew = $Usuario.EmployeeID
            Status        = "Atualizado"
            Erro          = ""
        }

        Write-Host "Atualizado: $($Usuario.SamAccountName)" -ForegroundColor Green
    }
    catch {
        $Resultado += [PSCustomObject]@{
            Usuario       = $Usuario.SamAccountName
            EmployeeIDOld = ""
            EmployeeIDNew = $Usuario.EmployeeID
            Status        = "Erro"
            Erro          = $_.Exception.Message
        }

        Write-Host "Erro: $($Usuario.SamAccountName)" -ForegroundColor Red
    }
}

$Resultado | Export-Csv $CaminhoResultado -NoTypeInformation -Encoding UTF8

Write-Host "Relatório gerado em: $CaminhoResultado"
