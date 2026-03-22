# V2Ray 安装与配置指南

## ✅ 安装状态

- **版本**: v5.47.0
- **状态**: ✅ 运行中
- **开机自启**: ✅ 已启用
- **端口**: 
  - SOCKS5: 10808
  - HTTP: 10809

## 📁 文件位置

| 类型 | 路径 |
|------|------|
| 可执行文件 | `/usr/local/bin/v2ray` |
| 配置文件 | `/usr/local/etc/v2ray/config.json` |
| 日志文件 | `/var/log/v2ray/` |
| 系统服务 | `/etc/systemd/system/v2ray.service` |
| 数据文件 | `/usr/local/share/v2ray/` |

## 🔧 常用命令

### 服务管理

```bash
# 启动 V2Ray
systemctl start v2ray

# 停止 V2Ray
systemctl stop v2ray

# 重启 V2Ray
systemctl restart v2ray

# 查看状态
systemctl status v2ray

# 开机自启
systemctl enable v2ray

# 取消自启
systemctl disable v2ray
```

### 日志查看

```bash
# 实时日志
journalctl -u v2ray -f

# 最近 100 行
journalctl -u v2ray -n 100

# 访问日志
tail -f /var/log/v2ray/access.log

# 错误日志
tail -f /var/log/v2ray/error.log
```

### 配置测试

```bash
# 测试配置文件
v2ray test -config /usr/local/etc/v2ray/config.json

# 查看版本
v2ray version
```

## 📝 当前配置

**入站协议**:
- SOCKS5: `0.0.0.0:10808`
- HTTP: `0.0.0.0:10809`

**出站协议**: Freedom（直连）

**路由规则**:
- 屏蔽私有 IP
- 屏蔽广告域名

## 🔐 安全建议

### 1. 防火墙配置

```bash
# 仅允许本地访问（推荐）
ufw deny 10808
ufw deny 10809

# 或仅允许特定 IP
ufw allow from 127.0.0.1 to any port 10808
ufw allow from 127.0.0.1 to any port 10809
```

### 2. 配置 VMess/VLESS（需要客户端连接）

编辑 `/usr/local/etc/v2ray/config.json`，添加入站配置：

```json
{
  "inbounds": [{
    "port": 443,
    "protocol": "vmess",
    "settings": {
      "clients": [{
        "id": "your-uuid-here",
        "alterId": 0
      }]
    },
    "streamSettings": {
      "network": "ws",
      "wsSettings": {
        "path": "/ray"
      }
    }
  }]
}
```

### 3. 使用 TLS 加密

建议配合 Nginx/Caddy 使用 TLS 加密。

## 🔄 更新 V2Ray

```bash
# 使用官方脚本更新
bash /tmp/install-v2ray.sh --update

# 或重新运行安装脚本
bash /tmp/install-v2ray.sh
```

## 📊 监控

### 查看连接数

```bash
# 查看当前连接
netstat -tunap | grep v2ray

# 或使用 ss
ss -tunap | grep v2ray
```

### 性能监控

```bash
# CPU 使用率
top -p $(pgrep v2ray)

# 内存使用
ps aux | grep v2ray
```

## ⚠️ 故障排除

### V2Ray 无法启动

```bash
# 检查配置文件
v2ray test -config /usr/local/etc/v2ray/config.json

# 查看详细错误
journalctl -u v2ray -n 50 --no-pager
```

### 端口被占用

```bash
# 查看端口占用
lsof -i :10808
lsof -i :10809

# 修改配置文件中的端口
nano /usr/local/etc/v2ray/config.json
```

### 日志过多

```bash
# 清理日志
> /var/log/v2ray/access.log
> /var/log/v2ray/error.log

# 或修改日志级别为 error
nano /usr/local/etc/v2ray/config.json
# "loglevel": "error"
```

## 📚 参考资料

- **官方文档**: https://www.v2fly.org/
- **GitHub**: https://github.com/v2fly/v2ray-core
- **配置示例**: https://www.v2fly.org/config/

---

**安装时间**: 2026-03-19 22:04  
**服务器**: Ubuntu 24.04.4 LTS  
**架构**: x86_64
