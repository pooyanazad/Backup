#!/bin/bash

# Load configuration from a separate file
source config.sh

# Function to log messages
log() {
    echo "$(date +'%Y-%m-%d %H:%M:%S'): $1" >> "$log_file"
}

# Function to perform backup
perform_backup() {
    {
        log "Starting backup process..."

        # Check if source and destination directories exist
        if [ ! -d "$backup_source" ] || [ ! -d "$backup_destination" ]; then
            log "Error: Source or destination directory does not exist."
            exit 1
        fi

        # Set the compression level for tar
        export GZIP="-${compression_level}"

        # Create backup archive with specified compression level
        tar -czf "$backup_destination/$backup_filename" -C "$backup_source" .

        # Check if the backup was successful
        if [ $? -eq 0 ]; then
            log "Backup completed successfully: $backup_filename"
            preserve_mid_month_backup "$backup_filename"
        else
            log "Error: Backup process failed."
            exit 1
        fi

        # Rotate backups
        rotate_backups
    } >> "$log_file" 2>&1
}

# Function to rotate backups
rotate_backups() {
    local backup_count=$(ls -1 "$backup_destination" | grep -c '^backup_.*\.tar\.gz$')
    local excess_backups=$((backup_count - max_backups))

    if [ "$excess_backups" -gt 0 ]; then
        log "Rotating backups. Keeping the latest $max_backups backups."

        # Sort backups by modification time and remove the oldest ones
        ls -1t "$backup_destination" | grep '^backup_.*\.tar\.gz$' | tail -n "$excess_backups" | xargs -I {} rm "$backup_destination/{}"
    fi
}

# Function to preserve mid-month backups
preserve_mid_month_backup() {
    local backup_file="$1"
    # Extract date from backup filename
    local backup_date=$(echo "$backup_file" | sed -n 's/backup_\([0-9]\+\).tar.gz/\1/p')

    # Check if backup is from the middle of the month (e.g., 15th)
    if [[ "$backup_date" =~ [0-9]{6}15 ]]; then
        # Calculate 2 years in the past
        local two_years_ago=$(date -d "-2 years" +'%Y%m%d')
        
        # Check if the backup is within the last 2 years
        if [ "${backup_date:0:8}" -ge "${two_years_ago:0:8}" ]; then
            log "Preserving mid-month backup: $backup_file"
            # Append a special suffix to indicate this backup is preserved
            mv "$backup_destination/$backup_file" "$backup_destination/preserved_$backup_file"
        fi
    fi
}

# Main script execution
perform_backup
