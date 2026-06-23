import {
  createPlugin,
  createRoutableExtension,
} from '@backstage/core-plugin-api';
import { rootRouteRef } from './routes';

export const taskflowDashboardPlugin = createPlugin({
  id: 'taskflow-dashboard',
  routes: {
    root: rootRouteRef,
  },
});

export const TaskFlowDashboardPage = taskflowDashboardPlugin.provide(
  createRoutableExtension({
    name: 'TaskFlowDashboardPage',
    component: () =>
      import('./components/TaskFlowDashboardPage').then(m => m.TaskFlowDashboardPage),
    mountPoint: rootRouteRef,
  }),
);