#!/bin/bash

# CONFIGURATION
SOURCE_DIR="/var/www/html"
BACKUP_DIR="/mnt/backup/html_backup"
LOG_FILE="/var/log/backup.log"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="$BACKUP_DIR/html_backup_$DATE.tar.bz2"
RETENTION_DAYS=7  # Keep backups for 7 days

# START BACKUP
echo "[$DATE] Starting backup..." >> "$LOG_FILE"

# Ensure backup directory exists
mkdir -p "$BACKUP_DIR"

# Create compressed tar.bz2 archive
tar -cvjf "$BACKUP_FILE" "$SOURCE_DIR" >> "$LOG_FILE" 2>&1

# Check if tar was successful
if [ $? -eq 0 ]; then
    echo "[$DATE] Backup successful: $BACKUP_FILE" >> "$LOG_FILE"
else
    echo "[$DATE] Backup FAILED!" >> "$LOG_FILE"
fi

# DELETE OLD BACKUPS
echo "[$DATE] Deleting backups older than $RETENTION_DAYS days..." >> "$LOG_FILE"
find "$BACKUP_DIR" -name "*.tar.bz2" -type f -mtime +$RETENTION_DAYS -exec rm -f {} \; >> "$LOG_FILE" 2>&1
echo "[$DATE] Old backup cleanup complete." >> "$LOG_FILE"

echo "------------------------------" >> "$LOG_FILE"
