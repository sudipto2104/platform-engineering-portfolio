export interface TaskFlowHealth {
  status: string;
  service: string;
  version: string;
  environment: string;
  timestamp: string;
}

export interface TaskFlowTasks {
  tasks: Array<{ id: number; title: string; status: string; owner: string }>;
  count: number;
}

export interface TaskFlowMetrics {
  taskCount: number;
  activeUsers: number;
  deploymentStatus: 'healthy' | 'degraded' | 'offline';
  health: TaskFlowHealth | null;
}

const API_BASE = '/api/proxy/taskflow-api';

async function fetchJson<T>(path: string): Promise<T> {
  const response = await fetch(`${API_BASE}${path}`);
  if (!response.ok) {
    throw new Error(`TaskFlow API error: ${response.status} ${response.statusText}`);
  }
  return response.json() as Promise<T>;
}

export async function fetchTaskFlowMetrics(): Promise<TaskFlowMetrics> {
  const [health, tasks] = await Promise.all([
    fetchJson<TaskFlowHealth>('/health').catch(() => null),
    fetchJson<TaskFlowTasks>('/api/tasks').catch(() => ({ tasks: [], count: 0 })),
  ]);

  const deploymentStatus: TaskFlowMetrics['deploymentStatus'] =
    health?.status === 'healthy' ? 'healthy' : health ? 'degraded' : 'offline';

  return {
    taskCount: tasks.count,
    activeUsers: Math.max(1, Math.ceil(tasks.count / 2)),
    deploymentStatus,
    health,
  };
}