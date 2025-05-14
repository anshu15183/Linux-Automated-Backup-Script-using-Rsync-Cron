# Linux-Automated-Backup-Script-using-Rsync-Cron# 🔄 Linux Automated Backup Script using `tar` + `cron`

A lightweight and reliable script to back up directories on Linux using `tar` with compression (`.tar.bz2`), automatic rotation (old backups cleanup), and daily cron scheduling.

---

## 📁 What It Does

- Compresses a specified directory (e.g., `/var/www/html`) using `tar` with `bzip2`
- Stores the backup as a timestamped `.tar.bz2` file in a designated backup directory
- Deletes older backups after a configurable retention period (default: 7 days)
- Logs every operation to a file for audit and monitoring

---

## ⚙️ Technologies Used

| Tool      | Purpose                        |
|-----------|--------------------------------|
| `tar`     | Archive and compress backups   |
| `cron`    | Schedule automatic backups     |
| `find`    | Auto-delete old backups        |
| `bash`    | Script automation              |
| `bzip2`   | Efficient file compression     |

---

## 🛠️ Setup Instructions

### 1. 📦 Clone the repository

```bash
git clone https://github.com/yourusername/linux-tar-backup-script.git
cd linux-tar-backup-script
```

### 2. ✏️ Configure the script

Edit the script `backup_script.sh` and adjust these variables:

```bash
SOURCE_DIR="/var/www/html"                       # Directory to back up
BACKUP_DIR="/mnt/backup/html_backup"             # Where to store backups
RETENTION_DAYS=7                                 # Keep last 7 backups
```

### 3. ✅ Make the script executable

```bash
chmod +x backup_script.sh
```

### 4. 📅 Schedule with `cron`

Edit the crontab:

```bash
crontab -e
```

Add a daily job (e.g., 2 AM):

```cron
0 2 * * * /path/to/backup_script.sh
```

### 5. 📄 View logs

Logs are written to:

```bash
/var/log/backup.log
```

To monitor in real time:

```bash
tail -f /var/log/backup.log
```

---

## 📂 Example Backup Output

```bash
/mnt/backup/html_backup/html_backup_2025-05-14_02-00-00.tar.bz2
/mnt/backup/html_backup/html_backup_2025-05-13_02-00-00.tar.bz2
...
```

---

## 🔁 Auto-Rotation

Backups older than `RETENTION_DAYS` (e.g., 7 days) are automatically deleted using:

```bash
find "$BACKUP_DIR" -name "*.tar.bz2" -mtime +7 -exec rm -f {} \;
```

---

## 💡 Restore Backup

To restore a `.tar.bz2` backup:

```bash
tar -xvjf html_backup_2025-05-14_02-00-00.tar.bz2 -C /
```

---

## ✅ Features

- 🔒 Efficient `.tar.bz2` compressed backups
- ♻️ Automatic deletion of old backups
- 🔧 Simple bash script (easy to customize)
- 🧾 Log tracking for every backup job
- 📅 Cron-compatible for full automation

---

## 🔐 Notes

- Run as root (or ensure you have read access to `SOURCE_DIR`).
- Ensure the `BACKUP_DIR` is writable and has enough space.
- Make sure `bzip2`, `tar`, and `cron` are installed.

---

## 🧑‍💻 Author

**Anshu Singh**  
