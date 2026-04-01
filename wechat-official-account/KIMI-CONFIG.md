# Kimi 2.5 配置指南

## 📋 概述

微信服务号封面图生成已切换至 **Kimi 2.5**（月之暗面）。

**模型 ID**: `7f1ac782-cbf6-4bb8-b8ba-e1e5bfc17268`

**优势：**
- ✅ 优秀的中文理解能力
- ✅ 强大的图像生成质量
- ✅ 快速响应
- ✅ 合理的定价

---

## 🔑 获取 API Key

### 步骤 1：访问月之暗面平台

打开 https://platform.moonshot.cn/

### 步骤 2：注册/登录账号

1. 使用手机号或邮箱注册
2. 完成账号验证

### 步骤 3：开通 API 服务

1. 进入 **控制台** → **API 管理**
2. 点击 **开通 API 服务**
3. 阅读并同意服务条款

### 步骤 4：创建 API Key

1. 进入 **API Keys** 页面
2. 点击 **创建新的 API Key**
3. 填写描述（如：WeChat Cover - Kimi 2.5）
4. 复制并保存 API Key（只显示一次！）

**API Key 格式**: `sk-xxxxxxxxxxxxxxxxxxxxxxxx`

### 步骤 5：配置环境变量

```bash
# 临时设置（当前会话有效）
export KIMI_API_KEY="sk-xxxxxxxxxxxxxxxxxxxxxxxx"

# 永久设置（推荐）
echo 'export KIMI_API_KEY="sk-xxxxxxxxxxxxxxxxxxxxxxxx"' >> ~/.bashrc
source ~/.bashrc
```

### 步骤 6：验证配置

```bash
# 检查环境变量
echo $KIMI_API_KEY

# 测试 API 调用
curl -X POST "https://api.moonshot.cn/v1/images/generations" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $KIMI_API_KEY" \
  -d '{"model": "kimi-2.5", "prompt": "test image", "size": "900x383"}'
```

---

## 🚀 使用方式

### 手动生成封面图

```bash
cd /root/.openclaw/workspace/wechat-official-account

# 生成 12:00 时段封面
./scripts/generate-cover-kimi.sh "AI News Briefing" "output/covers/test.png" "12"
```

### 自动发布流程

脚本会自动调用 Kimi 2.5：

```bash
./scripts/publish-wechat-briefing.sh
```

---

## 📊 定价说明

**Kimi 2.5 图像生成定价：**

| 规格 | 价格 | 本系统使用 |
|------|------|-----------|
| 标准版 | ¥0.12/张 | ✅ 900×383 |
| 高清版 | ¥0.24/张 | ❌ |
| 超清版 | ¥0.48/张 | ❌ |

**月度成本估算：**
- 每天 4 次 × 30 天 = 120 张/月
- 120 × ¥0.12 = **¥14.4/月**

**对比其他模型：**
| 模型 | 月度成本 |
|------|---------|
| Kimi 2.5 | ¥14.4/月 |
| Doubao Seed 2.0 | ¥16.8/月 |
| nano-banana-pro | ~¥17.3/月 |

**💰 Kimi 2.5 最经济！**

---

## 🔧 故障排查

### 问题 1：API Key 未设置

**错误：** `KIMI_API_KEY 未设置`

**解决：**
```bash
export KIMI_API_KEY="sk-xxx"
```

### 问题 2：认证失败

**错误：** `Invalid API Key` 或 `Authentication failed`

**检查：**
1. API Key 是否正确（无多余空格）
2. API Key 是否已激活
3. 账号是否已开通 API 服务

**测试：**
```bash
curl -v -X POST "https://api.moonshot.cn/v1/images/generations" \
  -H "Authorization: Bearer $KIMI_API_KEY" \
  -d '{"model": "kimi-2.5", "prompt": "test"}'
```

### 问题 3：余额不足

**错误：** `Insufficient balance` 或 `余额不足`

**解决：**
1. 访问 https://platform.moonshot.cn/console/billing
2. 充值账户
3. 检查套餐余量

### 问题 4：速率限制

**错误：** `Rate limit exceeded`

**解决：**
- 等待 1 分钟后重试
- 检查 API 调用频率
- 考虑升级套餐

---

## 📝 提示词优化

### 当前使用的 Prompt

```
创建一张专业的 AI 技术新闻简报封面图，用于微信公众号文章。

【设计要求】
- 风格：现代极简主义科技新闻风格，清洁专业设计
- 构图：宽幅横幅格式，宽高比约 2.35:1（900x383 像素）
- 元素：抽象 AI 神经网络图案，微妙的电路板纹理，漂浮的数据粒子
- 光线：{时段色彩}，柔和专业摄影灯光
- 背景：清洁渐变背景，留出文字叠加空间
- 配色：科技蓝 (#1E90FF) 为主色调，清洁白色，微妙灰色点缀
- 氛围：专业、可信赖、前沿、信息丰富
- 文字区域：中心或偏上位置留出清晰空间用于标题文字
- 避免：图像中不要有文字，不要有人物，不要复杂细节

【技术规格】
- 分辨率：高质量，适合 900x383 像素输出
- 格式：PNG
- 质量：高分辨率，锐利，专业杂志封面风格
```

### 时段色彩配置

| 时段 | 色彩主题 |
|------|---------|
| 00:00 | 午夜蓝色和深紫色渐变，夜空与微妙星光 |
| 06:00 | 日出色彩，温暖橙色和柔和粉色渐变 |
| 12:00 | 明亮日光，清澈蓝天，专业商务光线 |
| 18:00 | 日落色彩，黄金时刻，温暖琥珀色和深蓝色渐变 |

---

## 📞 技术支持

### 官方文档

- **月之暗面平台**: https://platform.moonshot.cn/
- **API 文档**: https://platform.moonshot.cn/docs/api
- **定价详情**: https://platform.moonshot.cn/pricing
- **控制台**: https://platform.moonshot.cn/console

### 常见问题

| 问题 | 解决方案 |
|------|----------|
| API Key 获取 | 控制台 → API 管理 → 创建 Key |
| 充值 | 控制台 → 账单管理 → 充值 |
| 使用量查询 | 控制台 → 用量统计 |
| 技术支持 | support@moonshot.cn |

---

## ✅ 配置检查清单

- [ ] 月之暗面账号已注册
- [ ] API 服务已开通
- [ ] API Key 已创建并保存
- [ ] 环境变量已配置 (`KIMI_API_KEY`)
- [ ] 账户有足够余额
- [ ] 测试调用成功
- [ ] 封面图生成正常

---

## 🔗 相关文档

- `generate-cover-kimi.sh` - Kimi 封面生成脚本
- `publish-wechat-briefing.sh` - 自动发布主脚本
- `config.yaml` - 系统配置文件

---

**更新时间**: 2026-03-29 14:55 (Asia/Shanghai)  
**模型版本**: Kimi 2.5  
**模型 ID**: 7f1ac782-cbf6-4bb8-b8ba-e1e5bfc17268  
**API 端点**: https://api.moonshot.cn/v1/images/generations
