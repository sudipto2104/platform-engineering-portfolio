<template>
  <div class="app-shell">
    <AppHeader />
    <main>
      <RouterView />
    </main>
  </div>
</template>

<script setup>
import AppHeader from './components/AppHeader.vue'
</script>

<style scoped>
.app-shell { font-family: system-ui, sans-serif; max-width: 960px; margin: 0 auto; }
main { padding: 1rem; }
</style>