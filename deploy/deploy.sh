
#!/bin/bash

# Script de despliegue completo para SoftwarePar en VPS

set -e

echo "============================================"
echo "🚀 SoftwarePar - Script de Despliegue"
echo "============================================"

# Colores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

print_message() {
    echo -e "${GREEN}[$(date +'%H:%M:%S')]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Variables
APP_DIR="/www/wwwroot/softwarepar.lat"
APP_NAME="softwarepar"

# Verificar que estamos en el directorio correcto
if [ ! -f "package.json" ]; then
    print_error "package.json no encontrado. ¿Estás en el directorio de la aplicación?"
    exit 1
fi

print_message "Iniciando despliegue en: ${APP_DIR}"

# 1. Detener aplicación si está corriendo
print_message "Deteniendo aplicación actual..."
pm2 stop ${APP_NAME} 2>/dev/null || true

# 2. Hacer backup del directorio actual
print_message "Creando backup..."
BACKUP_DIR="${APP_DIR}_backup_$(date +%Y%m%d_%H%M%S)"
cp -r ${APP_DIR} ${BACKUP_DIR} 2>/dev/null || true

# 3. Limpiar archivos de build anteriores
print_message "Limpiando archivos de build anteriores..."
rm -rf dist/

# 4. Instalar dependencias
print_message "Instalando dependencias..."
npm ci --production=false

# 5. Ejecutar migraciones de base de datos
print_message "Ejecutando migraciones de base de datos..."
npm run db:push || print_warning "Advertencia: Error en migraciones (puede ser normal si ya están aplicadas)"

# 6. Compilar aplicación
print_message "Compilando aplicación..."
npm run build

if [ ! -d "dist" ]; then
    print_error "Error: Directorio dist/ no fue creado"
    exit 1
fi

# 7. Verificar archivos críticos
print_message "Verificando archivos compilados..."
if [ ! -f "dist/index.js" ]; then
    print_error "Error: dist/index.js no encontrado"
    exit 1
fi

if [ ! -d "dist/public" ]; then
    print_error "Error: dist/public/ no encontrado"
    exit 1
fi

# 8. Ajustar permisos
print_message "Ajustando permisos..."
chown -R www:www ${APP_DIR}
chmod -R 755 ${APP_DIR}

# 9. Iniciar/Reiniciar con PM2
print_message "Iniciando aplicación con PM2..."

if pm2 describe ${APP_NAME} > /dev/null 2>&1; then
    # La aplicación ya existe, reiniciar
    pm2 restart ${APP_NAME}
else
    # Primera vez, iniciar con ecosystem.config.js
    pm2 start ecosystem.config.js
fi

# Guardar configuración de PM2
pm2 save

# 10. Verificar estado
print_message "Verificando estado de la aplicación..."
sleep 3
pm2 show ${APP_NAME}

# 11. Mostrar logs recientes
print_message "Logs recientes:"
pm2 logs ${APP_NAME} --lines 20 --nostream

echo ""
echo "============================================"
echo "✅ DESPLIEGUE COMPLETADO EXITOSAMENTE"
echo "============================================"
echo ""
print_message "Comandos útiles:"
echo "  Ver logs en tiempo real: pm2 logs ${APP_NAME}"
echo "  Ver estado: pm2 status"
echo "  Reiniciar: pm2 restart ${APP_NAME}"
echo "  Detener: pm2 stop ${APP_NAME}"
echo "  Ver métricas: pm2 monit"
echo ""
print_message "Backup guardado en: ${BACKUP_DIR}"
echo ""
