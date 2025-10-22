
module.exports = {
  apps: [
    {
      name: 'softwarepar',
      script: './dist/index.js',
      cwd: '/www/wwwroot/softwarepar.lat',
      
      // Configuración de ejecución
      instances: 1,
      exec_mode: 'fork',
      
      // Variables de entorno
      env: {
        NODE_ENV: 'production',
        PORT: 5000
      },
      
      // Logs
      error_file: '/www/wwwroot/softwarepar.lat/logs/error.log',
      out_file: '/www/wwwroot/softwarepar.lat/logs/out.log',
      log_file: '/www/wwwroot/softwarepar.lat/logs/combined.log',
      time: true,
      
      // Auto-restart
      autorestart: true,
      max_restarts: 10,
      min_uptime: '10s',
      max_memory_restart: '500M',
      
      // Watch (deshabilitado en producción)
      watch: false,
      
      // Configuración de cluster (opcional)
      // instances: 'max',
      // exec_mode: 'cluster',
      
      // Kill timeout
      kill_timeout: 5000,
      
      // Wait ready
      wait_ready: true,
      listen_timeout: 10000,
      
      // Merge logs
      merge_logs: true,
      
      // Log date format
      log_date_format: 'YYYY-MM-DD HH:mm:ss Z'
    }
  ]
};
