#!/bin/bash
# 记忆备份任务设置脚本

# 备份任务配置
BACKUP_JOB=$(cat << 'EOF'
{
  "id": "memory-backup-001",
  "name": "记忆文件备份",
  "enabled": true,
  "createdAtMs": 1774150400000,
  "updatedAtMs": 1774150400000,
  "schedule": {
    "kind": "cron",
    "expr": "0 0 * * *",
    "tz": "Asia/Shanghai",
    "staggerMs": 300000
  },
  "sessionTarget": "isolated",
  "wakeMode": "now",
  "payload": {
    "kind": "agentTurn",
    "message": "执行记忆文件备份"
  },
  "persistence": {
    "protected": true,
    "backupEnabled": true,
    "autoRestore": true
  }
}
EOF
)

# 更新 cron jobs.json
# 这里需要手动通过 openclaw cron add 命令添加任务
echo "记忆备份任务配置已准备好"
echo "需要通过 openclaw 命令添加到 cron"
