<template>
  <article class="task-card" :class="statusClass">
    <h3>{{ task.title }}</h3>
    <p>Status: <strong>{{ task.status }}</strong></p>
    <p>Owner: {{ task.owner }}</p>
  </article>
</template>

<script setup>
import { computed } from 'vue'

const props = defineProps({
  task: { type: Object, required: true },
})

const statusClass = computed(() => `status-${props.task.status.replace('_', '-')}`)
</script>

<style scoped>
.task-card { border: 1px solid #ccc; padding: 0.75rem; margin-bottom: 0.5rem; border-radius: 6px; }
.status-done { border-color: #2e7d32; }
.status-in-progress { border-color: #f9a825; }
</style>