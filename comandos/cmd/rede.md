# CMD - Rede

Comandos úteis para diagnóstico de rede no Windows.

## Ver configuração completa de rede

Mostra IP, gateway, DNS, MAC Address e detalhes das interfaces.

~~~cmd
ipconfig /all
~~~

## Ver configuração resumida de rede

Mostra os endereços IP principais das interfaces.

~~~cmd
ipconfig
~~~

## Limpar cache DNS local

Remove registros DNS antigos armazenados na máquina.

~~~cmd
ipconfig /flushdns
~~~

## Renovar registro DNS da máquina

Força a máquina a tentar registrar novamente seus dados no DNS.

~~~cmd
ipconfig /registerdns
~~~

## Liberar endereço IP via DHCP

Solta o endereço IP recebido por DHCP.

~~~cmd
ipconfig /release
~~~

## Renovar endereço IP via DHCP

Pede um novo endereço IP ao servidor DHCP.

~~~cmd
ipconfig /renew
~~~

## Testar conectividade básica

Testa se um host responde ICMP.

~~~cmd
ping 8.8.8.8
~~~

## Testar conectividade com nome DNS

Ajuda a validar rede e resolução de nome ao mesmo tempo.

~~~cmd
ping google.com
~~~

## Testar rota até um destino

Mostra por quais saltos o pacote passa até chegar ao destino.

~~~cmd
tracert google.com
~~~

## Resolver nome DNS

Consulta o DNS para descobrir o IP de um nome.

~~~cmd
nslookup google.com
~~~

## Consultar um domínio interno

Ajuda a testar se o DNS interno está resolvendo o domínio.

~~~cmd
nslookup empresa.local
~~~

## Consultar um servidor específico

Força a consulta DNS usando um servidor DNS específico.

~~~cmd
nslookup empresa.local 192.168.1.10
~~~

## Ver tabela de rotas

Mostra as rotas conhecidas pela máquina.

~~~cmd
route print
~~~

## Adicionar rota temporária

Adiciona uma rota que será perdida ao reiniciar a máquina.

~~~cmd
route add 10.10.0.0 mask 255.255.0.0 192.168.1.1
~~~

## Adicionar rota persistente

Adiciona uma rota que continua existindo após reiniciar.

~~~cmd
route -p add 10.10.0.0 mask 255.255.0.0 192.168.1.1
~~~

## Remover rota

Remove uma rota da tabela de roteamento.

~~~cmd
route delete 10.10.0.0
~~~

## Ver conexões de rede ativas

Mostra conexões TCP, UDP e portas em uso.

~~~cmd
netstat -ano
~~~

## Ver portas em escuta

Ajuda a descobrir quais serviços estão ouvindo conexões.

~~~cmd
netstat -ano | findstr LISTENING
~~~

## Ver conexões de uma porta específica

Ajuda a encontrar qual processo está usando uma porta.

~~~cmd
netstat -ano | findstr :443
~~~

## Descobrir processo por PID

Usado depois do netstat para identificar o processo dono da conexão.

~~~cmd
tasklist /fi "PID eq 1234"
~~~

## Ver cache ARP

Mostra os IPs e MACs conhecidos pela máquina.

~~~cmd
arp -a
~~~

## Limpar cache ARP

Remove entradas ARP armazenadas localmente.

~~~cmd
arp -d *
~~~

## Ver nome da máquina

Mostra o hostname do computador.

~~~cmd
hostname
~~~

## Ver informações gerais do sistema

Mostra dados do Windows, domínio, hardware e hotfixes.

~~~cmd
systeminfo
~~~

## Testar porta com PowerShell pelo CMD

Útil porque o CMD não tem um comando nativo tão bom para teste de porta.

~~~cmd
powershell -Command "Test-NetConnection servidor.empresa.local -Port 443"
~~~

## Testar porta LDAP

Confirma se a máquina consegue chegar na porta LDAP do DC.

~~~cmd
powershell -Command "Test-NetConnection dc01.empresa.local -Port 389"
~~~

## Testar porta LDAPS

Confirma se a porta LDAPS está acessível.

~~~cmd
powershell -Command "Test-NetConnection dc01.empresa.local -Port 636"
~~~

## Testar porta SMB

Confirma se a porta de compartilhamento de arquivos está acessível.

~~~cmd
powershell -Command "Test-NetConnection servidor-arquivos.empresa.local -Port 445"
~~~

## Reiniciar pilha TCP/IP

Pode ajudar em problemas estranhos de rede no Windows.

~~~cmd
netsh int ip reset
~~~

## Resetar Winsock

Pode corrigir problemas de socket, proxy ou pilha de rede.

~~~cmd
netsh winsock reset
~~~

## Ver configuração de proxy WinHTTP

Mostra proxy configurado no contexto WinHTTP.

~~~cmd
netsh winhttp show proxy
~~~

## Remover proxy WinHTTP

Limpa proxy configurado no WinHTTP.

~~~cmd
netsh winhttp reset proxy
~~~

## Configurar proxy WinHTTP

Define proxy para aplicações que usam WinHTTP.

~~~cmd
netsh winhttp set proxy proxy-server="http://proxy.empresa.local:8080"
~~~
