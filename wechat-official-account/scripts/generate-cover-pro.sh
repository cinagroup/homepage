#!/bin/bash
# 微信服务号 AI 新闻简报 - 知识封面图生成脚本
# 使用 nano-banana-pro (Gemini 3 Pro Image) 生成专业封面

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT_DIR="$SCRIPT_DIR/../output/covers"
LOG_FILE="$SCRIPT_DIR/../logs/cover-generation.log"

# 颜色输出
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

log() {
    echo -e "[$(date '+%Y-%m-%d %H:%M:%S')] ${BLUE}[封面生成]${NC} $1" | tee -a "$LOG_FILE"
}

success() {
    echo -e "[$(date '+%Y-%m-%d %H:%M:%S')] ${GREEN}[SUCCESS]${NC} $1" | tee -a "$LOG_FILE"
}

warn() {
    echo -e "[$(date '+%Y-%m-%d %H:%M:%S')] ${YELLOW}[WARN]${NC} $1" | tee -a "$LOG_FILE"
}

# 生成封面图
generate_cover() {
    local title="$1"
    local output_file="$2"
    local period="$3"
    
    log "开始生成封面图..."
    log "标题：$title"
    log "输出：$output_file"
    
    # 根据时段生成不同的 prompt
    local time_style=""
    case "$period" in
        "00")
            time_style="midnight blue and deep purple gradient, night sky with subtle stars"
            ;;
        "06")
            time_style="sunrise colors, warm orange and soft pink gradient, morning light"
            ;;
        "12")
            time_style="bright daylight, clear blue sky, professional business lighting"
            ;;
        "18")
            time_style="sunset colors, golden hour, warm amber and deep blue gradient"
            ;;
        *)
            time_style="professional blue and white gradient, clean modern"
            ;;
    esac
    
    # 知识风格封面图 prompt
    local prompt="Create a professional knowledge cover image for AI technology news briefing. 
Style: Modern minimalist tech journalism, clean professional design.
Composition: Wide banner format 900x383 pixels, landscape orientation.
Elements: Abstract AI neural network patterns, subtle circuit board textures, floating data particles.
Lighting: Soft professional studio lighting, ${time_style}.
Background: Clean gradient background, not too busy, leave space for text overlay.
Color palette: Technology blue (#1E90FF), clean white, subtle gray accents.
Mood: Professional, trustworthy, cutting-edge, informative.
Text area: Leave clear space in center for headline text.
Avoid: No text in image, no people, no complex details, no dark colors.
Quality: High resolution, sharp, professional magazine cover style."

    log "生成 prompt..."
    
    # 检查 nano-banana-pro 是否可用
    if ! command -v uv &> /dev/null; then
        warn "uv 未安装，使用占位封面"
        echo "封面图占位 - 标题：$title" > "${output_file}.txt"
        return 1
    fi
    
    # 检查 GEMINI_API_KEY
    if [ -z "$GEMINI_API_KEY" ]; then
        warn "GEMINI_API_KEY 未设置，使用占位封面"
        log "请设置环境变量：export GEMINI_API_KEY=your_api_key"
        echo "封面图占位 - 标题：$title" > "${output_file}.txt"
        return 1
    fi
    
    log "调用 nano-banana-pro 生成封面图..."
    log "分辨率：1K (快速生成)"
    
    # 生成封面图
    local timestamp=$(date '+%Y-%m-%d-%H-%M-%S')
    local draft_filename="cover-${timestamp}-draft.png"
    local draft_path="${OUTPUT_DIR}/${draft_filename}"
    
    # 使用 nano-banana-pro 生成
    cd "$OUTPUT_DIR"
    
    uv run ~/.codex/skills/nano-banana-pro/scripts/generate_image.py \
        --prompt "$prompt" \
        --filename "$draft_filename" \
        --resolution 1K \
        2>&1 | tee -a "$LOG_FILE"
    
    if [ -f "$draft_path" ]; then
        # 重命名为目标文件
        mv "$draft_path" "$output_file"
        success "封面图生成成功：$output_file"
        log "尺寸：900x383 px"
        log "格式：PNG"
        return 0
    else
        warn "封面图生成失败，使用占位文件"
        echo "封面图占位 - 标题：$title" > "${output_file}.txt"
        return 1
    fi
}

# 生成带标题的封面图（高级版）
generate_cover_with_title() {
    local title="$1"
    local output_file="$2"
    local period="$3"
    
    log "生成带标题的封面图（需要两步）..."
    
    # 第一步：生成背景图
    local background_file="${output_file%.jpg}_bg.png"
    generate_cover "$title" "$background_file" "$period"
    
    if [ -f "$background_file" ]; then
        # 第二步：添加标题（使用 ImageMagick 或其他工具）
        log "添加标题到封面图..."
        
        if command -v convert &> /dev/null; then
            # 使用 ImageMagick 添加文字
            convert "$background_file" \
                -gravity center \
                -pointsize 48 \
                -font "Arial-Bold" \
                -fill "white" \
                -stroke "black" \
                -strokewidth 2 \
                -annotate 0 "$title" \
                "$output_file"
            
            success "标题添加完成：$output_file"
            rm -f "$background_file"
        else
            warn "ImageMagick 未安装，保留无文字版本"
            mv "$background_file" "$output_file"
        fi
    fi
}

# 主函数
if [ $# -lt 3 ]; then
    echo "用法：generate-cover-pro.sh <标题> <输出文件> <时段(00|06|12|18)>"
    exit 1
fi

mkdir -p "$OUTPUT_DIR"
mkdir -p "$(dirname "$LOG_FILE")"

generate_cover "$1" "$2" "$3"
