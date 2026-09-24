# ─────────────────────────────────────────────
#  Dockerfile — Landing Aura Web (static site)
#  Serve con Nginx en Coolify
# ─────────────────────────────────────────────
FROM nginx:alpine

# Instalar bash (requerido por Coolify para health checks)
RUN apk add --no-cache bash

# Elimina la pagina por defecto de Nginx
RUN rm -rf /usr/share/nginx/html/*

# Copia todo el sitio estatico al directorio de Nginx
COPY . /usr/share/nginx/html

# Copia la configuracion personalizada de Nginx (puerto 3000)
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 3000

CMD ["nginx", "-g", "daemon off;"]
