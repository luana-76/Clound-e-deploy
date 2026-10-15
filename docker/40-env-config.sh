#!/bin/sh
# Gera /env-config.js com as variáveis de ambiente em tempo de execução,
# permitindo configurar a URL da API pelo painel do Render sem rebuildar a imagem.
set -e
cat > /usr/share/nginx/html/env-config.js <<JS
window.__ENV__ = {
  VITE_API_URL: "${VITE_API_URL:-}"
};
JS
echo "[env-config] VITE_API_URL=${VITE_API_URL:-<não definida>}"
