import { defineStore } from 'pinia'
import { fetchTasks } from '../api/taskflow'

export const useTaskStore = defineStore('tasks', {
  state: () => ({
    tasks: [],
    loading: false,
    error: null,
  }),
  actions: {
    async fetchTasks() {
      this.loading = true
      this.error = null
      try {
        const data = await fetchTasks()
        this.tasks = data.tasks
      } catch (err) {
        this.error = err.message || 'Failed to load tasks'
      } finally {
        this.loading = false
      }
    },
  },
})