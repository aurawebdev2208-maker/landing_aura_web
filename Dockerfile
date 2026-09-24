# ─────────────────────────────────────────────
#  Dockerfile — Landing Aura Web (static site)
#  Serve con Nginx en Coolify
# ─────────────────────────────────────────────
FROM nginx:alpine

# Instalar bash (requerido por Coolify) y dos2unix
RUN apk add --no-cache bash dos2unix

# Elimina la pagina por defecto de Nginx
RUN rm -rf /usr/share/nginx/html/*

# Copia todo el sitio estatico al directorio de Nginx
COPY . /usr/share/nginx/html

# Copia la configuracion de Nginx y normaliza saltos de linea
COPY nginx.conf /etc/nginx/conf.d/default.conf
RUN dos2unix /etc/nginx/conf.d/default.conf

# Verificar que la config de nginx es valida
RUN nginx -t

EXPOSE 3000

CMD ["nginx", "-g", "daemon off;"]