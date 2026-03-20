# 定时任务持久化配置

## 🛡️ 保护机制

### 1. 本地备份
- **主文件**: `/root/.openclaw/cron/jobs.json`
- **备份文件**: `/root/.openclaw/cron/jobs.json.bak`（自动创建）
- **Git 备份**: `/root/.openclaw/workspace/cron-jobs-backup.json`

### 2. 任务配置

#### AI 新闻简报（每日 2 次）
- **ID**: `ai-news-briefing-001`
- **频率**: `0 */12 * * *`（06:00 和 18:00）
- **时区**: Asia/Shanghai
- **保护状态**: ✅ 受保护
- **自动恢复**: ✅ 启用

#### 每小时工作汇报
- **ID**: `35f89470-87af-4982-b7b0-85d259b3b793`
- **频率**: `0 * * * *`（每小时整点）
- **时区**: Asia/Shanghai
- **保护状态**: ✅ 受保护
- **自动恢复**: ✅ 启用

### 3. 系统级备份（crontab）

系统 crontab 已配置：
```bash
# 每日备份（00:00）
0 0 * * * /root/.openclaw/workspace/cina-robots-backup/scripts/daily-backup-10001.sh
```

### 4. Git 版本控制

定时任务配置已纳入 Git 管理：
- **仓库**: `/root/.openclaw/workspace`
- **提交频率**: 每次修改后自动提交
- **远程备份**: GitHub 私有仓库

---

## 📋 维护清单

### 每日检查
- [ ] cron 任务正常运行
- [ ] 备份文件存在
- [ ] 下次执行时间正确

### 每周检查
- [ ] Git 远程备份同步
- [ ] 任务执行日志审查

### 恢复流程

如果任务丢失：
```bash
# 1. 从 Git 恢复
cd /root/.openclaw/workspace
git checkout cron-jobs-backup.json

# 2. 复制回 cron 目录
cp cron-jobs-backup.json /root/.openclaw/cron/jobs.json

# 3. 重启 OpenClaw Gateway
openclaw gateway restart
```

---

**最后更新**: 2026-03-21 07:11  
**状态**: ✅ 所有任务已保护
