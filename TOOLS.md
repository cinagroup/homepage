# TOOLS.md - Local Notes

Skills define _how_ tools work. This file is for _your_ specifics — the stuff that's unique to your setup.

## What Goes Here

Things like:

- Camera names and locations
- SSH hosts and aliases
- Preferred voices for TTS
- Speaker/room names
- Device nicknames
- Anything environment-specific

## Examples

```markdown
### Cameras

- living-room → Main area, 180° wide angle
- front-door → Entrance, motion-triggered

### SSH

- home-server → 192.168.1.100, user: admin

### TTS

- Preferred voice: "Nova" (warm, slightly British)
- Default speaker: Kitchen HomePod
```

## Why Separate?

Skills are shared. Your setup is yours. Keeping them apart means you can update skills without losing your notes, and share skills without leaking your infrastructure.

---

Add whatever helps you do your job. This is your cheat sheet.

## CinaGroup News Briefing Schedule

- **Standard schedule**: 06:00 and 18:00 (Asia/Shanghai)
- **Publish offset**: -30 minutes (publish at 05:30 and 17:30)
- **Repository**: cinagroup/homepage → `src/data/post/ai-news-briefing-YYYY-MM-DD-HH.md`
- **Format**: Follow existing briefing template with 7 top stories + trend watch

**Example:**
- 06:00 briefing → publish at 05:30
- 18:00 briefing → publish at 17:30
