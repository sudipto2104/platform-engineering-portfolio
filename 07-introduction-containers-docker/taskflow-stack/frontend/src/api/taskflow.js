import axios from 'axios'

const client = axios.create({
  baseURL: import.meta.env.VITE_API_URL || '/api',
  timeout: 5000,
})

export async function fetchTasks() {
  const { data } = await client.get('/tasks')
  return data
}