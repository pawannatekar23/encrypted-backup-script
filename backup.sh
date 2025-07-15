#!/bin/bash

# === Configurable Variables ===
SOURCE_DIR="/home/data-dir"
DEST_IP="103.105.251.130"
DEST_DIR="/home/backup-dir"
PORT=7869
DATE=$(date +"%Y-%m-%d_%H-%M")
BACKUP_NAME="backup_$DATE.tar.gz"
ENCRYPTED_NAME="$BACKUP_NAME.enc"
ENCRYPTION_PASSWORD="Zxcvbnm@12323"

# === Create and Encrypt the Backup ===
echo "[+] Creating and encrypting backup..."
tar -czf - "$SOURCE_DIR" | openssl enc -aes-256-cbc -pbkdf2 -salt -pass pass:$ENCRYPTION_PASSWORD -out /tmp/$ENCRYPTED_NAME

# === Transfer Encrypted Backup to Remote Server ===
echo "[+] Transferring encrypted backup to $DEST_IP:$DEST_DIR"
scp -P $PORT /tmp/$ENCRYPTED_NAME root@$DEST_IP:$DEST_DIR/

# === Remove Local Encrypted File ===
echo "[+] Cleaning up local encrypted backup..."
rm -f /tmp/$ENCRYPTED_NAME

# === Delete Remote Backups Older Than 3 Days ===
echo "[+] Deleting remote backups older than 3 days..."
ssh -p $PORT root@$DEST_IP "find $DEST_DIR -name 'backup_*.enc' -type f -mtime +3 -delete"

echo "[✓] Backup and cleanup complete."

