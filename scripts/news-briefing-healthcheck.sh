#!/bin/bash
# CinaGroup AI News Briefing Health Check
# Runs every hour to verify briefings are published on time
# Alerts if a briefing is missing or delayed

set -e

LOG_FILE="/root/.openclaw/workspace/logs/news-briefing-healthcheck.log"
ALERT_LOG="/root/.openclaw/workspace/logs/news-briefing-alerts.log"

mkdir -p "$(dirname "$LOG_FILE")"
mkdir -p "$(dirname "$ALERT_LOG")"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

alert() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] 🚨 ALERT: $1" | tee -a "$ALERT_LOG"
    # Could add notification here (email, webhook, etc.)
}

CURRENT_HOUR=$(date +%H)
CURRENT_DATE=$(date +%Y-%m-%d)
YESTERDAY=$(date -d "yesterday" +%Y-%m-%d)

log "🔍 Running briefing health check..."

# Check morning briefing (should be published by 05:30)
if [ "$CURRENT_HOUR" -ge 6 ]; then
    MORNING_FILE="/root/.openclaw/workspace/cinagroup-site/src/data/post/ai-news-briefing-${CURRENT_DATE}-06.md"
    if [ ! -f "$MORNING_FILE" ]; then
        alert "Morning briefing (06:00) for ${CURRENT_DATE} is MISSING! Expected at 05:30"
    else
        log "✅ Morning briefing found: $(basename "$MORNING_FILE")"
    fi
fi

# Check evening briefing (should be published by 17:30)
if [ "$CURRENT_HOUR" -ge 18 ]; then
    EVENING_FILE="/root/.openclaw/workspace/cinagroup-site/src/data/post/ai-news-briefing-${CURRENT_DATE}-18.md"
    if [ ! -f "$EVENING_FILE" ]; then
        alert "Evening briefing (18:00) for ${CURRENT_DATE} is MISSING! Expected at 17:30"
    else
        log "✅ Evening briefing found: $(basename "$EVENING_FILE")"
    fi
fi

# Check if website is live with latest briefing
log "🌐 Checking website deployment status..."
if command -v agent-browser &> /dev/null; then
    agent-browser open "https://cinagroup.com/blog" >/dev/null 2>&1 || log "⚠️  Could not access website"
    
    SNAPSHOT=$(agent-browser snapshot -i 2>/dev/null || echo "")
    
    if echo "$SNAPSHOT" | grep -q "AI News Briefing | ${CURRENT_DATE}"; then
        log "✅ Today's briefing is live on website"
    else
        log "⚠️  Today's briefing not yet visible on website (may be deploying)"
    fi
    
    agent-browser close >/dev/null 2>&1
fi

# Check recent logs for errors
PUBLISH_LOG="/root/.openclaw/workspace/logs/news-briefing-publish.log"
if [ -f "$PUBLISH_LOG" ]; then
    RECENT_ERRORS=$(tail -100 "$PUBLISH_LOG" | grep -i "error\|failed\|❌" || true)
    if [ -n "$RECENT_ERRORS" ]; then
        alert "Errors found in publish log:\n$RECENT_ERRORS"
    fi
fi

log "✅ Health check complete"
