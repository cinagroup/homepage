# ✅ 阿里云百炼集成完成 - 等待有效 API Key

## 📋 当前状态

**集成时间**: 2026-03-29 15:02 (Asia/Shanghai)  
**平台**: 阿里云百炼 (通义万相 wanx-v1)  
**状态**: 🟡 脚本已就绪，等待有效 API Key

---

## ⚠️ API Key 问题

**当前使用的 Key**: `sk-sp-db6b165f539d4de8b742aee629d23b5f`

**错误信息**: `Invalid API-key provided.`

**可能原因**:
1. API Key 未激活
2. API Key 权限不足
3. 账号未开通图像生成服务
4. Key 格式不正确

---

## 🔑 正确的配置步骤

### 步骤 1：访问阿里云百炼控制台

打开：https://bailian.console.aliyun.com/

### 步骤 2：登录阿里云账号

使用您的阿里云账号登录

### 步骤 3：开通服务

1. 进入 **模型广场**
2. 找到 **通义万相** (图像生成模型)
3. 点击 **开通服务**

### 步骤 4：创建 API Key

1. 进入 **API-KEY 管理**
2. 点击 **创建新的 API-KEY**
3. 复制 API Key（格式：`sk-xxxxxxxxxxxxxxxx`）

### 步骤 5：充值账户

1. 进入 **费用中心**
2. 确保账户有足够余额
3. 通义万相图像生成约 ¥0.12/张

### 步骤 6：设置环境变量

```bash
# 临时设置
export ALI_API_KEY="sk-你的新 API Key"

# 永久设置
echo 'export ALI_API_KEY="sk-你的新 API Key"' >> ~/.bashrc
source ~/.bashrc
```

---

## 🚀 测试命令

```bash
cd /root/.openclaw/workspace/wechat-official-account
export ALI_API_KEY="sk-你的有效 API Key"
./scripts/generate-cover-ali.sh "AI News Briefing" "output/covers/test.png" "12"
```

---

## 📁 已创建文件

```
wechat-official-account/
├── ALI-CONFIG.md                     # 阿里云百炼配置指南
├── scripts/
│   └── generate-cover-ali.sh         # 阿里云百炼封面生成脚本 ✅
└── config.yaml                       # 已更新为 ali-bailian ✅
```

---

## 🎯 脚本功能

### generate-cover-ali.sh

**功能**:
- ✅ 支持 4 个时段不同风格 (00/06/12/18)
- ✅ 自动生成中文 prompt
- ✅ 调用阿里云百炼 API
- ✅ 异步任务轮询
- ✅ 下载并保存封面图
- ✅ 错误处理和日志记录

**使用方式**:
```bash
./scripts/generate-cover-ali.sh <标题> <输出文件> <时段>
```

---

## 💰 成本分析

**通义万相定价**: 约 ¥0.12/张

**月度成本**:
- 每天 4 次 × 30 天 = 120 张/月
- 120 × ¥0.12 = **¥14.4/月**

---

## 📝 时段风格

| 时段 | 色彩主题 | 氛围 |
|------|---------|------|
| 00:00 | 午夜蓝色和深紫色 | 静谧、专业 |
| 06:00 | 日出橙色和粉色 | 温暖、希望 |
| 12:00 | 明亮蓝天 | 专业、商务 |
| 18:00 | 日落琥珀色 | 温暖、黄金时刻 |

---

## 🔧 故障排查

### 错误：InvalidApiKey

**原因**: API Key 无效或未激活

**解决**:
1. 检查 API Key 是否正确
2. 确认已开通通义万相服务
3. 确认账户有余额

### 错误：InsufficientBalance

**原因**: 账户余额不足

**解决**:
1. 访问 https://usercenter2.aliyun.com/
2. 充值账户

### 错误：RateLimitExceeded

**原因**: API 调用频率超限

**解决**:
1. 等待 1 分钟后重试
2. 检查并发调用

---

## ⏳ 下一步

### 等待您提供：

1. **有效的阿里云百炼 API Key**
   - 从 https://bailian.console.aliyun.com/ 获取
   - 确保已开通通义万相服务
   - 确保账户有余额

2. **配置后测试**:
   ```bash
   export ALI_API_KEY="sk-你的真实 API Key"
   ./scripts/generate-cover-ali.sh "Test" "test.png" "12"
   ```

3. **验证生成结果**:
   ```bash
   ls -lh output/covers/
   file output/covers/test.png
   ```

---

## 📞 快速参考

### 环境变量

```bash
export ALI_API_KEY="sk-xxx"
```

### 测试命令

```bash
./scripts/generate-cover-ali.sh "AI News Briefing" "output/covers/test.png" "12"
```

### 查看日志

```bash
tail -f logs/ali-cover-generation.log
```

### 官方链接

- 百炼控制台：https://bailian.console.aliyun.com/
- 通义万相：https://tongyi.aliyun.com/wanxiang
- API 文档：https://help.aliyun.com/zh/dashscope/

---

## ✅ 完成清单

- [x] 阿里云百炼脚本创建
- [x] 主发布脚本更新
- [x] 配置文件更新
- [x] 配置文档编写
- [ ] **等待有效 API Key 配置** ⏳
- [ ] 测试封面生成
- [ ] 验证生成质量

---

**更新时间**: 2026-03-29 15:02 (Asia/Shanghai)  
**状态**: 🟡 脚本就绪，等待有效 API Key  
**下次执行**: 2026-03-29 18:00 (Asia/Shanghai)
