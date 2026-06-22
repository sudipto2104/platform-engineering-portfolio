<template>
  <div class="app">
    <EnvBanner />
    <AppHeader />
    <main><RouterView /></main>
  </div>
</template>

<script setup>
import AppHeader from './components/AppHeader.vue'
import EnvBanner from './components/EnvBanner.vue'
</script>

<style scoped>
.app { font-family: system-ui, sans-serif; max-width: 960px; margin: 0 auto; }
main { padding: 1rem; }
</style>