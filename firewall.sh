#!/bin/bash
# Limpar regras pré existentes
iptables -F
iptables -t nat -F
iptables -t mangle -F
# Proteção contra port scanners ocultos
iptables -A INPUT -p tcp --tcp-flags SYN,ACK,FIN,RST RST -m limit --limit 1/s -j ACCEPT
# Defesa: syncookies (evita ataques de DoS "Negação de Serviço")
echo 1 > /proc/sys/net/ipv4/tcp_syncookies
# Defesa: rpfilter (evita ataque de spoofing "falsificação de ip")
echo 1 > /proc/sys/net/ipv4/conf/default/rp_filter
# Elimina pacote invalidos (evita diversos tipos de ataques)
iptables -A INPUT -m state --state INVALID -j DROP
# Liberando o acesso a interface loopback:
iptables -A INPUT -p tcp -i lo -j ACCEPT
# Carregando o modulo correspondente
modprobe iptable_nat
#Regra
iptables -t nat -A POSTROUTING -o enp0s3 -j MASQUERADE
# Ativando o módulo ip_forward
echo 1 > /proc/sys/net/ipv4/ip_forward
# Liberando DNS
iptables -A INPUT -p tcp --dport 53 -j ACCEPT
iptables -A INPUT -p udp --dport 53 -j ACCEPT
# Liberando HTTP e HTTPS:
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
# Libera o envio e o recebimento de email . Obs Verificar portas junto ao provedor
iptables -A INPUT -p tcp --dport 110 -j ACCEPT
iptables -A INPUT -p tcp --dport 25 -j ACCEPT
# Liberando o acesso remoto via SSH:
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
# Bloqueia as portas UDP de 0 a 1023 (com exceção das abertas acima):
iptables -A INPUT -p udp --dport 0:1023 -j DROP
# Bloqueia conexões nas demais portas
iptables -A INPUT -p tcp --syn -j DROP
