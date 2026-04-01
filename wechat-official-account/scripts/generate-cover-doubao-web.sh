#!/bin/bash
# 微信服务号 AI 新闻简报 - Doubao.com 封面图生成脚本
# 使用字节跳动豆包 (doubao.com) 图像生成功能

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT_DIR="$SCRIPT_DIR/../output/covers"
LOG_FILE="$SCRIPT_DIR/../logs/doubao-cover-generation.log"

# 颜色输出
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

log() {
    echo -e "[$(date '+%Y-%m-%d %H:%M:%S')] ${BLUE}[豆包封面]${NC} $1" | tee -a "$LOG_FILE"
}

success() {
    echo -e "[$(date '+%Y-%m-%d %H:%M:%S')] ${GREEN}[SUCCESS]${NC} $1" | tee -a "$LOG_FILE"
}

warn() {
    echo -e "[$(date '+%Y-%m-%d %H:%M:%S')] ${YELLOW}[WARN]${NC} $1" | tee -a "$LOG_FILE"
}

error() {
    echo -e "[$(date '+%Y-%m-%d %H:%M:%S')] ${RED}[ERROR]${NC} $1" | tee -a "$LOG_FILE"
}

# 生成封面图
generate_cover() {
    local title="$1"
    local output_file="$2"
    local period="$3"
    
    log "开始生成封面图..."
    log "标题：$title"
    log "输出：$output_file"
    log "时段：$period"
    log "平台：字节跳动豆包 (doubao.com)"
    
    # 检查是否安装了 agent-browser
    if ! command -v agent-browser &> /dev/null; then
        warn "agent-browser 未安装，使用占位封面"
        log "请安装：npm install -g agent-browser"
        echo "封面图占位 - 豆包 - 标题：$title - 时段：$period - 需安装 agent-browser" > "${output_file}.txt"
        return 1
    fi
    
    # 根据时段生成不同的 prompt
    local time_style=""
    case "$period" in
        "00")
            time_style="午夜蓝色和深紫色渐变，夜空与微妙星光，静谧专业氛围"
            ;;
        "06")
            time_style="日出色彩，温暖橙色和柔和粉色渐变，晨光熹微，希望感"
            ;;
        "12")
            time_style="明亮日光，清澈蓝天，专业商务光线，正午阳光"
            ;;
        "18")
            time_style="日落色彩，黄金时刻，温暖琥珀色和深蓝色渐变，黄昏美感"
            ;;
        *)
            time_style="专业蓝色和白色渐变，清洁现代风格"
            ;;
    esac
    
    # 豆包图像生成 prompt - 中文优化版
    local prompt="创建一张专业的 AI 技术新闻简报封面图，用于微信公众号文章。

【设计要求】
- 风格：现代极简主义科技新闻风格，清洁专业设计
- 构图：宽幅横幅格式，宽高比约 2.35:1（900x383 像素）
- 元素：抽象 AI 神经网络图案，微妙的电路板纹理，漂浮的数据粒子，科技感线条
- 光线：${time_style}，柔和专业摄影灯光
- 背景：清洁渐变背景，不要太复杂，留出文字叠加空间
- 配色：科技蓝 (#1E90FF) 为主色调，清洁白色，微妙灰色点缀
- 氛围：专业、可信赖、前沿、信息丰富
- 文字区域：中心或偏上位置留出清晰空间用于标题文字
- 避免：图像中不要有文字，不要有人物，不要复杂细节，不要暗色调

【技术规格】
- 分辨率：高质量，适合 900x383 像素输出
- 格式：PNG
- 质量：高分辨率，锐利，专业杂志封面风格

请生成符合上述要求的专业封面图。"

    log "生成 prompt..."
    log "使用平台：字节跳动豆包 (doubao.com)"
    
    # 生成时间戳文件名
    local timestamp=$(date '+%Y-%m-%d-%H-%M-%S')
    local temp_filename="cover-${timestamp}-doubao.png"
    local temp_path="${OUTPUT_DIR}/${temp_filename}"
    
    # 方法 1: 使用 agent-browser 访问 doubao.com
    log "尝试使用 agent-browser 访问 doubao.com..."
    
    # 打开豆包图像生成页面
    agent-browser open "https://www.doubao.com/chat/" 2>&1 | tee -a "$LOG_FILE"
    
    # 等待页面加载
    sleep 3
    
    # 检查页面是否加载成功
    local page_title=$(agent-browser snapshot 2>&1 | head -5 | grep -o "title.*" || echo "")
    
    if [ -n "$page_title" ]; then
        log "页面加载成功：$page_title"
        
        # 这里需要实现与豆包的交互逻辑
        # 由于豆包网页版需要登录和复杂的交互，建议使用 API 方式
        
        warn "豆包网页版需要登录和复杂交互，建议使用 API 方式"
        log "推荐使用：火山引擎 Doubao Seed API"
        
        # 创建占位文件
        echo "封面图占位 - 豆包网页版需要登录 - 请使用 API 方式" > "${output_file}.txt"
        agent-browser close 2>&1 >> "$LOG_FILE"
        return 1
    else
        warn "页面加载失败"
        echo "封面图占位 - 页面加载失败" > "${output_file}.txt"
        agent-browser close 2>&1 >> "$LOG_FILE"
        return 1
    fi
}

# 使用火山引擎 Doubao API（推荐方式）
generate_cover_api() {
    local title="$1"
    local output_file="$2"
    local period="$3"
    
    log "开始使用 Doubao API 生成封面图..."
    log "标题：$title"
    log "输出：$output_file"
    
    # 检查 API 凭证
    if [ -z "$DOUBAO_API_KEY" ] && [ -z "$VOLC_ACCESS_KEY" ]; then
        warn "DOUBAO_API_KEY 未设置"
        log "请设置环境变量:"
        log "  export DOUBAO_API_KEY='your_api_key'"
        log ""
        log "获取 API Key: https://console.volces.com/"
        
        echo "封面图占位 - 需配置 DOUBAO_API_KEY" > "${output_file}.txt"
        return 1
    fi
    
    # 根据时段生成 prompt
    local time_style=""
    case "$period" in
        "00") time_style="午夜蓝色和深紫色渐变，夜空与微妙星光" ;;
        "06") time_style="日出色彩，温暖橙色和柔和粉色渐变" ;;
        "12") time_style="明亮日光，清澈蓝天，专业商务光线" ;;
        "18") time_style="日落色彩，黄金时刻，温暖琥珀色和深蓝色渐变" ;;
        *) time_style="专业蓝色和白色渐变" ;;
    esac
    
    local prompt="专业的 AI 技术新闻简报封面图，现代极简主义科技风格，宽幅横幅 900x383 像素，抽象 AI 神经网络图案，电路板纹理，数据粒子，${time_style}，科技蓝主色调，专业杂志封面风格，无文字"
    
    log "调用 Doubao Seed API..."
    
    # Doubao API 调用（简化版）
    # 实际应调用火山引擎 API
    
    warn "Doubao API 需要火山引擎账号配置"
    echo "封面图占位 - 需配置火山引擎 API" > "${output_file}.txt"
    return 1
}

# 显示使用说明
show_usage() {
    echo "用法：generate-cover-doubao-web.sh <标题> <输出文件> <时段 (00|06|12|18)>"
    echo ""
    echo "说明:"
    echo "  此脚本尝试使用 doubao.com 网页版生成图像"
    echo "  由于网页版需要登录，建议使用 API 方式"
    echo ""
    echo "推荐方案:"
    echo "  1. 火山引擎 Doubao Seed API (generate-cover-doubao.sh)"
    echo "  2. 阿里云百炼 API (generate-cover-ali.sh)"
    echo ""
    echo "时段说明:"
    echo "  00 - 午夜场 (00:00)"
    echo "  06 - 晨间场 (06:00)"
    echo "  12 - 午间场 (12:00)"
    echo "  18 - 晚间场 (18:00)"
}

# 主函数
if [ $# -lt 3 ]; then
    show_usage
    exit 1
fi

# 创建输出目录
mkdir -p "$OUTPUT_DIR"
mkdir -p "$(dirname "$LOG_FILE")"

# 生成封面图
generate_cover "$1" "$2" "$3"
exit_code=$?

if [ $exit_code -eq 0 ]; then
    success "🎉 豆包封面图生成完成！"
    log "输出文件：$2"
else
    warn "⚠️ 封面图生成失败，已创建占位文件"
    log ""
    log "推荐使用其他方案:"
    log "  1. 火山引擎 Doubao Seed API: ./scripts/generate-cover-doubao.sh"
    log "  2. 阿里云百炼 API: ./scripts/generate-cover-ali.sh"
fi

exit $exit_code
