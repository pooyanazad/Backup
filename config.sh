# config.sh
backup_source="/mnt/source" #your source
backup_destination="/mnt/dest" #your destination
log_file="/mnt/log/backup_log_$(date +'%Y%m%d_%H%M%S').log" #your log folder
backup_filename="backup_$(date +'%Y%m%d_%H%M%S').tar.gz"
max_backups=5  # Maximum number of backups to keep
compression_level=1  # Set the compression level (1-9) for tar
