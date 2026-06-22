# Ubuntu apt Setup (VM)

```bash
sudo apt update
sudo apt install -y nginx postgresql redis-server python3-venv

# PostgreSQL
sudo -u postgres createuser taskflow
sudo -u postgres createdb taskflow -O taskflow
sudo -u postgres psql -c "ALTER USER taskflow PASSWORD 'taskflow';"

# Enable services
sudo systemctl enable --now nginx postgresql redis-server

# TaskFlow systemd
sudo cp reference/systemd/taskflow.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable taskflow
sudo systemctl start taskflow
sudo systemctl status taskflow nginx postgresql redis-server
```

## Verification

```bash
curl http://localhost/health
sudo journalctl -u taskflow -n 20
```