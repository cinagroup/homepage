# AI News Briefing Schedule

## ✅ Task Status

**Task ID**: `ai-news-briefing-001`  
**Status**: 🟢 Enabled  
**Protection**: ✅ Four-layer protection mechanism active

---

## 📅 Execution Plan

### Schedule Rules
- **Cron Expression**: `0 */12 * * *`
- **Timezone**: Asia/Shanghai
- **Execution Time**: Daily at 06:00 and 18:00

### Today's Execution Record

| Date/Time | Scheduled | Actual | Status |
|-----------|-----------|--------|--------|
| 2026-03-21 06:00 | 06:00 | 07:04 | ✅ Completed (delayed) |
| 2026-03-21 18:00 | 18:00 | 18:00 | ✅ Completed |
| 2026-03-22 06:00 | 06:00 | - | ⏳ Pending |
| 2026-03-22 18:00 | 18:00 | - | ⏳ Scheduled |

---

## 🎯 Execution Flow

### Automatic Execution Steps

1. **Trigger** (06:00 / 18:00)
   - OpenClaw cron system automatically triggers
   - Creates isolated session
   - Sends task message to QQBot

2. **Content Collection**
   - Use brave-search to search AI news
   - Coverage: Past 12 hours
   - Select 5-7 core news items

3. **Generate Briefing**
   - Create Markdown file
   - Save to `src/data/post/ai-news-briefing-YYYY-MM-DD-HH.md`
   - Git commit + push

4. **Deployment**
   - GitHub Actions automatically triggers
   - Cloudflare Pages build and deploy
   - Live in 2-5 minutes

5. **Verification**
   - Visit `cinagroup.com/blog` to confirm
   - Send verification report to QQBot

---

## 📝 Briefing Format

### File Naming Convention
- **Format**: `ai-news-briefing-YYYY-MM-DD-HH.md`
- **Example**: `ai-news-briefing-2026-03-22-06.md`
- **Note**: No issue numbers, use date-time stamp

### Language
- **Content**: English
- **Title Format**: `AI News Briefing | YYYY-MM-DD HH:00`

### Structure
```markdown
---
title: "AI News Briefing | 2026-03-22 06:00"
description: "12-hour AI digest: [brief summary]"
publishDate: 2026-03-22T06:00:00.000Z  # ISO 8601 UTC format (required by Astro content collections)
author: "001"
tags: ["AI", "News Briefing", "Tech"]
category: "blog"
---

# 🤖 AI News Briefing

**Published**: March 22, 2026 06:00 (Asia/Shanghai)  
**Coverage**: 2026-03-21 18:00 — 2026-03-22 06:00

## 📰 Top Stories
...
```

---

## 🛡️ Protection Mechanisms

### 1. Local Persistence
- Main file: `/root/.openclaw/cron/jobs.json`
- Backup file: `/root/.openclaw/cron/jobs.json.bak`
- Protection flag: `persistence.protected: true`

### 2. Git Version Control
- Backup repo: `/root/.openclaw/workspace/cron-jobs-backup.json`
- Remote sync: GitHub private repository
- Commit frequency: Auto-commit after each modification

### 3. System-level Backup
```bash
# Crontab configuration
0 0 * * * /root/.openclaw/workspace/scripts/backup-cron-jobs.sh
```
- Backup location: `/root/.openclaw/workspace/cron-backups/`
- Retention policy: Last 30 backups

### 4. Documentation
- Configuration file: `CRON-PERSISTENCE.md`
- Recovery procedures: 3 recovery methods
- Maintenance checklist: Daily/weekly checks

---

## 📊 Monitoring

### Check Task Status
```bash
cat /root/.openclaw/cron/jobs.json | grep -A 20 "ai-news-briefing"
```

### View Execution Logs
```bash
# OpenClaw logs
tail -f /root/.openclaw/logs/*.log

# Blog deployment logs
cd /root/.openclaw/workspace/cinagroup-site
tail -f /var/log/cloudflare-deploy.log
```

### Verify Deployment
```bash
# Visit blog to confirm
agent-browser open "https://cinagroup.com/blog"
agent-browser snapshot -i
```

---

## 🔧 Manual Execution

To execute immediately (without waiting for scheduled time):

```bash
# Manually trigger AI news briefing task
openclaw sessions spawn \
  --task "Publish AI news briefing: Search AI news from past 12 hours, select 5-7 core stories, generate Markdown briefing and publish to blog /blog" \
  --mode run
```

---

## 📋 Checklist

### Daily Check (after 06:05 and 18:05)
- [ ] 06:00/18:00 task automatically triggered
- [ ] Blog post published successfully
- [ ] Cloudflare deployment completed
- [ ] Visit `cinagroup.com/blog` to verify

### Weekly Check
- [ ] Cron configuration file backed up
- [ ] Git remote repository synced
- [ ] Execution logs error-free

---

## ⚠️ Exception Handling

### Task Not Executed
```bash
# 1. Check cron status
cat /root/.openclaw/cron/jobs.json

# 2. Restart Gateway
openclaw gateway restart

# 3. Manually execute once
openclaw sessions spawn --task "Publish AI news briefing..." --mode run
```

### Deployment Failed
```bash
# 1. Check build logs
cd /root/.openclaw/workspace/cinagroup-site
npm run build

# 2. Check Cloudflare status
cat /var/log/cloudflare-deploy.log
```

---

## 📈 Statistics

| Metric | Value |
|--------|-------|
| Total Issues | 3 |
| Success Rate | 100% |
| Avg Execution Time | ~6 minutes |
| Deployment Time | 2-5 minutes |

---

## 📝 Change Log

| Date | Change |
|------|--------|
| 2026-03-22 | Updated format: English content, date-time naming (no issue numbers) |
| 2026-03-21 | Initial setup with Chinese content |

---

**Last Updated**: 2026-03-22 09:16  
**Next Execution**: 18:00 (Today)  
**Status**: ✅ Configuration normal, awaiting execution
