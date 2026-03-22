#!/bin/bash
# 定时任务备份脚本
# 用途：保护 OpenClaw 定时任务配置不被丢失

BACKUP_DIR="/root/.openclaw/workspace/cron-backups"
SOURCE_FILE="/root/.openclaw/cron/jobs.json"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# 创建备份目录
mkdir -p "$BACKUP_DIR"

# 备份当前配置
cp "$SOURCE_FILE" "$BACKUP_DIR/jobs.$TIMESTAMP.json"

# 保留最近 30 个备份
ls -t "$BACKUP_DIR"/jobs.*.json | tail -n +31 | xargs -r rm

# 同步到 Git 仓库
cd /root/.openclaw/workspace
cp "$SOURCE_FILE" cron-jobs-backup.json
git add cron-jobs-backup.json 2>/dev/null
git commit -m "🔄 定时任务自动备份 $TIMESTAMP" 2>/dev/null || true

echo "[$TIMESTAMP] 定时任务备份完成"
