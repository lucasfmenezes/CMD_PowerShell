# Cria usuários no Active Directory usando um arquivo CSV.
# CSV esperado: Nome,Sobrenome,SamAccountName,UPN,Email,Departamento,Cargo,EmployeeID,OU

Import-Module ActiveDirectory

$CaminhoCsv = "C:\Temp\usuarios_criacao.csv"
$Usuarios = Import-Csv $CaminhoCsv

$SenhaPadrao = Read-Host -AsSecureString "Digite a senha inicial dos usuários"

foreach ($Usuario in $Usuarios) {
    try {
        New-ADUser `
            -Name "$($Usuario.Nome) $($Usuario.Sobrenome)" `
            -GivenName $Usuario.Nome `
            -Surname $Usuario.Sobrenome `
            -DisplayName "$($Usuario.Nome) $($Usuario.Sobrenome)" `
            -SamAccountName $Usuario.SamAccountName `
            -UserPrincipalName $Usuario.UPN `
            -EmailAddress $Usuario.Email `
            -Department $Usuario.Departamento `
            -Title $Usuario.Cargo `
            -EmployeeID $Usuario.EmployeeID `
            -Path $Usuario.OU `
            -AccountPassword $SenhaPadrao `
            -Enabled $true `
            -ChangePasswordAtLogon $true `
            -ErrorAction Stop

        Write-Host "Usuário criado: $($Usuario.SamAccountName)" -ForegroundColor Green
    }
    catch {
        Write-Host "Erro ao criar $($Usuario.SamAccountName): $($_.Exception.Message)" -ForegroundColor Red
    }
}
