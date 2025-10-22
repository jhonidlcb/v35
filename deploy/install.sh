
#!/bin/bash

# Script de instalación automatizado para SoftwarePar en VPS Ubuntu 24.04
# Compatible con aaPanel y Nginx preinstalado

set -e  # Detener en caso de error

echo "============================================"
echo "🚀 SoftwarePar - Instalación Automatizada"
echo "============================================"
echo ""

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Función para imprimir mensajes
print_message() {
    echo -e "${GREEN}[$(date +'%Y-%m-%d %H:%M:%S')]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[ADVERTENCIA]${NC} $1"
}

# Verificar que se ejecuta como root
if [ "$EUID" -ne 0 ]; then 
    print_error "Este script debe ejecutarse como root (sudo)"
    exit 1
fi

print_message "Actualizando sistema..."
apt update -y
apt upgrade -y

# ===================================
# 1. INSTALAR NODE.JS 20.x LTS
# ===================================
print_message "Instalando Node.js 20.x LTS..."

# Eliminar versiones antiguas de Node.js si existen
apt remove -y nodejs npm 2>/dev/null || true

# Agregar repositorio de NodeSource para Node.js 20.x
curl -fsSL https://deb.nodesource.com/setup_20.x | bash -

# Instalar Node.js
apt install -y nodejs

# Verificar instalación
NODE_VERSION=$(node --version)
NPM_VERSION=$(npm --version)
print_message "✅ Node.js ${NODE_VERSION} instalado"
print_message "✅ npm ${NPM_VERSION} instalado"

# ===================================
# 2. INSTALAR POSTGRESQL 16
# ===================================
print_message "Instalando PostgreSQL 16..."

# Agregar repositorio oficial de PostgreSQL
sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

# Actualizar e instalar PostgreSQL 16
apt update -y
apt install -y postgresql-16 postgresql-contrib-16

# Iniciar y habilitar PostgreSQL
systemctl start postgresql
systemctl enable postgresql

print_message "✅ PostgreSQL 16 instalado y configurado"

# Configurar usuario y base de datos de PostgreSQL
print_message "Configurando base de datos PostgreSQL..."

# Generar contraseña segura
DB_PASSWORD=$(openssl rand -base64 32)

# Crear usuario y base de datos
sudo -u postgres psql <<EOF
CREATE USER softwarepar WITH ENCRYPTED PASSWORD '${DB_PASSWORD}';
CREATE DATABASE softwarepar OWNER softwarepar;
GRANT ALL PRIVILEGES ON DATABASE softwarepar TO softwarepar;
\q
EOF

print_message "✅ Base de datos 'softwarepar' creada"
print_message "Usuario: softwarepar"
print_message "Contraseña guardada en: /root/softwarepar_db_credentials.txt"

# Guardar credenciales
cat > /root/softwarepar_db_credentials.txt <<EOF
PostgreSQL Database Credentials
================================
Host: localhost
Port: 5432
Database: softwarepar
User: softwarepar
Password: ${DB_PASSWORD}

Database URL (para .env):
DATABASE_URL=postgresql://softwarepar:${DB_PASSWORD}@localhost:5432/softwarepar
EOF

chmod 600 /root/softwarepar_db_credentials.txt

# ===================================
# 3. INSTALAR PM2
# ===================================
print_message "Instalando PM2..."

npm install -g pm2

# Configurar PM2 para iniciar con el sistema
pm2 startup systemd -u root --hp /root
systemctl enable pm2-root

print_message "✅ PM2 instalado y configurado"

# ===================================
# 4. CREAR DIRECTORIOS Y PERMISOS
# ===================================
print_message "Configurando directorios..."

# Crear directorio de la aplicación (compatible con aaPanel)
APP_DIR="/www/wwwroot/softwarepar.lat"
mkdir -p ${APP_DIR}
mkdir -p ${APP_DIR}/logs

# Si estás usando aaPanel, ajustar permisos
chown -R www:www ${APP_DIR}
chmod -R 755 ${APP_DIR}

print_message "✅ Directorio de aplicación: ${APP_DIR}"

# ===================================
# 5. INSTALAR DEPENDENCIAS ADICIONALES
# ===================================
print_message "Instalando dependencias del sistema..."

apt install -y git curl wget build-essential openssl certbot python3-certbot-nginx

print_message "✅ Dependencias instaladas"

# ===================================
# 6. GENERAR ARCHIVO .env DE EJEMPLO
# ===================================
print_message "Generando archivo .env de ejemplo..."

JWT_SECRET=$(openssl rand -base64 64)

cat > ${APP_DIR}/.env.example <<EOF
# ===================================
# SoftwarePar - Variables de Entorno
# ===================================

# Entorno de ejecución
NODE_ENV=production
PORT=5000

# Base de Datos PostgreSQL
DATABASE_URL=postgresql://softwarepar:${DB_PASSWORD}@localhost:5432/softwarepar

# Seguridad JWT
JWT_SECRET=${JWT_SECRET}

# Configuración de Email (Gmail)
GMAIL_USER=tu_email@gmail.com
GMAIL_PASS=tu_app_password_de_gmail

# URL Base de la aplicación
BASE_URL=https://softwarepar.lat

# reCAPTCHA (Opcional)
RECAPTCHA_SECRET_KEY=tu_clave_secreta_recaptcha

# SIFEN - Facturación Electrónica Paraguay (Opcional)
SIFEN_ID_CSC=1
SIFEN_CSC=tu_codigo_de_seguridad_sifen
SIFEN_CERTIFICADO_PATH=/ruta/al/certificado.pfx
SIFEN_CERTIFICADO_PASSWORD=password_del_certificado
SIFEN_WSDL_URL=https://sifen-test.set.gov.py/de/ws/sync/recibe
SIFEN_AMBIENTE=test

# FacturaSend API (Opcional)
FACTURASEND_API_URL=https://api.facturasend.com.py
FACTURASEND_API_KEY=tu_api_key_de_facturasend
FACTURASEND_AMBIENTE=test
EOF

print_message "✅ Archivo .env.example creado"

# ===================================
# 7. RESUMEN DE INSTALACIÓN
# ===================================
echo ""
echo "============================================"
echo "✅ INSTALACIÓN COMPLETADA EXITOSAMENTE"
echo "============================================"
echo ""
print_message "Componentes instalados:"
echo "  ✓ Node.js ${NODE_VERSION}"
echo "  ✓ npm ${NPM_VERSION}"
echo "  ✓ PostgreSQL 16"
echo "  ✓ PM2 (Process Manager)"
echo ""
print_message "Directorio de aplicación: ${APP_DIR}"
echo ""
print_message "PRÓXIMOS PASOS:"
echo ""
echo "1. Subir tu código a: ${APP_DIR}"
echo ""
echo "2. Configurar variables de entorno:"
echo "   cd ${APP_DIR}"
echo "   cp .env.example .env"
echo "   nano .env  # Editar con tus credenciales reales"
echo ""
echo "3. Instalar dependencias:"
echo "   npm install"
echo ""
echo "4. Ejecutar migraciones de base de datos:"
echo "   npm run db:push"
echo ""
echo "5. Compilar la aplicación:"
echo "   npm run build"
echo ""
echo "6. Iniciar con PM2:"
echo "   pm2 start dist/index.js --name softwarepar"
echo "   pm2 save"
echo ""
echo "7. Configurar Nginx (ver archivo nginx.conf)"
echo ""
print_warning "Credenciales de PostgreSQL guardadas en:"
echo "   /root/softwarepar_db_credentials.txt"
echo ""
echo "============================================"
