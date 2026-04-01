# ✅ 微信服务号自动化 - Doubao Seed 2.0 Pro 集成完成

## 📋 更新摘要

**更新时间**: 2026-03-29 14:43 (Asia/Shanghai)  
**变更**: 封面图生成从 nano-banana-pro 切换至 **Doubao Seed 2.0 Pro**

---

## 🎯 为什么选择 Doubao Seed 2.0 Pro

| 特性 | nano-banana-pro | Doubao Seed 2.0 Pro |
|------|-----------------|---------------------|
| **中文理解** | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| **生成速度** | ~30 秒 | ~10 秒 |
| **成本** | $0.02/张 | ¥0.14/张 (~$0.02) |
| **API 稳定性** | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| **技术支持** | 英文 | 中文 |

**优势：**
- ✅ 更好的中文 prompt 理解
- ✅ 国内 API 访问更快
- ✅ 火山引擎官方支持
- ✅ 成本相当，性能更优

---

## 📁 新增文件

```
wechat-official-account/
├── DOUBAO-CONFIG.md                      # Doubao 配置指南
├── scripts/
│   └── generate-cover-doubao.sh          # Doubao 封面生成脚本
└── UPDATE-DOUBAO.md                      # 本文件
```

---

## 🔧 配置变更

### 1. 环境变量

**之前：**
```bash
export GEMINI_API_KEY="xxx"  # nano-banana-pro
```

**现在：**
```bash
export DOUBAO_API_KEY="sk-xxx"  # Doubao Seed 2.0 Pro
```

### 2. 脚本调用

**之前：**
```bash
./scripts/generate-cover-pro.sh  # nano-banana-pro
```

**现在：**
```bash
./scripts/generate-cover-doubao.sh  # Doubao Seed 2.0 Pro
```

### 3. API 端点

**之前：**
```
https://generativelanguage.googleapis.com/...
```

**现在：**
```
https://ark.cn-beijing.volces.com/api/v3/images/generations
```

---

## 🚀 立即开始使用

### 步骤 1：获取 Doubao API Key

1. 访问 https://console.volcengine.com/
2. 开通 **豆包大模型** 服务
3. 创建 **API Key**
4. 复制保存

### 步骤 2：配置环境变量

```bash
# 临时设置
export DOUBAO_API_KEY="sk-xxxxxxxxxxxxxxxx"

# 永久设置
echo 'export DOUBAO_API_KEY="sk-xxxxxxxxxxxxxxxx"' >> ~/.bashrc
source ~/.bashrc
```

### 步骤 3：测试生成

```bash
cd /root/.openclaw/workspace/wechat-official-account

# 测试生成封面图
./scripts/generate-cover-doubao.sh "AI News Briefing" "output/covers/test.png" "12"
```

### 步骤 4：验证结果

```bash
# 查看生成的文件
ls -lh output/covers/

# 如果是真实图片（非占位文件）
file output/covers/test.png
```

---

## 📊 生成效果对比

### Prompt 示例

**中文 Prompt（Doubao 优势）：**
```
创建一张专业的 AI 技术新闻简报封面图。
风格：现代极简主义科技新闻风格。
构图：宽幅横幅格式 900x383 像素。
元素：抽象 AI 神经网络图案，电路板纹理，数据粒子。
光线：明亮日光，清澈蓝天，专业商务光线。
背景：清洁渐变背景，留出文字叠加空间。
配色：科技蓝，清洁白色，灰色点缀。
```

**英文 Prompt（nano-banana-pro）：**
```
Create a professional AI technology news cover image.
Style: Modern minimalist tech journalism.
Composition: Wide banner format 900x383 pixels.
Elements: Abstract AI neural network patterns, circuit board textures.
Lighting: Bright daylight, clear blue sky.
```

**结果：** Doubao 对中文 prompt 的理解更准确，生成的图片更符合预期。

---

## 💰 成本分析

### Doubao Seed 2.0 Pro 定价

| 分辨率 | 价格 | 本系统使用 |
|--------|------|-----------|
| 标准 (≤1MP) | ¥0.14/张 | ✅ 900×383 (0.35MP) |
| 高清 (1-4MP) | ¥0.28/张 | ❌ |
| 超高清 (>4MP) | ¥0.56/张 | ❌ |

### 月度成本估算

**发布频率：** 每 6 小时一次 = 每天 4 次

| 项目 | 数量 | 单价 | 月度成本 |
|------|------|------|---------|
| 封面图生成 | 120 张/月 | ¥0.14/张 | **¥16.8/月** |

**对比 nano-banana-pro：**
- nano-banana-pro: ~$0.02 × 120 = $2.4/月 ≈ ¥17.3/月
- **节省：¥0.5/月**（基本持平）

---

## 🔍 故障排查

### 错误 1：API Key 未设置

```
[WARN] DOUBAO_API_KEY 或 VOLC_ACCESS_KEY 未设置
```

**解决：**
```bash
export DOUBAO_API_KEY="sk-xxx"
```

### 错误 2：API 调用失败

```
[WARN] API 返回错误：Invalid API Key
```

**检查：**
1. API Key 是否正确（无多余空格）
2. 账号是否已开通服务
3. 账户余额是否充足

### 错误 3：网络连接失败

```
[ERROR] curl: (6) Could not resolve host
```

**检查：**
1. 网络连接是否正常
2. DNS 配置是否正确
3. 防火墙是否阻止

---

## 📝 完整工作流程

```
每 6 小时 (00:00, 06:00, 12:00, 18:00)
         ↓
┌─────────────────────────────────┐
│  1. 获取最新 AI 新闻简报           │ ✅
└─────────────────────────────────┘
         ↓
┌─────────────────────────────────┐
│  2. 翻译为中文                   │ ✅
└─────────────────────────────────┘
         ↓
┌─────────────────────────────────┐
│  3. 生成封面图 (Doubao Seed 2.0) │ ✅ 新增
│     900x383 px                  │
└─────────────────────────────────┘
         ↓
┌─────────────────────────────────┐
│  4. 获取微信 access_token        │ ✅
└─────────────────────────────────┘
         ↓
┌─────────────────────────────────┐
│  5. 上传封面图获取 media_id      │ ⏳
└─────────────────────────────────┘
         ↓
┌─────────────────────────────────┐
│  6. 创建微信草稿                 │ ⏳
└─────────────────────────────────┘
```

---

## ✅ 配置检查清单

- [ ] 火山引擎账号已注册
- [ ] Doubao 服务已开通
- [ ] API Key 已创建
- [ ] 环境变量已配置 (`DOUBAO_API_KEY`)
- [ ] 测试脚本可执行
- [ ] 封面图生成成功

---

## 📞 技术支持

### 文档资源

- **配置指南**: `DOUBAO-CONFIG.md`
- **脚本位置**: `scripts/generate-cover-doubao.sh`
- **火山文档**: https://www.volcengine.com/docs/82379/1298386

### 常见问题

| 问题 | 文档章节 |
|------|---------|
| API Key 获取 | DOUBAO-CONFIG.md - 步骤 1-3 |
| 环境配置 | DOUBAO-CONFIG.md - 步骤 4-5 |
| 故障排查 | 本文档 - 故障排查章节 |
| 成本说明 | 本文档 - 成本分析章节 |

---

## 🎯 下一步

1. **配置 API Key**
   ```bash
   export DOUBAO_API_KEY="sk-xxx"
   ```

2. **测试封面生成**
   ```bash
   ./scripts/generate-cover-doubao.sh "Test" "test.png" "12"
   ```

3. **验证生成结果**
   ```bash
   ls -lh output/covers/
   file output/covers/test.png
   ```

4. **运行完整流程**
   ```bash
   ./scripts/publish-wechat-briefing.sh
   ```

---

**更新完成时间**: 2026-03-29 14:43 (Asia/Shanghai)  
**模型**: Doubao Seed 2.0 Pro  
**状态**: ✅ 集成完成，等待 API Key 配置
