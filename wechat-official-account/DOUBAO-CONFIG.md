# Doubao Seed 2.0 Pro 配置指南

## 📋 概述

微信服务号封面图生成已切换至 **Doubao Seed 2.0 Pro**（火山引擎豆包大模型）。

**优势：**
- ✅ 中文理解更好
- ✅ 生成速度快
- ✅ 成本较低
- ✅ 支持自定义尺寸（900x383）

---

## 🔑 获取 API Key

### 步骤 1：访问火山引擎控制台

1. 打开 https://console.volcengine.com/
2. 登录/注册火山引擎账号

### 步骤 2：开通 Doubao 服务

1. 进入 **大模型服务** → **豆包大模型**
2. 点击 **开通服务**
3. 选择 **Doubao Seed 2.0 Pro** 模型

### 步骤 3：创建 API Key

1. 进入 **访问凭证** → **API Key 管理**
2. 点击 **创建 API Key**
3. 填写描述（如：WeChat Cover Generation）
4. 复制并保存 API Key（只显示一次！）

### 步骤 4：配置环境变量

```bash
# 临时设置（当前会话有效）
export DOUBAO_API_KEY="sk-xxxxxxxxxxxxxxxxxxxxxxxx"

# 永久设置（推荐）
echo 'export DOUBAO_API_KEY="sk-xxxxxxxxxxxxxxxxxxxxxxxx"' >> ~/.bashrc
source ~/.bashrc
```

### 步骤 5：验证配置

```bash
# 检查环境变量
echo $DOUBAO_API_KEY

# 测试 API 调用
curl -X POST "https://ark.cn-beijing.volces.com/api/v3/images/generations" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $DOUBAO_API_KEY" \
  -d '{"model": "doubao-seed-2.0-pro", "prompt": "test", "size": "900x383"}'
```

---

## 🚀 使用方式

### 手动生成封面图

```bash
cd /root/.openclaw/workspace/wechat-official-account

# 生成 12:00 时段封面
./scripts/generate-cover-doubao.sh "AI News Briefing" "output/covers/test.png" "12"
```

### 自动发布流程

脚本会自动调用 Doubao Seed 2.0 Pro：

```bash
./scripts/publish-wechat-briefing.sh
```

---

## 📊 定价说明

**Doubao Seed 2.0 Pro 图像生成：**

| 项目 | 价格 |
|------|------|
| 标准分辨率 | ￥0.14/张 |
| 高分辨率 | ￥0.28/张 |
| 自定义尺寸 | ￥0.14/张 |

**本系统使用：** 900x383（标准分辨率）

**月度成本估算：**
- 每天 4 次 × 30 天 = 120 张/月
- 120 × ￥0.14 = **￥16.8/月**

---

## 🔧 故障排查

### 问题 1：API Key 未设置

**错误：** `DOUBAO_API_KEY 未设置`

**解决：**
```bash
export DOUBAO_API_KEY="sk-xxx"
```

### 问题 2：API 调用失败

**错误：** `API 返回错误：xxx`

**检查：**
1. API Key 是否正确
2. 账号是否已开通服务
3. 账户余额是否充足
4. 网络连接是否正常

**测试：**
```bash
curl -v -X POST "https://ark.cn-beijing.volces.com/api/v3/images/generations" \
  -H "Authorization: Bearer $DOUBAO_API_KEY" \
  -d '{"model": "doubao-seed-2.0-pro", "prompt": "test"}'
```

### 问题 3：图片下载失败

**错误：** `图片下载失败或为空`

**检查：**
1. API 返回的 URL 是否有效
2. 网络连接是否正常
3. 磁盘空间是否充足

---

## 📝 提示词优化

### 当前使用的 Prompt

```
创建一张专业的 AI 技术新闻简报封面图。
风格：现代极简主义科技新闻风格，清洁专业设计。
构图：宽幅横幅格式 900x383 像素，横向构图。
元素：抽象 AI 神经网络图案，微妙的电路板纹理，漂浮的数据粒子。
光线：{时段色彩}，柔和专业摄影灯光。
背景：清洁渐变背景，不要太复杂，留出文字叠加空间。
配色：科技蓝 (#1E90FF)，清洁白色，微妙灰色点缀。
氛围：专业、可信赖、前沿、信息丰富。
文字区域：中心留出清晰空间用于标题文字。
避免：图像中不要有文字，不要有人物，不要复杂细节，不要暗色调。
质量：高分辨率，锐利，专业杂志封面风格。
```

### 时段色彩配置

| 时段 | 色彩主题 |
|------|---------|
| 00:00 | 午夜蓝色和深紫色渐变，夜空与微妙星光 |
| 06:00 | 日出色彩，温暖橙色和柔和粉色渐变 |
| 12:00 | 明亮日光，清澈蓝天，专业商务光线 |
| 18:00 | 日落色彩，黄金时刻，温暖琥珀色和深蓝色渐变 |

### 自定义 Prompt

编辑 `generate-cover-doubao.sh` 中的 `prompt` 变量。

---

## 🔗 相关文档

- [火山引擎文档](https://www.volcengine.com/docs/)
- [Doubao API 参考](https://www.volcengine.com/docs/82379/1298386)
- [定价详情](https://www.volcengine.com/pricing)

---

## ✅ 配置检查清单

- [ ] 火山引擎账号已注册
- [ ] Doubao 服务已开通
- [ ] API Key 已创建并保存
- [ ] 环境变量已配置
- [ ] 测试调用成功
- [ ] 封面图生成正常

---

**更新时间**: 2026-03-29 14:40 (Asia/Shanghai)  
**模型版本**: Doubao Seed 2.0 Pro  
**API 端点**: https://ark.cn-beijing.volces.com/api/v3/images/generations
