import React, { useEffect, useState } from 'react';
import {
  Card,
  CardContent,
  CircularProgress,
  Grid,
  Typography,
  makeStyles,
} from '@material-ui/core';
import { Header, Page, Content } from '@backstage/core-components';
import AssignmentIcon from '@material-ui/icons/Assignment';
import PeopleIcon from '@material-ui/icons/People';
import CloudDoneIcon from '@material-ui/icons/CloudDone';
import { fetchTaskFlowMetrics, TaskFlowMetrics } from '../api/taskflowApi';

const useStyles = makeStyles(theme => ({
  card: {
    height: '100%',
  },
  metricValue: {
    fontSize: '2.5rem',
    fontWeight: 700,
    marginTop: theme.spacing(1),
  },
  statusHealthy: { color: theme.palette.success.main },
  statusDegraded: { color: theme.palette.warning.main },
  statusOffline: { color: theme.palette.error.main },
  icon: {
    fontSize: 40,
    opacity: 0.7,
  },
}));

interface MetricCardProps {
  title: string;
  value: string | number;
  icon: React.ReactNode;
  className?: string;
}

function MetricCard({ title, value, icon, className }: MetricCardProps) {
  const classes = useStyles();
  return (
    <Card className={classes.card}>
      <CardContent>
        <Grid container justifyContent="space-between" alignItems="center">
          <Typography color="textSecondary" variant="subtitle1">
            {title}
          </Typography>
          <span className={classes.icon}>{icon}</span>
        </Grid>
        <Typography className={className ?? classes.metricValue}>{value}</Typography>
      </CardContent>
    </Card>
  );
}

export const TaskFlowDashboardPage = () => {
  const classes = useStyles();
  const [metrics, setMetrics] = useState<TaskFlowMetrics | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    let cancelled = false;

    async function load() {
      setLoading(true);
      setError(null);
      try {
        const data = await fetchTaskFlowMetrics();
        if (!cancelled) {
          setMetrics(data);
        }
      } catch (err) {
        if (!cancelled) {
          setError(err instanceof Error ? err.message : 'Failed to load metrics');
        }
      } finally {
        if (!cancelled) {
          setLoading(false);
        }
      }
    }

    load();
    const interval = setInterval(load, 30_000);
    return () => {
      cancelled = true;
      clearInterval(interval);
    };
  }, []);

  const statusClass = {
    healthy: classes.statusHealthy,
    degraded: classes.statusDegraded,
    offline: classes.statusOffline,
  }[metrics?.deploymentStatus ?? 'offline'];

  return (
    <Page themeId="tool">
      <Header title="TaskFlow Dashboard" subtitle="Live platform metrics" />
      <Content>
        {loading && (
          <Grid container justifyContent="center">
            <CircularProgress />
          </Grid>
        )}

        {error && (
          <Typography color="error" variant="body1">
            Error: {error}
          </Typography>
        )}

        {!loading && metrics && (
          <Grid container spacing={3}>
            <Grid item xs={12} md={4}>
              <MetricCard
                title="Total Tasks"
                value={metrics.taskCount}
                icon={<AssignmentIcon />}
              />
            </Grid>
            <Grid item xs={12} md={4}>
              <MetricCard
                title="Active Users"
                value={metrics.activeUsers}
                icon={<PeopleIcon />}
              />
            </Grid>
            <Grid item xs={12} md={4}>
              <MetricCard
                title="Deployment Status"
                value={metrics.deploymentStatus}
                icon={<CloudDoneIcon />}
                className={`${classes.metricValue} ${statusClass}`}
              />
            </Grid>
            {metrics.health && (
              <Grid item xs={12}>
                <Card>
                  <CardContent>
                    <Typography variant="h6">API Health</Typography>
                    <Typography variant="body2" color="textSecondary">
                      {metrics.health.service} v{metrics.health.version} —{' '}
                      {metrics.health.environment} — {metrics.health.timestamp}
                    </Typography>
                  </CardContent>
                </Card>
              </Grid>
            )}
          </Grid>
        )}
      </Content>
    </Page>
  );
};