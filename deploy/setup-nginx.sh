
#!/bin/bash

# Script para configurar Nginx en aaPanel para SoftwarePar

set -e

echo "============================================"
echo "⚙️  Configurando Nginx para SoftwarePar"
echo "============================================"

# Colores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_message() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[ADVERTENCIA]${NC} $1"
}

# Verificar que se ejecuta como root
if [ "$EUID" -ne 0 ]; then 
    echo "Este script debe ejecutarse como root (sudo)"
    exit 1
fi

# Variables
DOMAIN="softwarepar.lat"
NGINX_CONF="/www/server/panel/vhost/nginx/${DOMAIN}.conf"
APP_DIR="/www/wwwroot/${DOMAIN}"

print_message "Copiando configuración de Nginx..."

# Backup de configuración existente si existe
if [ -f "$NGINX_CONF" ]; then
    cp "$NGINX_CONF" "${NGINX_CONF}.backup.$(date +%Y%m%d_%H%M%S)"
    print_warning "Backup creado: ${NGINX_CONF}.backup"
fi

# Copiar nueva configuración
cp ./nginx.conf "$NGINX_CONF"

print_message "✅ Configuración de Nginx actualizada"

# Verificar sintaxis de Nginx
print_message "Verificando sintaxis de Nginx..."
nginx -t

if [ $? -eq 0 ]; then
    print_message "✅ Sintaxis de Nginx correcta"
    
    # Recargar Nginx
    print_message "Recargando Nginx..."
    systemctl reload nginx
    
    print_message "✅ Nginx recargado exitosamente"
else
    echo "❌ Error en la sintaxis de Nginx"
    echo "Restaurando backup..."
    cp "${NGINX_CONF}.backup" "$NGINX_CONF"
    exit 1
fi

echo ""
echo "============================================"
echo "✅ NGINX CONFIGURADO CORRECTAMENTE"
echo "============================================"
echo ""
print_message "IMPORTANTE:"
echo "  1. Asegúrate de tener un certificado SSL configurado"
echo "  2. Puedes usar Let's Encrypt desde el panel de aaPanel"
echo "  3. Si usas aaPanel, ajusta las rutas de certificados SSL en:"
echo "     ${NGINX_CONF}"
echo ""
