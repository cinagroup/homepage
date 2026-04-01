#!/bin/bash
# AI 封面图生成脚本
# 使用 nano-banana-pro 生成微信文章封面图

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT_DIR="$SCRIPT_DIR/../output/covers"

# 颜色输出
GREEN='\033[0;32m'
NC='\033[0m'

log() {
    echo -e "${GREEN}[封面生成]${NC} $1"
}

# 生成封面图
generate_cover() {
    local title="$1"
    local output_file="$2"
    
    log "开始生成封面图..."
    log "标题：$title"
    log "输出：$output_file"
    
    # 提取关键词生成 prompt
    local prompt="AI technology news background, futuristic minimalist design, clean professional layout, blue and white color scheme, digital abstract, 900x383"
    
    # 使用 nano-banana-pro 生成图像
    # 注意：实际使用时需要调用正确的 CLI 命令
    # 这里使用占位逻辑
    
    log "使用 AI 生成封面图..."
    log "Prompt: $prompt"
    
    # 模拟生成（实际应调用 nano-banana-pro CLI）
    # nano-banana-pro generate --prompt "$prompt" --size 900x383 --output "$output_file"
    
    # 创建占位文件
    echo "封面图占位 - 标题：$title" > "${output_file}.txt"
    
    log "封面图生成完成（占位）"
    log "实际使用时请调用：nano-banana-pro generate --prompt \"$prompt\" --size 900x383 --output \"$output_file\""
}

# 主函数
if [ $# -lt 2 ]; then
    echo "用法：generate-cover.sh <标题> <输出文件>"
    exit 1
fi

mkdir -p "$OUTPUT_DIR"
generate_cover "$1" "$2"
