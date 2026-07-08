# CMD - GPO

Comandos úteis para atualização, consulta e troubleshooting de Group Policy.

## Atualizar políticas de grupo

Força a aplicação das políticas de usuário e computador.

~~~cmd
gpupdate /force
~~~

## Atualizar somente políticas de usuário

Atualiza apenas as políticas aplicadas ao usuário.

~~~cmd
gpupdate /target:user /force
~~~

## Atualizar somente políticas de computador

Atualiza apenas as políticas aplicadas ao computador.

~~~cmd
gpupdate /target:computer /force
~~~

## Ver resultado resumido das GPOs

Mostra um resumo das políticas aplicadas.

~~~cmd
gpresult /r
~~~

## Ver GPOs aplicadas ao usuário

Mostra somente o resultado das políticas do usuário.

~~~cmd
gpresult /scope user /r
~~~

## Ver GPOs aplicadas ao computador

Mostra somente o resultado das políticas do computador.

~~~cmd
gpresult /scope computer /r
~~~

## Gerar relatório HTML de GPO

Cria um relatório mais fácil de ler no navegador.

~~~cmd
gpresult /h C:\Temp\gpresult.html
~~~

## Gerar relatório XML de GPO

Gera um relatório em XML para análise ou automação.

~~~cmd
gpresult /x C:\Temp\gpresult.xml
~~~

## Gerar relatório para outro usuário

Ajuda quando você precisa analisar GPO de outra conta.

~~~cmd
gpresult /user DOMINIO\usuario.login /r
~~~

## Gerar relatório remoto

Consulta resultado de GPO em outro computador.

~~~cmd
gpresult /s NOME-COMPUTADOR /r
~~~

## Gerar relatório HTML remoto

Cria relatório de GPO de uma máquina remota.

~~~cmd
gpresult /s NOME-COMPUTADOR /h C:\Temp\gpresult-remoto.html
~~~

## Aplicar GPO e reiniciar se necessário

Força atualização e permite reinicialização automática se a política exigir.

~~~cmd
gpupdate /force /boot
~~~

## Aplicar GPO e fazer logoff se necessário

Força atualização e permite logoff automático se a política exigir.

~~~cmd
gpupdate /force /logoff
~~~

## Abrir editor de política local

Abre o editor de política local da máquina.

~~~cmd
gpedit.msc
~~~

## Abrir console de GPO

Abre o console de gerenciamento de políticas de grupo.

~~~cmd
gpmc.msc
~~~

## Abrir usuários e computadores do AD

Ajuda quando o troubleshooting de GPO envolve OU e objetos do AD.

~~~cmd
dsa.msc
~~~

## Abrir sites e serviços do AD

Útil quando o problema envolve site, sub-rede ou DC errado.

~~~cmd
dssite.msc
~~~

## Abrir DNS

Ajuda quando GPO falha por problema de resolução de nomes.

~~~cmd
dnsmgmt.msc
~~~

## Abrir visualizador de eventos

Usado para investigar falhas de GPO.

~~~cmd
eventvwr.msc
~~~

## Listar eventos recentes de Group Policy

Busca eventos de política de grupo usando PowerShell chamado pelo CMD.

~~~cmd
powershell -Command "Get-WinEvent -LogName Microsoft-Windows-GroupPolicy/Operational -MaxEvents 20 | Select-Object TimeCreated, Id, Message"
~~~

## Ver SYSVOL do domínio

Ajuda a confirmar se o SYSVOL está acessível.

~~~cmd
dir \\empresa.local\SYSVOL
~~~

## Ver NETLOGON do domínio

Ajuda a confirmar se scripts e compartilhamento NETLOGON estão acessíveis.

~~~cmd
dir \\empresa.local\NETLOGON
~~~

## Testar acesso ao SYSVOL de um DC

Valida acesso direto ao compartilhamento SYSVOL em um DC específico.

~~~cmd
dir \\dc01.empresa.local\SYSVOL
~~~

## Testar resolução do domínio

Ajuda quando GPO não aplica por problema de DNS.

~~~cmd
nslookup empresa.local
~~~

## Testar descoberta de DC

Confirma se a máquina encontra um controlador de domínio.

~~~cmd
nltest /dsgetdc:empresa.local
~~~
