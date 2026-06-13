// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: '2025-07-15',
  devtools: { enabled: true },
  modules: [
    '@nuxtjs/tailwindcss',
    '@nuxt/icon'
  ],
  runtimeConfig: {
    public: {
      geminiApiKey: process.env.GEMINI_API_KEY || ''
    }
  }
})
