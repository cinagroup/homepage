#!/bin/bash
# OpenClaw 多机器人自动备份脚本
# 使用方法：bash auto-backup.sh [机器人 ID]

set -e

REPO_PATH="/root/.openclaw/workspace/openclaw-robots-backup"
ROBOT_IDS=("CINA_10001" "CINA_10002" "CINA_10003")
LOG_FILE="/var/log/openclaw-backup.log"
GITHUB_TOKEN="${GITHUB_TOKEN:-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}"

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log() {
    echo -e "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# 进入仓库目录
cd "$REPO_PATH" || exit 1

# 配置 Git
git config user.email "assistant@openclaw.local"
git config user.name "CINA Backup Bot"

# 检查是否有特定机器人 ID 参数
if [ -n "$1" ]; then
    if [[ " ${ROBOT_IDS[@]} " =~ " ${1} " ]]; then
        ROBOT_IDS=("$1")
        log "${YELLOW}指定机器人备份：$1${NC}"
    else
        log "${RED}错误：无效的机器人 ID - $1${NC}"
        exit 1
    fi
fi

log "${GREEN}开始备份 ${#ROBOT_IDS[@]} 个机器人...${NC}"

# 循环检查每个机器人的改动
for ROBOT_ID in "${ROBOT_IDS[@]}"; do
    ROBOT_DIR="$REPO_PATH/$ROBOT_ID"
    
    if [ ! -d "$ROBOT_DIR" ]; then
        log "${YELLOW}跳过：$ROBOT_ID 目录不存在${NC}"
        continue
    fi
    
    # 检查该机器人目录是否有改动
    CHANGES=$(git status --porcelain "$ROBOT_ID" 2>/dev/null || true)
    
    if [ -n "$CHANGES" ]; then
        log "${YELLOW}[$ROBOT_ID] 发现改动:${NC}"
        echo "$CHANGES" | head -10
        
        # 添加改动文件
        git add "$ROBOT_ID/"
        
        # 统计改动文件数量
        FILE_COUNT=$(echo "$CHANGES" | wc -l)
        
        # 规范提交信息
        COMMIT_MSG="[$ROBOT_ID] auto backup: $FILE_COUNT files changed at $(date '+%Y-%m-%d %H:%M')"
        
        # 提交
        git commit -m "$COMMIT_MSG"
        log "${GREEN}[$ROBOT_ID] 已提交：$FILE_COUNT 个文件${NC}"
    else
        log "${GREEN}[$ROBOT_ID] 无改动${NC}"
    fi
done

# 检查是否有提交
if git diff-index --quiet HEAD; then
    log "${GREEN}所有机器人都是最新的，无需推送${NC}"
else
    # 推送到 GitHub
    log "${YELLOW}推送到 GitHub...${NC}"
    
    # 使用 Token 推送（避免交互式密码输入）
    REMOTE_URL="https://${GITHUB_TOKEN}@github.com/cinagroup/openclaw-robots-backup.git"
    
    if git push "$REMOTE_URL" main 2>&1 | tee -a "$LOG_FILE"; then
        log "${GREEN}✅ 备份完成！${NC}"
    else
        log "${RED}❌ 推送失败${NC}"
        exit 1
    fi
fi

# 显示备份状态
echo ""
log "${GREEN}================================${NC}"
log "${GREEN}备份状态摘要${NC}"
log "${GREEN}================================${NC}"
git log --oneline -5 --decorate

echo ""
log "${GREEN}下次备份时间：$(date -d '+1 hour' '+%Y-%m-%d %H:%M:%S')${NC}"
