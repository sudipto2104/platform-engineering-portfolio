# Simulated TaskFlow Server Layout

```
taskflow-server/
├── app/           # TaskFlow application (platform-team)
├── config/        # Secrets & env (root/platform only)
├── logs/          # Readable by platform + ops
├── data/          # PostgreSQL data (restricted)
└── public/        # Static assets (world-readable)
```

Apply permissions per `exercises/SECURITY_DRILLS.md`.