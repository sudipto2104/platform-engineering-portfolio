import { defineStore } from 'pinia'
import { fetchTasks } from '../api/taskflow'

export const useTaskStore = defineStore('tasks', {
  state: () => ({ tasks: [], loading: false, error: null }),
  actions: {
    async fetchTasks() {
      this.loading = true
      try {
        const data = await fetchTasks()
        this.tasks = data.tasks
      } catch (e) {
        this.error = e.message
      } finally {
        this.loading = false
      }
    },
  },
})