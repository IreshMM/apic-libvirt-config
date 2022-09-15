#!/bin/bash

iptables -t nat -I POSTROUTING 1 -s 192.168.72.0/25 -d 172.22.10.0/25 -j ACCEPT
iptables -t nat -I POSTROUTING 1 -s 192.168.72.0/25 -d 172.22.10.128/25 -j ACCEPT
iptables -t nat -I POSTROUTING 1 -s 192.168.72.0/25 -d 10.1.2.0/24 -j ACCEPT

iptables -t nat -I POSTROUTING 1 -s 172.22.10.0/25 -d 192.168.72.0/25 -j ACCEPT
iptables -t nat -I POSTROUTING 1 -s 172.22.10.0/25 -d 172.22.10.128/25  -j ACCEPT
iptables -t nat -I POSTROUTING 1 -s 172.22.10.0/25 -d 10.1.2.0/24  -j ACCEPT

iptables -t nat -I POSTROUTING 1 -s 172.22.10.128/25 -d 192.168.72.0/25  -j ACCEPT
iptables -t nat -I POSTROUTING 1 -s 172.22.10.128/25 -d 172.22.10.0/25  -j ACCEPT
iptables -t nat -I POSTROUTING 1 -s 172.22.10.128/25 -d 10.1.2.0/24  -j ACCEPT

iptables -t nat -I POSTROUTING 1 -s 10.1.2.0/24 -d 192.168.72.0/25  -j ACCEPT
iptables -t nat -I POSTROUTING 1 -s 10.1.2.0/24 -d 172.22.10.0/25  -j ACCEPT
iptables -t nat -I POSTROUTING 1 -s 10.1.2.0/24 -d 172.22.10.128/25 -j ACCEPT


iptables -I FORWARD 1 -s 192.168.72.0/25 -d 172.22.10.0/25 -j ACCEPT
iptables -I FORWARD 1 -s 192.168.72.0/25 -d 172.22.10.128/25 -j ACCEPT
iptables -I FORWARD 1 -s 192.168.72.0/25 -d 10.1.2.0/24 -j ACCEPT

iptables -I FORWARD 1 -s 172.22.10.0/25 -d 192.168.72.0/25 -j ACCEPT
iptables -I FORWARD 1 -s 172.22.10.0/25 -d 172.22.10.128/25  -j ACCEPT
iptables -I FORWARD 1 -s 172.22.10.0/25 -d 10.1.2.0/24  -j ACCEPT

iptables -I FORWARD 1 -s 172.22.10.128/25 -d 192.168.72.0/25  -j ACCEPT
iptables -I FORWARD 1 -s 172.22.10.128/25 -d 172.22.10.0/25  -j ACCEPT
iptables -I FORWARD 1 -s 172.22.10.128/25 -d 10.1.2.0/24  -j ACCEPT

iptables -I FORWARD 1 -s 10.1.2.0/24 -d 192.168.72.0/25 -j ACCEPT
iptables -I FORWARD 1 -s 10.1.2.0/24 -d 172.22.10.128/25  -j ACCEPT
iptables -I FORWARD 1 -s 10.1.2.0/24 -d 172.22.10.0/25  -j ACCEPT
