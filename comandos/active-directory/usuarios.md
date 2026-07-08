# Usuários no Active Directory

Comandos úteis para consultar, criar, alterar, bloquear, desbloquear e gerar relatórios de usuários no AD.

## Buscar um usuário pelo login

Consulta um usuário pelo `SamAccountName`.

~~~powershell
Get-ADUser -Identity "usuario.login"
~~~

## Buscar um usuário com todas as propriedades

Útil quando você quer descobrir o nome exato de algum atributo do usuário.

~~~powershell
Get-ADUser -Identity "usuario.login" -Properties *
~~~

## Buscar usuário pelo nome

Ajuda quando você não lembra exatamente o login do usuário.

~~~powershell
Get-ADUser -Filter "Name -like '*Lucas*'" | Select-Object Name, SamAccountName, Enabled
~~~

## Listar usuários ativos

Lista somente contas habilitadas no Active Directory.

~~~powershell
Get-ADUser -Filter "Enabled -eq 'True'" | Select-Object Name, SamAccountName, Enabled
~~~

## Listar usuários desativados

Lista contas de usuário que estão desabilitadas.

~~~powershell
Get-ADUser -Filter "Enabled -eq 'False'" | Select-Object Name, SamAccountName, Enabled
~~~

## Buscar usuário por e-mail

Consulta um usuário usando o atributo de e-mail.

~~~powershell
Get-ADUser -Filter "Mail -eq 'usuario@empresa.com.br'" -Properties Mail |
Select-Object Name, SamAccountName, Mail
~~~

## Ver o employeeID de um usuário

Mostra a matrícula ou identificador funcional gravado no atributo `employeeID`.

~~~powershell
Get-ADUser -Identity "usuario.login" -Properties employeeID |
Select-Object Name, SamAccountName, employeeID
~~~

## Buscar usuário pelo employeeID

Útil quando você tem a matrícula e precisa descobrir qual usuário está usando ela.

~~~powershell
Get-ADUser -Filter "employeeID -eq '123456'" -Properties employeeID |
Select-Object Name, SamAccountName, employeeID
~~~

## Alterar o employeeID

Atualiza o atributo `employeeID` de um usuário.

~~~powershell
Set-ADUser -Identity "usuario.login" -EmployeeID "123456"
~~~

## Limpar o employeeID

Remove o valor gravado no atributo `employeeID`.

~~~powershell
Set-ADUser -Identity "usuario.login" -Clear employeeID
~~~

## Alterar departamento

Atualiza o departamento cadastrado no usuário.

~~~powershell
Set-ADUser -Identity "usuario.login" -Department "Tecnologia da Informação"
~~~

## Alterar cargo

Atualiza o cargo cadastrado no usuário.

~~~powershell
Set-ADUser -Identity "usuario.login" -Title "Analista de Infraestrutura"
~~~

## Alterar e-mail

Atualiza o endereço de e-mail do usuário no AD.

~~~powershell
Set-ADUser -Identity "usuario.login" -EmailAddress "usuario@empresa.com.br"
~~~

## Alterar telefone

Atualiza o telefone comercial do usuário.

~~~powershell
Set-ADUser -Identity "usuario.login" -OfficePhone "3222-0000"
~~~

## Alterar várias informações do usuário

Bom para atualizar dados cadastrais de uma vez só.

~~~powershell
Set-ADUser -Identity "usuario.login" `
    -Department "TI" `
    -Title "Analista de Infraestrutura" `
    -Company "Empresa" `
    -EmployeeID "123456"
~~~

## Resetar senha

Altera a senha do usuário de forma administrativa.

~~~powershell
Set-ADAccountPassword -Identity "usuario.login" -Reset -NewPassword (Read-Host -AsSecureString "Nova senha")
~~~

## Forçar troca de senha no próximo logon

Faz o usuário trocar a senha quando entrar novamente.

~~~powershell
Set-ADUser -Identity "usuario.login" -ChangePasswordAtLogon $true
~~~

## Desbloquear usuário

Desbloqueia uma conta travada por tentativas inválidas de senha.

~~~powershell
Unlock-ADAccount -Identity "usuario.login"
~~~

## Listar usuários bloqueados

Mostra usuários que estão bloqueados no domínio.

~~~powershell
Search-ADAccount -LockedOut -UsersOnly |
Select-Object Name, SamAccountName
~~~

## Listar usuários com senha expirada

Ajuda a identificar usuários que precisam trocar a senha.

~~~powershell
Search-ADAccount -PasswordExpired -UsersOnly |
Select-Object Name, SamAccountName
~~~

## Listar usuários com conta expirada

Mostra contas que passaram da data de expiração.

~~~powershell
Search-ADAccount -AccountExpired -UsersOnly |
Select-Object Name, SamAccountName
~~~

## Desativar usuário

Desabilita uma conta de usuário no AD.

~~~powershell
Disable-ADAccount -Identity "usuario.login"
~~~

## Ativar usuário

Habilita novamente uma conta de usuário.

~~~powershell
Enable-ADAccount -Identity "usuario.login"
~~~

## Mover usuário para outra OU

Move o objeto do usuário para outra unidade organizacional.

~~~powershell
Get-ADUser -Identity "usuario.login" |
Move-ADObject -TargetPath "OU=Desligados,DC=empresa,DC=local"
~~~

## Exportar usuários ativos para CSV

Gera uma planilha simples com os usuários ativos do domínio.

~~~powershell
Get-ADUser -Filter "Enabled -eq 'True'" -Properties Mail, Department, Title, employeeID |
Select-Object Name, SamAccountName, Mail, Department, Title, employeeID |
Export-Csv "C:\Temp\usuarios_ativos.csv" -NoTypeInformation -Encoding UTF8
~~~

## Listar usuários sem employeeID

Ajuda a encontrar usuários sem matrícula preenchida.

~~~powershell
Get-ADUser -Filter * -Properties employeeID |
Where-Object { [string]::IsNullOrWhiteSpace($_.employeeID) } |
Select-Object Name, SamAccountName, employeeID
~~~

## Listar usuários sem e-mail

Ajuda a encontrar contas que estão sem e-mail cadastrado.

~~~powershell
Get-ADUser -Filter * -Properties Mail |
Where-Object { [string]::IsNullOrWhiteSpace($_.Mail) } |
Select-Object Name, SamAccountName, Mail
~~~

## Listar usuários inativos há mais de 90 dias

Bom para revisão de contas antigas ou sem uso.

~~~powershell
Search-ADAccount -UsersOnly -AccountInactive -TimeSpan 90.00:00:00 |
Select-Object Name, SamAccountName, LastLogonDate, Enabled
~~~

## Criar usuário básico

Cria uma conta simples no Active Directory.

~~~powershell
New-ADUser `
    -Name "Joao Silva" `
    -GivenName "Joao" `
    -Surname "Silva" `
    -SamAccountName "joao.silva" `
    -UserPrincipalName "joao.silva@empresa.local" `
    -Path "OU=Usuarios,DC=empresa,DC=local" `
    -AccountPassword (Read-Host -AsSecureString "Digite a senha") `
    -Enabled $true
~~~

## Criar usuário com dados cadastrais

Cria um usuário já preenchendo e-mail, cargo, departamento e matrícula.

~~~powershell
New-ADUser `
    -Name "Maria Souza" `
    -GivenName "Maria" `
    -Surname "Souza" `
    -DisplayName "Maria Souza" `
    -SamAccountName "maria.souza" `
    -UserPrincipalName "maria.souza@empresa.local" `
    -EmailAddress "maria.souza@empresa.com.br" `
    -Department "TI" `
    -Title "Analista de Infraestrutura" `
    -Company "Empresa" `
    -EmployeeID "123456" `
    -Path "OU=Usuarios,DC=empresa,DC=local" `
    -AccountPassword (Read-Host -AsSecureString "Digite a senha") `
    -Enabled $true
~~~
