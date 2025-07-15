# 🔐 Encrypted Backup Automation Script

This script automates encrypted backup from one Linux server to another via SCP.

## Features
- Compresses and encrypts source directory
- Transfers to remote destination securely
- Deletes backups older than 3 days
- Runs daily at 5 PM via cron

## Usage
- Update paths and credentials in `backup_script.sh`
- Place script on source server
- Set up cron for automation


