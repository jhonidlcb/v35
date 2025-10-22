
# 📦 Guía de Despliegue - SoftwarePar en VPS Ubuntu 24.04

Esta guía te ayudará a desplegar SoftwarePar en tu VPS Ubuntu 24.04 con aaPanel y Nginx.

## 📋 Prerrequisitos

- VPS con Ubuntu 24.04 LTS
- aaPanel instalado
- Nginx instalado (via aaPanel)
- Acceso root (sudo)
- Dominio apuntando al servidor (softwarepar.lat)

## 🚀 Instalación Inicial (Una sola vez)

### 1. Ejecutar script de instalación

```bash
# Hacer ejecutable el script
chmod +x deploy/install.sh

# Ejecutar como root
sudo ./deploy/install.sh
```

Este script instalará:
- ✅ Node.js 20.x LTS
- ✅ PostgreSQL 16
- ✅ PM2 (Process Manager)
- ✅ Dependencias del sistema

**IMPORTANTE:** Al finalizar, el script mostrará las credenciales de la base de datos. Guárdalas en un lugar seguro.

### 2. Subir el código al servidor

```bash
# Opción 1: Via Git (recomendado)
cd /www/wwwroot/softwarepar.lat
git clone https://tu-repositorio.git .

# Opción 2: Via FTP/SFTP
# Usa FileZilla o el File Manager de aaPanel
# Sube todos los archivos a /www/wwwroot/softwarepar.lat
```

### 3. Configurar variables de entorno

```bash
cd /www/wwwroot/softwarepar.lat

# Copiar ejemplo
cp .env.example .env

# Editar con tus credenciales reales
nano .env
```

**Variables críticas a configurar:**

```env
NODE_ENV=production
PORT=5000
DATABASE_URL=postgresql://softwarepar:TU_PASSWORD@localhost:5432/softwarepar
JWT_SECRET=TU_JWT_SECRET_GENERADO
GMAIL_USER=tu_email@gmail.com
GMAIL_PASS=tu_app_password
BASE_URL=https://softwarepar.lat
```

### 4. Configurar Nginx

```bash
# Hacer ejecutable
chmod +x deploy/setup-nginx.sh

# Ejecutar
sudo ./deploy/setup-nginx.sh
```

### 5. Configurar SSL con Let's Encrypt

**Opción A: Via aaPanel (Recomendado)**
1. Abrir aaPanel en tu navegador
2. Ir a "Website" > "softwarepar.lat"
3. Click en "SSL"
4. Seleccionar "Let's Encrypt"
5. Aplicar certificado

**Opción B: Via Terminal**
```bash
sudo certbot --nginx -d softwarepar.lat -d www.softwarepar.lat
```

### 6. Desplegar la aplicación

```bash
cd /www/wwwroot/softwarepar.lat

# Hacer ejecutable el script de deploy
chmod +x deploy/deploy.sh

# Ejecutar despliegue
sudo ./deploy/deploy.sh
```

## 🔄 Actualizaciones Posteriores

Para actualizar la aplicación después del despliegue inicial:

```bash
cd /www/wwwroot/softwarepar.lat

# Opción 1: Si usas Git
git pull origin main
sudo ./deploy/deploy.sh

# Opción 2: Si subes archivos manualmente
# 1. Sube los archivos nuevos via FTP/SFTP
# 2. Ejecuta:
sudo ./deploy/deploy.sh
```

## 📊 Comandos PM2 Útiles

```bash
# Ver estado de todas las aplicaciones
pm2 status

# Ver logs en tiempo real
pm2 logs softwarepar

# Ver logs de errores
pm2 logs softwarepar --err

# Reiniciar aplicación
pm2 restart softwarepar

# Detener aplicación
pm2 stop softwarepar

# Ver métricas de rendimiento
pm2 monit

# Ver información detallada
pm2 show softwarepar
```

## 🗄️ Gestión de Base de Datos

### Backup manual
```bash
# Crear backup
sudo -u postgres pg_dump softwarepar > backup_$(date +%Y%m%d).sql

# Restaurar backup
sudo -u postgres psql softwarepar < backup_20250117.sql
```

### Acceder a PostgreSQL
```bash
sudo -u postgres psql
\c softwarepar
\dt  # Listar tablas
```

## 🔍 Troubleshooting

### La aplicación no inicia

```bash
# Ver logs de PM2
pm2 logs softwarepar --lines 50

# Ver estado de PostgreSQL
sudo systemctl status postgresql

# Verificar puerto 5000
sudo netstat -tlnp | grep 5000
```

### Error de conexión a base de datos

```bash
# Verificar que PostgreSQL está corriendo
sudo systemctl status postgresql

# Reiniciar PostgreSQL
sudo systemctl restart postgresql

# Verificar credenciales en .env
cat /www/wwwroot/softwarepar.lat/.env | grep DATABASE_URL
```

### Error 502 Bad Gateway en Nginx

```bash
# Verificar que la app está corriendo
pm2 status

# Verificar logs de Nginx
tail -f /www/wwwlogs/softwarepar.lat.error.log

# Reiniciar Nginx
sudo systemctl restart nginx
```

### Puerto 5000 ya en uso

```bash
# Encontrar proceso usando puerto 5000
sudo lsof -i :5000

# Matar proceso
sudo kill -9 PID

# Reiniciar aplicación
pm2 restart softwarepar
```

## 🔐 Seguridad

### Firewall (UFW)

```bash
# Habilitar UFW
sudo ufw enable

# Permitir SSH
sudo ufw allow 22/tcp

# Permitir HTTP/HTTPS
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

# Ver estado
sudo ufw status
```

### Actualizaciones de seguridad

```bash
# Actualizar sistema regularmente
sudo apt update
sudo apt upgrade -y

# Actualizar Node.js packages
cd /www/wwwroot/softwarepar.lat
npm audit fix
```

## 📈 Monitoreo

### Configurar monitoreo automático

```bash
# PM2 Plus (opcional, servicio gratuito)
pm2 link YOUR_SECRET_KEY YOUR_PUBLIC_KEY

# Monitoreo básico con PM2
pm2 install pm2-logrotate
pm2 set pm2-logrotate:max_size 10M
pm2 set pm2-logrotate:retain 7
```

## 📞 Soporte

Si encuentras problemas:
1. Revisa los logs: `pm2 logs softwarepar`
2. Verifica la configuración de Nginx
3. Comprueba que todas las variables de entorno estén configuradas
4. Asegúrate de que PostgreSQL esté corriendo

## ✅ Checklist de Despliegue

- [ ] Script de instalación ejecutado
- [ ] Node.js 20.x instalado
- [ ] PostgreSQL 16 instalado y configurado
- [ ] PM2 instalado
- [ ] Código subido a `/www/wwwroot/softwarepar.lat`
- [ ] Archivo `.env` configurado con credenciales reales
- [ ] Nginx configurado
- [ ] SSL/HTTPS configurado
- [ ] Aplicación desplegada con PM2
- [ ] Dominio funcionando correctamente
- [ ] Base de datos migrada
- [ ] Backup configurado

---

**Versión:** 1.0.0  
**Última actualización:** Enero 2025
