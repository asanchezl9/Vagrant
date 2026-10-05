#!/bin/bash
apt update
apt install -y apache2
systemctl enable apache2
systemctl start apache2
echo "Servidor Apache - Amparo Sánchez Ledo - debian-amparo" > /var/www/html/index.html