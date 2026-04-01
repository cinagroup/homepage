# Doubao.com 图像生成可行性分析

## 📋 结论

**使用 doubao.com 网页版生成图片**: ⚠️ **不推荐**  
**使用火山引擎 Doubao API**: ✅ **推荐**

---

## 🔍 方案对比

### 方案 A: doubao.com 网页版 ❌

**问题**:
1. 需要登录账号
2. 需要人工交互（点击、输入等）
3. 无法自动化调用
4. 会话管理复杂
5. 可能有人机验证

**结论**: 不适合自动化流程

---

### 方案 B: 火山引擎 Doubao Seed API ✅

**优势**:
1. ✅ 官方 API，稳定可靠
2. ✅ 支持自动化调用
3. ✅ 价格合理（¥0.14/张）
4. ✅ 中文理解优秀
5. ✅ 生成速度快（~10 秒）

**获取方式**:
1. 访问 https://console.volces.com/
2. 开通豆包大模型服务
3. 创建 API Key
4. 配置环境变量

**结论**: **推荐使用此方案**

---

## 🚀 推荐方案：火山引擎 Doubao API

### 步骤 1：获取 API Key

```bash
# 访问火山引擎控制台
https://console.volces.com/

# 开通服务：大模型服务 → 豆包大模型
# 创建 API Key
```

### 步骤 2：配置环境变量

```bash
export DOUBAO_API_KEY="sk-你的 API Key"
```

### 步骤 3：测试生成

```bash
cd /root/.openclaw/workspace/wechat-official-account
export DOUBAO_API_KEY="sk-xxx"
./scripts/generate-cover-doubao.sh "AI News" "cover.png" "12"
```

---

## 📊 各平台对比

| 平台 | 状态 | 成本/月 | 推荐度 |
|------|------|--------|--------|
| **火山引擎 Doubao** | ✅ 可用 | ¥16.8 | ⭐⭐⭐⭐⭐ |
| **阿里云百炼** | ✅ 可用 | ¥14.4 | ⭐⭐⭐⭐ |
| **月之暗面 Kimi** | ⚠️ 需 Key | ¥14.4 | ⭐⭐⭐⭐ |
| **doubao.com 网页** | ❌ 不推荐 | - | ⭐ |

---

## 💡 最佳实践

### 推荐配置

**首选**: 火山引擎 Doubao Seed API
- 中文理解最好
- 生成速度快
- 官方支持

**备选**: 阿里云百炼
- 成本略低
- 阿里云生态

### 配置方式

```yaml
# config.yaml
cover:
  generate: true
  provider: "doubao-seed-2.0-pro"  # 推荐
  model: "doubao-seed-2.0-pro"
  api_env: "DOUBAO_API_KEY"
```

---

## 🔧 现有脚本

### 可用脚本

| 脚本 | 平台 | 状态 |
|------|------|------|
| `generate-cover-doubao.sh` | 火山引擎 Doubao | ✅ 就绪 |
| `generate-cover-ali.sh` | 阿里云百炼 | ✅ 就绪 |
| `generate-cover-kimi.sh` | 月之暗面 Kimi | ✅ 就绪 |
| `generate-cover-doubao-web.sh` | doubao.com 网页 | ⚠️ 不推荐 |

### 切换平台

编辑 `publish-wechat-briefing.sh`:

```bash
# 使用火山引擎 Doubao
bash "$SCRIPT_DIR/generate-cover-doubao.sh" ...

# 使用阿里云百炼
bash "$SCRIPT_DIR/generate-cover-ali.sh" ...

# 使用 Kimi 2.5
bash "$SCRIPT_DIR/generate-cover-kimi.sh" ...
```

---

## 📝 总结

### doubao.com 网页版

- ❌ 需要登录
- ❌ 无法自动化
- ❌ 不适合生产环境

### 火山引擎 Doubao API

- ✅ 官方 API
- ✅ 支持自动化
- ✅ 成本合理
- ✅ 性能优秀

**建议**: 使用火山引擎 Doubao Seed API，而不是 doubao.com 网页版。

---

## 🔗 相关链接

- 火山引擎控制台：https://console.volces.com/
- 豆包大模型：https://www.doubao.com/
- API 文档：https://www.volcengine.com/docs/82379/1298386

---

**更新时间**: 2026-03-29 15:15 (Asia/Shanghai)  
**推荐方案**: 火山引擎 Doubao Seed API
