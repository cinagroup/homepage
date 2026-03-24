# 📰 CinaGroup AI News Briefing Auto-Publish System

## Overview

Automated system for publishing AI News Briefings twice daily, 30 minutes before the stated briefing time.

## Schedule (Asia/Shanghai)

| Briefing | Coverage Period | **Publish Time** |
|----------|-----------------|------------------|
| Morning (06:00) | Previous day 18:00 — Today 06:00 | **05:30** |
| Evening (18:00) | Today 06:00 — Today 18:00 | **17:30** |

## Components

### 1. Auto-Publish Script
**Location**: `/root/.openclaw/workspace/scripts/news-briefing-auto-publish.sh`

**Usage**:
```bash
# Auto-detect based on current time
./news-briefing-auto-publish.sh

# Specify period manually
./news-briefing-auto-publish.sh 06   # Morning briefing
./news-briefing-auto-publish.sh 18   # Evening briefing
```

**What it does**:
1. Collects latest AI news from TechCrunch
2. Generates briefing markdown file
3. Commits to `cinagroup/homepage` repository
4. Pushes to GitHub (triggers auto-deploy)
5. Verifies deployment on cinagroup.com/blog

### 2. Health Check Script
**Location**: `/root/.openclaw/workspace/scripts/news-briefing-healthcheck.sh`

**Runs**: Every hour

**What it does**:
- Verifies morning briefing exists (after 06:00)
- Verifies evening briefing exists (after 18:00)
- Checks website deployment status
- Scans logs for errors
- Alerts if briefing is missing or delayed

### 3. Cron Jobs
**Location**: `/root/.openclaw/workspace/cron-briefing-jobs.txt`

**Installed jobs**:
```cron
# Morning briefing at 05:30
30 5 * * * /root/.openclaw/workspace/scripts/news-briefing-auto-publish.sh 06

# Evening briefing at 17:30
30 17 * * * /root/.openclaw/workspace/scripts/news-briefing-auto-publish.sh 18

# Health check every hour
0 * * * * /root/.openclaw/workspace/scripts/news-briefing-healthcheck.sh
```

## Logs

| Log File | Purpose |
|----------|---------|
| `logs/news-briefing-publish.log` | Main publish script logs |
| `logs/news-briefing-06.log` | Morning briefing logs |
| `logs/news-briefing-18.log` | Evening briefing logs |
| `logs/news-briefing-healthcheck.log` | Health check logs |
| `logs/news-briefing-alerts.log` | ⚠️ Alert notifications |

## Manual Override

### Skip a briefing
If a briefing should not be published (e.g., holiday, breaking news delay):
```bash
# Create an empty placeholder file
touch /root/.openclaw/workspace/cinagroup-site/src/data/post/ai-news-briefing-YYYY-MM-DD-HH.md
```
The script will detect the file exists and skip generation.

### Manual publish
```bash
cd /root/.openclaw/workspace
./scripts/news-briefing-auto-publish.sh 06  # Morning
./scripts/news-briefing-auto-publish.sh 18  # Evening
```

### Check status
```bash
# View recent logs
tail -50 /root/.openclaw/workspace/logs/news-briefing-publish.log

# Check for alerts
cat /root/.openclaw/workspace/logs/news-briefing-alerts.log

# Verify cron jobs
crontab -l | grep briefing
```

## File Format

Briefings are stored in:
`/root/.openclaw/workspace/cinagroup-site/src/data/post/ai-news-briefing-YYYY-MM-DD-HH.md`

Example: `ai-news-briefing-2026-03-24-06.md`

## Deployment Flow

```
┌─────────────────────────────────────────────────────────────┐
│  Cron triggers at 05:30 or 17:30                            │
└─────────────────────────────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────┐
│  news-briefing-auto-publish.sh                              │
│  1. Collect news from TechCrunch                            │
│  2. Generate markdown file                                  │
│  3. Git commit + push                                       │
└─────────────────────────────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────┐
│  GitHub Actions / Vercel / Netlify                          │
│  Auto-deploy triggered                                      │
└─────────────────────────────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────┐
│  cinagroup.com/blog                                         │
│  Briefing goes live (~2-5 minutes)                          │
└─────────────────────────────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────┐
│  Health check verifies deployment                           │
│  Alerts if something fails                                  │
└─────────────────────────────────────────────────────────────┘
```

## Troubleshooting

### Briefing not published
1. Check cron logs: `grep CRON /var/log/syslog | grep briefing`
2. Check script logs: `tail -100 logs/news-briefing-*.log`
3. Verify git status: `cd cinagroup-site && git status`
4. Manual retry: `./scripts/news-briefing-auto-publish.sh [06|18]`

### Website not updated
1. Check GitHub Actions: https://github.com/cinagroup/homepage/actions
2. Wait 5-10 minutes for deployment
3. Hard refresh: `Ctrl+Shift+R` or clear cache

### Health check alerting
1. Review alert log: `cat logs/news-briefing-alerts.log`
2. Check if file exists in `cinagroup-site/src/data/post/`
3. Verify cron jobs: `crontab -l`

## Configuration

Edit `TOOLS.md` to adjust:
- Publish offset (currently -30 minutes)
- Briefing times (currently 06:00 and 18:00)
- Repository path

---

**Last Updated**: 2026-03-24  
**Maintained by**: 001
