# AI 新闻简报定时任务配置

## ✅ 任务状态

**任务 ID**: `ai-news-briefing-001`  
**状态**: 🟢 已启用  
**保护**: ✅ 四重保护机制已激活

---

## 📅 执行计划

### 定时规则
- **Cron 表达式**: `0 */12 * * *`
- **时区**: Asia/Shanghai
- **执行时间**: 每日 06:00 和 18:00

### 今日执行记录

| 期数 | 计划时间 | 实际执行 | 状态 |
|------|----------|----------|------|
| 第 2 期 | 06:00 | 07:04 | ✅ 已完成 |
| 第 3 期 | 18:00 | 待执行 | ⏳ 即将执行 |

---

## 🎯 执行流程

### 自动执行步骤

1. **触发** (18:00 整)
   - OpenClaw cron 系统自动触发
   - 创建 isolated session
   - 发送任务消息到 QQBot

2. **内容收集**
   - 使用 brave-search 搜索 AI 热点新闻
   - 覆盖时段：过去 12 小时
   - 筛选 5-7 条核心新闻

3. **生成简报**
   - 创建 Markdown 文件
   - 保存到 `src/data/post/ai-news-briefing-YYYY-MM-DD.md`
   - Git commit + push

4. **部署发布**
   - GitHub Actions 自动触发
   - Cloudflare Pages 构建部署
   - 2-5 分钟后上线

5. **验证确认**
   - 访问 `cinagroup.com/blog` 确认
   - 发送验证报告到 QQBot

---

## 🛡️ 保护机制

### 1. 本地持久化
- 主文件：`/root/.openclaw/cron/jobs.json`
- 备份文件：`/root/.openclaw/cron/jobs.json.bak`
- 保护标记：`persistence.protected: true`

### 2. Git 版本控制
- 备份仓库：`/root/.openclaw/workspace/cron-jobs-backup.json`
- 远程同步：GitHub 私有仓库
- 提交频率：每次修改后自动提交

### 3. 系统级备份
```bash
# Crontab 配置
0 0 * * * /root/.openclaw/workspace/scripts/backup-cron-jobs.sh
```
- 备份位置：`/root/.openclaw/workspace/cron-backups/`
- 保留策略：最近 30 个备份

### 4. 文档记录
- 配置文件：`CRON-PERSISTENCE.md`
- 恢复流程：3 种恢复方式
- 维护清单：每日/每周检查

---

## 📊 监控方式

### 查看任务状态
```bash
cat /root/.openclaw/cron/jobs.json | grep -A 20 "ai-news-briefing"
```

### 查看执行日志
```bash
# OpenClaw 日志
tail -f /root/.openclaw/logs/*.log

# 博客部署日志
cd /root/.openclaw/workspace/cinagroup-site
tail -f /var/log/cloudflare-deploy.log
```

### 验证部署
```bash
# 访问博客确认
agent-browser open "https://cinagroup.com/blog"
agent-browser snapshot -i
```

---

## 🔧 手动执行

如需立即执行（不等待定时）：

```bash
# 手动触发 AI 新闻简报任务
openclaw sessions spawn \
  --task "发布 AI 新闻简报：搜索过去 12 小时 AI 热点新闻，筛选 5-7 条核心新闻，生成 Markdown 简报并发布到博客 /blog" \
  --mode run
```

---

## 📋 检查清单

### 每日检查 (18:05)
- [ ] 18:00 任务是否自动触发
- [ ] 博客是否成功发布
- [ ] Cloudflare 部署是否完成
- [ ] 访问 `cinagroup.com/blog` 验证

### 每周检查
- [ ] cron 配置文件备份正常
- [ ] Git 远程仓库同步
- [ ] 执行日志无错误

---

## ⚠️ 异常处理

### 任务未执行
```bash
# 1. 检查 cron 状态
cat /root/.openclaw/cron/jobs.json

# 2. 重启 Gateway
openclaw gateway restart

# 3. 手动执行一次
bash /root/.openclaw/workspace/cina-robots-backup/scripts/daily-backup-10001.sh
```

### 部署失败
```bash
# 1. 检查构建日志
cd /root/.openclaw/workspace/cinagroup-site
npm run build

# 2. 检查 Cloudflare 状态
cat /var/log/cloudflare-deploy.log
```

---

## 📈 统计数据

| 指标 | 数值 |
|------|------|
| 总期数 | 2 期 (第 3 期待发布) |
| 成功率 | 100% |
| 平均执行时间 | ~6 分钟 |
| 部署时间 | 2-5 分钟 |

---

**最后更新**: 2026-03-21 18:31  
**下次执行**: 18:00 (今日)  
**状态**: ✅ 配置正常，等待执行
