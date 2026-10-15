# ---------- Estágio 1: build do Vite ----------
FROM node:22-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
# Usa "vite build" direto; o typecheck roda no desenvolvimento (npm run typecheck)
RUN npx vite build

# ---------- Estágio 2: nginx servindo os estáticos ----------
FROM nginx:1.27-alpine
# Render injeta PORT (padrão 10000); localmente usamos 80
ENV PORT=80
ENV VITE_API_URL=""
COPY docker/default.conf.template /etc/nginx/templates/default.conf.template
COPY docker/40-env-config.sh /docker-entrypoint.d/40-env-config.sh
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
