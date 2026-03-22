# OpenClaw 多机器人备份仓库

存储 CINA 系列机器人的配置、脚本和记忆数据

## 🤖 机器人列表

| 机器人 ID | 用途 | 状态 |
|----------|------|------|
| CINA_10001 | 主机器人 - 数字管家 | 🟢 运行中 |
| CINA_10002 | 备用机器人 - 客服支持 | ⏳ 待配置 |
| CINA_10003 | 专用机器人 - 数据监控 | ⏳ 待配置 |

## 📁 目录结构

```
openclaw-robots-backup/
├── CINA_10001/           # 主机器人配置
│   ├── config/           # 配置文件（不含敏感信息）
│   ├── scripts/          # 专属脚本
│   ├── memory/           # 记忆数据
│   └── logs/             # 日志（.gitignore）
├── CINA_10002/           # 备用机器人配置
│   ├── config/
│   ├── scripts/
│   ├── memory/
│   └── logs/
├── CINA_10003/           # 专用机器人配置
│   ├── config/
│   ├── scripts/
│   ├── memory/
│   └── logs/
├── scripts/              # 共享脚本
│   └── auto-backup.sh    # 自动备份脚本
├── README.md
└── .gitignore
```

## 🔐 安全说明

**敏感信息处理**:
- ✅ 配置文件使用占位符（如 `${API_KEY}`）
- ✅ 真实密钥存储在本地环境变量
- ✅ `.gitignore` 过滤敏感文件
- ✅ 仓库设为私有

**敏感文件示例**（已加入 .gitignore）:
- `config-local.json` - 本地配置（含密钥）
- `*.log` - 日志文件
- `.env` - 环境变量文件
- `*.token` - Token 文件

## 🚀 自动化备份

### 立即备份

```bash
cd /root/.openclaw/workspace/openclaw-robots-backup
bash scripts/auto-backup.sh
```

### 定时备份（每小时）

```bash
crontab -e
# 添加：
0 * * * * /root/.openclaw/workspace/openclaw-robots-backup/scripts/auto-backup.sh
```

## 📋 Commit 规范

格式：`[机器人 ID] 改动类型：具体描述`

示例：
- `[CINA_10001] feat: 添加抢购脚本`
- `[CINA_10001] fix: 修复记忆备份 bug`
- `[CINA_10002] config: 更新配置文件`
- `[CINA_10003] docs: 添加说明文档`

改动类型：
- `feat` - 新功能
- `fix` - 修复 bug
- `config` - 配置变更
- `docs` - 文档更新
- `memory` - 记忆数据更新

## 🔄 恢复配置

```bash
# 克隆仓库
git clone https://github.com/cinagroup/openclaw-robots-backup.git

# 恢复特定机器人配置
cp -r openclaw-robots-backup/CINA_10001/config/* /path/to/openclaw/CINA_10001/

# 填写真实密钥（从本地环境变量或加密文件）
# 重启机器人
```

## 📊 备份验证

```bash
# 检查目录结构
ls -la CINA_10001/ CINA_10002/ CINA_10003/

# 检查是否有敏感文件泄露
git ls-files | grep -E "(token|secret|password|\.log)"

# 查看提交历史
git log --oneline -10
```

---

**仓库维护**: CINA Team  
**创建时间**: 2026-03-19  
**可见性**: 🔒 私有
