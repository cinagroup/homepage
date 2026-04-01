#!/bin/bash
# 记忆文件备份脚本 - 支持 Git 同步到 GitHub
BACKUP_DIR="/root/.openclaw/workspace/memory-backups"
GIT_REPO_DIR="/root/.openclaw/workspace/cina-robots-backup"
BACKUP_SUB_DIR="CINA_10001"
DATE=$(date +%Y-%m-%d-%H-%M-%S)
DATE_SIMPLE=$(date +%Y-%m-%d)

mkdir -p "$BACKUP_DIR"
mkdir -p "$GIT_REPO_DIR/$BACKUP_SUB_DIR"

# 1. 本地备份
cp -r /root/.openclaw/workspace/memory "$BACKUP_DIR/memory-$DATE"
cp /root/.openclaw/workspace/MEMORY.md "$BACKUP_DIR/MEMORY-$DATE.md" 2>/dev/null || true
cp /root/.openclaw/workspace/AGENTS.md "$BACKUP_DIR/" 2>/dev/null || true
cp /root/.openclaw/workspace/SOUL.md "$BACKUP_DIR/" 2>/dev/null || true
cp /root/.openclaw/workspace/USER.md "$BACKUP_DIR/" 2>/dev/null || true
cp /root/.openclaw/workspace/TOOLS.md "$BACKUP_DIR/" 2>/dev/null || true

# 2. 只保留最近 30 个本地备份
ls -dt "$BACKUP_DIR"/memory-* 2>/dev/null | tail -n +31 | xargs rm -rf 2>/dev/null || true

# 3. 同步到 GitHub 仓库
cd "$GIT_REPO_DIR" || exit 1

# 确保仓库是最新的
git pull origin main 2>/dev/null || true

# 清理旧备份（保留最近 7 天）
find "$GIT_REPO_DIR/$BACKUP_SUB_DIR" -type d -name "memory-20*" -mtime +7 -exec rm -rf {} \; 2>/dev/null || true

# 复制最新备份到 Git 仓库
cp -r /root/.openclaw/workspace/memory "$GIT_REPO_DIR/$BACKUP_SUB_DIR/memory-latest"
cp /root/.openclaw/workspace/MEMORY.md "$GIT_REPO_DIR/$BACKUP_SUB_DIR/" 2>/dev/null || true
cp /root/.openclaw/workspace/AGENTS.md "$GIT_REPO_DIR/$BACKUP_SUB_DIR/" 2>/dev/null || true
cp /root/.openclaw/workspace/SOUL.md "$GIT_REPO_DIR/$BACKUP_SUB_DIR/" 2>/dev/null || true
cp /root/.openclaw/workspace/USER.md "$GIT_REPO_DIR/$BACKUP_SUB_DIR/" 2>/dev/null || true
cp /root/.openclaw/workspace/TOOLS.md "$GIT_REPO_DIR/$BACKUP_SUB_DIR/" 2>/dev/null || true

# 还创建一个带日期的备份副本
cp -r /root/.openclaw/workspace/memory "$GIT_REPO_DIR/$BACKUP_SUB_DIR/memory-$DATE_SIMPLE" 2>/dev/null || true

# Git 提交
git add -A 2>/dev/null
git commit -m "🔄 Memory backup for CINA_10001 - $DATE_SIMPLE" 2>/dev/null || true
git push origin main 2>/dev/null || true

echo "Backup completed: $DATE (local + GitHub)"
