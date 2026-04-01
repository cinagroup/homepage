#!/bin/bash
# 微信服务号 AI 新闻简报 - Doubao Seed 2.0 Pro 封面图生成脚本
# 使用火山引擎 Doubao Seed 2.0 Pro 生成专业封面图

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT_DIR="$SCRIPT_DIR/../output/covers"
LOG_FILE="$SCRIPT_DIR/../logs/cover-generation.log"

# 颜色输出
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

log() {
    echo -e "[$(date '+%Y-%m-%d %H:%M:%S')] ${BLUE}[Doubao 封面]${NC} $1" | tee -a "$LOG_FILE"
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
    
    # 检查 API 凭证
    if [ -z "$DOUBAO_API_KEY" ] && [ -z "$VOLC_ACCESS_KEY" ]; then
        warn "DOUBAO_API_KEY 或 VOLC_ACCESS_KEY 未设置"
        log "请设置环境变量:"
        log "  export DOUBAO_API_KEY='your_api_key'"
        log "  或 export VOLC_ACCESS_KEY='your_access_key'"
        log "  export VOLC_SECRET_KEY='your_secret_key'"
        
        # 创建占位文件
        echo "封面图占位 - 标题：$title - 时段：$period" > "${output_file}.txt"
        return 1
    fi
    
    # 根据时段生成不同的 prompt
    local time_style=""
    case "$period" in
        "00")
            time_style="午夜蓝色和深紫色渐变，夜空与微妙星光，静谧专业"
            ;;
        "06")
            time_style="日出色彩，温暖橙色和柔和粉色渐变，晨光熹微"
            ;;
        "12")
            time_style="明亮日光，清澈蓝天，专业商务光线"
            ;;
        "18")
            time_style="日落色彩，黄金时刻，温暖琥珀色和深蓝色渐变"
            ;;
        *)
            time_style="专业蓝色和白色渐变，清洁现代"
            ;;
    esac
    
    # Doubao Seed 2.0 Pro prompt - 知识风格封面图
    local prompt="创建一张专业的 AI 技术新闻简报封面图。
风格：现代极简主义科技新闻风格，清洁专业设计。
构图：宽幅横幅格式 900x383 像素，横向构图。
元素：抽象 AI 神经网络图案，微妙的电路板纹理，漂浮的数据粒子。
光线：${time_style}，柔和专业摄影灯光。
背景：清洁渐变背景，不要太复杂，留出文字叠加空间。
配色：科技蓝 (#1E90FF)，清洁白色，微妙灰色点缀。
氛围：专业、可信赖、前沿、信息丰富。
文字区域：中心留出清晰空间用于标题文字。
避免：图像中不要有文字，不要有人物，不要复杂细节，不要暗色调。
质量：高分辨率，锐利，专业杂志封面风格。"

    log "生成 prompt..."
    log "使用模型：Doubao Seed 2.0 Pro"
    
    # 生成时间戳文件名
    local timestamp=$(date '+%Y-%m-%d-%H-%M-%S')
    local temp_filename="cover-${timestamp}-temp.png"
    local temp_path="${OUTPUT_DIR}/${temp_filename}"
    
    # 调用 Doubao Seed API
    log "调用 Doubao Seed 2.0 Pro API..."
    
    # 方法 1: 使用 curl 直接调用火山引擎 API
    local api_url="https://ark.cn-beijing.volces.com/api/v3/images/generations"
    
    # 准备请求数据
    local request_data=$(cat <<EOF
{
    "model": "doubao-seed-2.0-pro",
    "prompt": "$prompt",
    "size": "900x383",
    "num_inferences": 1,
    "response_format": "url"
}
EOF
)
    
    # 发送 API 请求
    local response
    if [ -n "$DOUBAO_API_KEY" ]; then
        response=$(curl -s -X POST "$api_url" \
            -H "Content-Type: application/json" \
            -H "Authorization: Bearer $DOUBAO_API_KEY" \
            -d "$request_data")
    elif [ -n "$VOLC_ACCESS_KEY" ] && [ -n "$VOLC_SECRET_KEY" ]; then
        # 使用火山引擎签名
        warn "火山引擎签名模式需要额外配置，请使用 DOUBAO_API_KEY 方式"
        echo "封面图占位 - 需要配置 API 签名" > "${output_file}.txt"
        return 1
    else
        error "未找到有效的 API 凭证"
        return 1
    fi
    
    log "API 响应：$response"
    
    # 解析响应
    local image_url=$(echo "$response" | jq -r '.data[0].url // empty')
    local error_msg=$(echo "$response" | jq -r '.error.message // empty')
    
    if [ -n "$image_url" ] && [ "$image_url" != "null" ]; then
        log "下载生成的图片..."
        log "图片 URL: $image_url"
        
        # 下载图片
        curl -s -o "$temp_path" "$image_url"
        
        if [ -f "$temp_path" ] && [ -s "$temp_path" ]; then
            # 重命名为目标文件
            mv "$temp_path" "$output_file"
            success "封面图生成成功：$output_file"
            log "尺寸：900x383 px"
            log "格式：PNG"
            
            # 验证图片
            if command -v identify &> /dev/null; then
                local dimensions=$(identify -format "%wx%h" "$output_file" 2>/dev/null)
                log "实际尺寸：$dimensions"
            fi
            
            return 0
        else
            warn "图片下载失败或为空"
            echo "封面图占位 - 下载失败" > "${output_file}.txt"
            return 1
        fi
    else
        warn "API 返回错误：$error_msg"
        echo "封面图占位 - API 错误：$error_msg" > "${output_file}.txt"
        return 1
    fi
}

# 主函数
if [ $# -lt 3 ]; then
    echo "用法：generate-cover-doubao.sh <标题> <输出文件> <时段 (00|06|12|18)>"
    echo ""
    echo "环境变量:"
    echo "  DOUBAO_API_KEY        Doubao API Key (推荐)"
    echo "  VOLC_ACCESS_KEY       火山引擎 Access Key"
    echo "  VOLC_SECRET_KEY       火山引擎 Secret Key"
    exit 1
fi

# 创建输出目录
mkdir -p "$OUTPUT_DIR"
mkdir -p "$(dirname "$LOG_FILE")"

# 生成封面图
generate_cover "$1" "$2" "$3"
exit_code=$?

if [ $exit_code -eq 0 ]; then
    success "封面图生成完成！"
else
    warn "封面图生成失败，已创建占位文件"
fi

exit $exit_code
