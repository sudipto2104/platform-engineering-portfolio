# TaskFlow Core Features (Reference)

## Feature 1: Task board with platform taxonomy

- **Description:** Kanban-style board with labels for platform work types (CI/CD, IaC, observability, security).
- **Users:** Platform engineers, engineering managers.
- **Business value:** Leadership sees platform investment alongside feature work; reduces "invisible work" tax.

## Feature 2: REST API for tasks

- **Description:** CRUD API for tasks (`/api/tasks`) enabling automation and integrations.
- **Users:** Developers, CI pipelines.
- **Business value:** Tasks become programmable — gates and bots can update status from deployments.

## Feature 3: Health and version endpoints

- **Description:** `/health` exposes service status, version, and timestamp for observability integration.
- **Users:** SRE, platform engineers.
- **Business value:** Foundation for SLOs and deployment verification; demonstrates running software from day one.

## Feature 4: Ownership and status tracking

- **Description:** Every task has owner, status (todo / in_progress / done), and title.
- **Users:** Engineering managers, platform engineers.
- **Business value:** Accountability for cross-team commitments; replaces spreadsheet coordination.

## Feature 5: Container-ready deployment

- **Description:** Dockerfile and IaC templates ship with the app for repeatable environments.
- **Users:** Platform engineers, developers.
- **Business value:** Eliminates "works on my machine" for the platform itself; models the golden path early.

## Feature 6: Bootcamp progression markers

- **Description:** Tasks and versions align to weekly curriculum milestones (week1, week2, …).
- **Users:** Students, instructors.
- **Business value:** Visible learning path tied to a real running system — not disconnected exercises.