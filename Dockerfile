# ─────────────────────────────────────────────
#  Dockerfile — Landing Aura Web (static site)
#  Serve con Nginx en Coolify
# ─────────────────────────────────────────────
FROM nginx:alpine

# Instalar bash (requerido por Coolify)
RUN apk add --no-cache bash

# Elimina la pagina por defecto de Nginx
RUN rm -rf /usr/share/nginx/html/*

# Copia todo el sitio estatico al directorio de Nginx
COPY . /usr/share/nginx/html

# Configuracion de Nginx embebida (puerto 3000, gzip, cache)
RUN printf 'server {\n\
    listen 3000;\n\
    server_name _;\n\
    root /usr/share/nginx/html;\n\
    index index.html;\n\
    gzip on;\n\
    gzip_types text/plain text/css application/json application/javascript text/xml application/xml image/svg+xml;\n\
    location ~* \.(jpg|jpeg|png|gif|ico|svg|webp|woff|woff2|ttf|css|js)$ {\n\
        expires 1y;\n\
        add_header Cache-Control "public, immutable";\n\
    }\n\
    location / {\n\
        try_files \ \/ /index.html;\n\
    }\n\
}\n' > /etc/nginx/conf.d/default.conf

EXPOSE 3000

CMD ["nginx", "-g", "daemon off;"]
