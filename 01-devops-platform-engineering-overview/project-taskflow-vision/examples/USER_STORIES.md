# TaskFlow User Stories (Reference)

## Platform engineer

1. As a **platform engineer**, I want to **create tasks for IaC migrations with clear owners**, so that **app teams know when self-service infrastructure is ready**.
2. As a **platform engineer**, I want to **see deployment health checks linked to tasks**, so that **I can mark platform work done only when production verifies it**.
3. As a **platform engineer**, I want to **label tasks by platform capability (CI, K8s, secrets)**, so that **roadmap gaps are visible to leadership**.

## Application developer

4. As an **application developer**, I want to **browse open platform tasks affecting my service**, so that **I can plan around dependency lead times**.
5. As an **application developer**, I want to **request a paved-path onboarding task**, so that **I don't open opaque ops tickets**.
6. As an **application developer**, I want to **query tasks via API from my IDE**, so that **context switching stays minimal**.

## Engineering manager

7. As an **engineering manager**, I want to **filter tasks by team and status**, so that **I can report weekly progress without manual spreadsheet updates**.
8. As an **engineering manager**, I want to **see blocked platform tasks**, so that **I can escalate before release dates slip**.

## SRE / operations

9. As an **SRE**, I want to **link incident follow-ups to TaskFlow tasks**, so that **reliability work is tracked and prioritized**.
10. As an **SRE**, I want to **read `/health` and logs for TaskFlow itself**, so that **the coordination platform meets the same bar we set for product services**.