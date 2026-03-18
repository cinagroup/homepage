# CinaGroup 网站部署说明

## ✅ 部署状态

| 组件 | 状态 | 说明 |
|------|------|------|
| **Docker 容器** | ✅ 运行中 | AstroWind 网站 (端口 8080) |
| **Nginx** | ✅ 运行中 | 反向代理 + HTTPS |
| **SSL 证书** | ✅ 已配置 | 自签名证书 (有效期 1 年) |
| **HTTP 重定向** | ✅ 已启用 | 自动跳转到 HTTPS |
| **域名** | ✅ 已解析 | cinagroup.com → 101.32.108.223 |

---

## 🌐 访问地址

- **HTTPS**: https://cinagroup.com
- **HTTP**: http://cinagroup.com (自动重定向到 HTTPS)

---

## 📁 配置文件位置

| 文件 | 路径 | 说明 |
|------|------|------|
| **Nginx 配置** | `/etc/nginx/sites-available/cinagroup.com` | 反向代理 + HTTPS 配置 |
| **SSL 证书** | `/etc/ssl/certs/cinagroup.com.crt` | 公钥证书 |
| **SSL 私钥** | `/etc/ssl/private/cinagroup.com.key` | 私钥文件 |
| **网站源码** | `/root/.openclaw/workspace/cinagroup-site/` | AstroWind 项目 |

---

## 🔒 SSL 证书说明

当前使用的是**自签名证书**，适用于：
- ✅ 内部测试
- ✅ 开发环境
- ✅ 演示用途

**浏览器会显示安全警告**，需要手动信任。

### 替换为 Let's Encrypt 正式证书

当域名 DNS 完全生效后，可以免费申请正式 SSL 证书：

```bash
# 停止 Nginx 临时释放 80 端口
systemctl stop nginx

# 使用 standalone 模式申请证书
certbot certonly --standalone \
  -d cinagroup.com \
  -d www.cinagroup.com \
  --email admin@cinagroup.com \
  --agree-tos \
  --non-interactive

# 启动 Nginx
systemctl start nginx

# 更新 Nginx 配置中的证书路径
# /etc/letsencrypt/live/cinagroup.com/fullchain.pem
# /etc/letsencrypt/live/cinagroup.com/privkey.pem

# 重新加载 Nginx
nginx -t && nginx -s reload
```

### 自动续期

Let's Encrypt 证书有效期 90 天，已配置自动续期：

```bash
# 测试自动续期
certbot renew --dry-run

# 查看续期定时器
systemctl list-timers | grep certbot
```

---

## 🛠️ 常用命令

### Docker 容器管理

```bash
# 查看容器状态
docker ps | grep astrowind

# 查看日志
docker logs astrowind

# 重启容器
docker restart astrowind

# 停止容器
docker stop astrowind

# 删除容器
docker rm -f astrowind
```

### Nginx 管理

```bash
# 查看状态
systemctl status nginx

# 重启 Nginx
systemctl restart nginx

# 测试配置
nginx -t

# 重新加载配置
nginx -s reload

# 查看错误日志
tail -f /var/log/nginx/error.log
```

### 网站更新

```bash
# 进入项目目录
cd /root/.openclaw/workspace/cinagroup-site

# 修改源代码后重新构建
npm run build

# 重启 Docker 容器
docker restart astrowind
```

---

## 🎨 网站定制

### 修改网站配置

编辑 `src/config.yaml`：

```yaml
site:
  name: CinaGroup
  site: 'https://cinagroup.com'
  
metadata:
  title:
    default: CinaGroup
  description: "CinaGroup - Professional Business Solutions"
```

### 修改页面内容

| 页面 | 文件路径 |
|------|---------|
| 首页 | `src/pages/index.astro` |
| 关于我们 | `src/pages/about.astro` |
| 服务 | `src/pages/services.astro` |
| 联系我们 | `src/pages/contact.astro` |
| 价格 | `src/pages/pricing.astro` |

### 修改品牌元素

| 元素 | 位置 |
|------|------|
| Logo | `src/components/Logo.astro` |
| 颜色 | `src/config.yaml` (ui.theme) |
| 图片 | `src/assets/images/` |

---

## 📊 网站架构

```
用户请求
    ↓
Nginx (80/443)
    ↓ (反向代理)
Docker 容器 (8080)
    ↓
AstroWind 网站
```

---

## 🔧 故障排查

### 网站无法访问

1. 检查 Docker 容器状态：
   ```bash
   docker ps | grep astrowind
   ```

2. 检查 Nginx 状态：
   ```bash
   systemctl status nginx
   ```

3. 查看错误日志：
   ```bash
   tail -f /var/log/nginx/error.log
   docker logs astrowind
   ```

### SSL 证书问题

1. 检查证书文件是否存在：
   ```bash
   ls -la /etc/ssl/certs/cinagroup.com.crt
   ls -la /etc/ssl/private/cinagroup.com.key
   ```

2. 测试证书有效性：
   ```bash
   openssl x509 -in /etc/ssl/certs/cinagroup.com.crt -text -noout
   ```

### DNS 解析问题

```bash
# 检查域名解析
dig cinagroup.com
ping cinagroup.com
```

---

## 📝 下一步建议

1. **配置正式 SSL 证书** - 域名生效后申请 Let's Encrypt
2. **定制网站内容** - 修改首页、关于我们等页面
3. **添加分析统计** - 配置 Google Analytics
4. **配置联系表单** - 让客户可以联系你
5. **SEO 优化** - 优化 meta 标签和 sitemap
6. **备份配置** - 定期备份重要配置文件

---

## 📞 技术支持

如有问题，请联系管理员或查看：
- Nginx 文档：https://nginx.org/en/docs/
- AstroWind 文档：https://github.com/arthelokyo/astrowind
- Docker 文档：https://docs.docker.com/

---

**部署时间**: 2026-03-18  
**部署人员**: 001  
**服务器 IP**: 101.32.108.223
