<template>
  <aside class="env-banner" :data-env="env">
    Environment: <strong>{{ env }}</strong>
    · API: {{ apiUrl }}
    · Build: {{ buildId }}
  </aside>
</template>

<script setup>
const env = import.meta.env.VITE_APP_ENV || 'dev'
const apiUrl = import.meta.env.VITE_API_URL || '/api'
const buildId = import.meta.env.VITE_BUILD_ID || 'local'
</script>

<style scoped>
.env-banner { background: #e3f2fd; padding: 0.5rem 1rem; font-size: 0.9rem; border-bottom: 1px solid #90caf9; }
.env-banner[data-env="production"] { background: #e8f5e9; border-color: #81c784; }
</style>