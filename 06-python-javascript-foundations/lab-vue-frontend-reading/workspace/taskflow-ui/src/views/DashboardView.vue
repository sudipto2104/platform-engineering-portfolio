<template>
  <div>
    <h2>Dashboard</h2>
    <p>TaskFlow platform overview — Week 6 code reading lab.</p>
    <ul>
      <li>Total tasks: {{ store.tasks.length }}</li>
      <li>API status: {{ health }}</li>
    </ul>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useTaskStore } from '../stores/taskStore'
import { fetchHealth } from '../api/taskflow'

const store = useTaskStore()
const health = ref('unknown')

onMounted(async () => {
  await store.fetchTasks()
  try {
    const data = await fetchHealth()
    health.value = data.status
  } catch {
    health.value = 'offline'
  }
})
</script>