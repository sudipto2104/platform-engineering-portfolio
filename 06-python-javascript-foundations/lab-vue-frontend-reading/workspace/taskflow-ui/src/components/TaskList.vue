<template>
  <section>
    <p v-if="store.loading">Loading tasks…</p>
    <p v-else-if="store.error" class="error">{{ store.error }}</p>
    <TaskCard v-for="task in store.tasks" :key="task.id" :task="task" />
  </section>
</template>

<script setup>
import { onMounted } from 'vue'
import { useTaskStore } from '../stores/taskStore'
import TaskCard from './TaskCard.vue'

const store = useTaskStore()

onMounted(() => store.fetchTasks())
</script>

<style scoped>
.error { color: #c62828; }
</style>