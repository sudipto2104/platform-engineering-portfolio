import { createRouter, createWebHistory } from 'vue-router'
import DashboardView from '../views/DashboardView.vue'
import TasksView from '../views/TasksView.vue'

const routes = [
  { path: '/', name: 'dashboard', component: DashboardView },
  { path: '/tasks', name: 'tasks', component: TasksView },
]

export default createRouter({
  history: createWebHistory(),
  routes,
})