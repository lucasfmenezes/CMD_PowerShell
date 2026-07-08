# Segurança

Cuidados básicos ao trabalhar com comandos, scripts, credenciais, arquivos CSV e automações.

## Não publicar dados reais

Evite subir para o GitHub qualquer arquivo com dados reais de usuários, servidores ou ambiente corporativo.

Exemplos de dados que não devem ser publicados:

- Nome completo de usuários reais.
- Matrículas reais.
- E-mails corporativos reais.
- IPs internos reais.
- Nome de servidores reais.
- Domínios internos reais.
- Tokens.
- Senhas.
- Chaves SSH privadas.
- Arquivos `.env`.
- Logs com informações sensíveis.

## Cuidado com arquivos CSV

CSV é muito usado em automações, mas pode conter dados sensíveis.

Antes de commitar, confira:

~~~bash
git diff
~~~

## Nunca subir chave privada SSH

A chave privada fica sem `.pub` e nunca deve ser compartilhada.

Exemplo de chave privada que não deve ir para o GitHub:

~~~text
~/.ssh/id_ed25519
~~~

A chave pública pode ser compartilhada e normalmente termina com `.pub`:

~~~text
~/.ssh/id_ed25519.pub
~~~

## Não salvar senha dentro de script

Evite isto:

~~~powershell
$Senha = "Senha123"
~~~

Prefira pedir a senha durante a execução:

~~~powershell
$Senha = Read-Host -AsSecureString "Digite a senha"
~~~

## Usar conta com menor privilégio possível

Não execute tudo com Domain Admin se uma conta com menos privilégio resolver.

## Testar em laboratório

Antes de rodar em produção, teste em um ambiente controlado.

## Cuidado com comandos em massa

Comandos como estes precisam ser revisados com atenção:

~~~powershell
Disable-ADAccount
Remove-ADUser
Remove-ADGroupMember
Set-ADUser
Update-MgUser
Set-MgUserLicense
~~~

## Usar WhatIf quando possível

O `-WhatIf` mostra o que aconteceria, sem aplicar a mudança.

~~~powershell
Disable-ADAccount -Identity "usuario.login" -WhatIf
~~~

## Conferir o tenant antes de alterar Entra ID

Antes de alterar usuários no Entra ID, confira onde você está conectado.

~~~powershell
Get-MgContext
~~~

## Conferir o domínio antes de alterar AD

Antes de alterar objetos no AD, confira o domínio.

~~~powershell
Get-ADDomain
~~~
