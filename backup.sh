#!/bin/bash

# Configuration
./config.sh

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
        
        # Check disk space on the destination
        # Add your own logic here (e.g., using df command) to check if there is enough space
        
        # Create backup archive
        tar -czf "$backup_destination/$backup_filename" -C "$backup_source" .

        # Check if the backup was successful
        if [ $? -eq 0 ]; then
            log "Backup completed successfully: $backup_filename"
        else
            log "Error: Backup process failed."
        fi
    } >> "$log_file" 2>&1
}

# Main script execution
perform_backup
