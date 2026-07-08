# Comandos de Microsoft Entra ID

Anotações rápidas de comandos úteis para administração do Microsoft Entra ID usando Microsoft Graph PowerShell.

O foco aqui é usar `Microsoft.Graph`, evitando depender dos módulos antigos `AzureAD` e `MSOnline`.

## Instalar Microsoft Graph PowerShell

Instala o módulo do Microsoft Graph para o usuário atual.

~~~powershell
Install-Module Microsoft.Graph -Scope CurrentUser
~~~

## Importar o módulo

Carrega os comandos do Microsoft Graph na sessão atual.

~~~powershell
Import-Module Microsoft.Graph
~~~

## Conectar com permissões de leitura

Usado quando você só precisa consultar usuários, grupos e diretório.

~~~powershell
Connect-MgGraph -Scopes "User.Read.All","Group.Read.All","Directory.Read.All"
~~~

## Conectar com permissões de alteração

Usado quando você precisa alterar usuários, grupos ou dados do diretório.

~~~powershell
Connect-MgGraph -Scopes "User.ReadWrite.All","Group.ReadWrite.All","Directory.ReadWrite.All"
~~~

## Ver contexto atual

Mostra em qual tenant e conta você está conectado.

~~~powershell
Get-MgContext
~~~

## Desconectar do Microsoft Graph

Encerra a sessão autenticada no Microsoft Graph.

~~~powershell
Disconnect-MgGraph
~~~

## Ver perfil usado pelo Graph

Mostra o perfil de API usado na sessão atual.

~~~powershell
Get-MgProfile
~~~

## Observação importante

Em ambientes híbridos, alguns atributos podem vir do AD local. Nesse caso, a alteração correta geralmente deve ser feita no Active Directory local e depois sincronizada para o Entra ID.
