FROM nginx:1.15.5

COPY default.conf /etc/nginx/conf.d/default.conf
COPY nginx.conf .htpasswd /etc/nginx/
COPY certs/ /etc/nginx/

EXPOSE 8141
