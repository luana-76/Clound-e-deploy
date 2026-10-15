/**
 * Ponto único de leitura das variáveis de ambiente.
 * Para trocar a URL da API, altere apenas VITE_API_URL no arquivo .env.
 */
declare global {
  interface Window {
    __ENV__?: { VITE_API_URL?: string };
  }
}

// Em produção (Docker/Render) o valor vem de /env-config.js, gerado na inicialização
// do container a partir da variável de ambiente VITE_API_URL. Em desenvolvimento,
// vem do .env do Vite.
const rawApiUrl = window.__ENV__?.VITE_API_URL || import.meta.env.VITE_API_URL;

if (!rawApiUrl) {
  console.warn('[config] VITE_API_URL não definida no .env — usando http://localhost:3000');
}

export const env = {
  apiUrl: (rawApiUrl || 'http://localhost:3000').replace(/\/+$/, ''),
};
