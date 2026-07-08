# Atualiza employeeId no Microsoft Entra ID usando CSV.
# CSV esperado: UserPrincipalName,EmployeeId
# Em ambiente híbrido, valide se o atributo deve ser alterado no AD local.

Connect-MgGraph -Scopes "User.ReadWrite.All","Directory.ReadWrite.All"

$CaminhoCsv = "C:\Temp\usuarios_entra_employeeid.csv"
$CaminhoResultado = "C:\Temp\resultado_entra_employeeid.csv"

$Usuarios = Import-Csv $CaminhoCsv
$Resultado = @()

foreach ($Usuario in $Usuarios) {
    try {
        Update-MgUser -UserId $Usuario.UserPrincipalName -BodyParameter @{
            employeeId = $Usuario.EmployeeId
        }

        $Resultado += [PSCustomObject]@{
            UserPrincipalName = $Usuario.UserPrincipalName
            EmployeeId        = $Usuario.EmployeeId
            Status            = "Atualizado"
            Erro              = ""
        }

        Write-Host "Atualizado: $($Usuario.UserPrincipalName)" -ForegroundColor Green
    }
    catch {
        $Resultado += [PSCustomObject]@{
            UserPrincipalName = $Usuario.UserPrincipalName
            EmployeeId        = $Usuario.EmployeeId
            Status            = "Erro"
            Erro              = $_.Exception.Message
        }

        Write-Host "Erro: $($Usuario.UserPrincipalName)" -ForegroundColor Red
    }
}

$Resultado | Export-Csv $CaminhoResultado -NoTypeInformation -Encoding UTF8

Write-Host "Relatório gerado em: $CaminhoResultado"
