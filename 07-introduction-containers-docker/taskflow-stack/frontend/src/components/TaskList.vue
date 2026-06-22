<template>
  <section>
    <p v-if="store.loading">Loading…</p>
    <ul v-else>
      <li v-for="t in store.tasks" :key="t.id">{{ t.title }} ({{ t.status }})</li>
    </ul>
  </section>
</template>

<script setup>
import { onMounted } from 'vue'
import { useTaskStore } from '../stores/taskStore'
const store = useTaskStore()
onMounted(() => store.fetchTasks())
</script>