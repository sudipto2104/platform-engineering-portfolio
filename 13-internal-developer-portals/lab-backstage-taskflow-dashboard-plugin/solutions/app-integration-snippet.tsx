// Add to packages/app/src/App.tsx

import DashboardIcon from '@material-ui/icons/Dashboard';
import { TaskFlowDashboardPage } from '@internal/plugin-taskflow-dashboard';

// Inside <FlatRoutes>:
<Route path="/taskflow-dashboard" element={<TaskFlowDashboardPage />} />

// Inside SidebarItem (SidebarGroup or standalone):
<SidebarItem icon={DashboardIcon} to="taskflow-dashboard" text="TaskFlow" />