#!/bin/bash

# Configuration
SOURCE_DIR="/path/to/source"
BACKUP_DIR="/path/to/backup"
LOG_FILE="/path/to/logfile.log"

# Function to log messages
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    log "Error: Source directory does not exist."
    exit 1
fi

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Backup filename with timestamp
BACKUP_FILE="$BACKUP_DIR/backup_$(date '+%Y%m%d_%H%M%S').tar.gz"

# Perform the backup
tar czf "$BACKUP_FILE" -C "$SOURCE_DIR" .

# Check if backup was successful
if [ $? -eq 0 ]; then
    log "Backup successful: $BACKUP_FILE"
else
    log "Error: Backup failed."
    exit 1
fi

# Optional: Prune old backups to save space
find "$BACKUP_DIR" -name "backup_*.tar.gz" -mtime +7 -exec rm {} \;
log "Old backups pruned."

# Optional: Upload backup to remote server using scp or rsync

# Optional: Send notification email about the backup status

# End of script
