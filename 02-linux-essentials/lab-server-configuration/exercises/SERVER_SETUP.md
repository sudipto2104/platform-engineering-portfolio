# Server Setup Exercises (Ubuntu VM)

## 1. Hostname

```bash
sudo hostnamectl set-hostname taskflow-staging-01
sudo tee -a /etc/hosts <<< '127.0.1.1 taskflow-staging-01'
hostnamectl
```

## 2. Deploy user & SSH key

```bash
sudo adduser deploy
sudo usermod -aG sudo deploy
sudo mkdir -p /home/deploy/.ssh
sudo cp ~/.ssh/authorized_keys /home/deploy/.ssh/
sudo chown -R deploy:deploy /home/deploy/.ssh
sudo chmod 700 /home/deploy/.ssh && sudo chmod 600 /home/deploy/.ssh/authorized_keys
```

## 3. SSH hardening

```bash
sudo cp reference/ssh/sshd_config.snippet /etc/ssh/sshd_config.d/99-taskflow.conf
sudo systemctl reload sshd
```

## 4. UFW

```bash
sudo bash reference/ufw/rules.sh
```

## 5. Document

Copy solved `SERVER_BASELINE.md` and add your VM's `ip addr` output.