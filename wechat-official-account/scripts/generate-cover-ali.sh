#!/bin/bash
# 微信服务号 AI 新闻简报 - 阿里云百炼封面图生成脚本
# 使用阿里云百炼平台通义万相模型生成专业封面图

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT_DIR="$SCRIPT_DIR/../output/covers"
LOG_FILE="$SCRIPT_DIR/../logs/ali-cover-generation.log"

# 颜色输出
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

log() {
    echo -e "[$(date '+%Y-%m-%d %H:%M:%S')] ${BLUE}[阿里云百炼封面]${NC} $1" | tee -a "$LOG_FILE"
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
    log "平台：阿里云百炼 (通义万相)"
    
    # 检查 API 凭证
    if [ -z "$ALI_API_KEY" ]; then
        warn "ALI_API_KEY 未设置"
        log "请设置环境变量:"
        log "  export ALI_API_KEY='sk-sp-xxx'"
        log ""
        log "获取 API Key: https://bailian.console.aliyun.com/"
        
        # 创建占位文件
        echo "封面图占位 - 阿里云百炼 - 标题：$title - 时段：$period - 需配置 ALI_API_KEY" > "${output_file}.txt"
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
    
    # 阿里云百炼通义万相 prompt - 中文优化版
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
    log "使用平台：阿里云百炼 (通义万相)"
    
    # 生成时间戳文件名
    local timestamp=$(date '+%Y-%m-%d-%H-%M-%S')
    local temp_filename="cover-${timestamp}-ali.png"
    local temp_path="${OUTPUT_DIR}/${temp_filename}"
    
    # 调用阿里云百炼 API
    log "调用阿里云百炼 API..."
    
    # 阿里云百炼 API 端点（通义万相图像生成）
    local api_url="https://dashscope.aliyuncs.com/api/v1/services/aigc/text-to-image/generation"
    
    # 准备请求数据（阿里云百炼格式）
    local request_data=$(cat <<EOF
{
    "model": "wanx-v1",
    "input": {
        "prompt": "$prompt",
        "size": "900x383",
        "n": 1,
        "style": "<auto>"
    },
    "parameters": {
        "style": "<auto>",
        "resolution": "900x383"
    }
}
EOF
)
    
    log "API URL: $api_url"
    
    # 发送 API 请求
    local response
    response=$(curl -s -X POST "$api_url" \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer $ALI_API_KEY" \
        -H "X-DashScope-Async: enable" \
        -d "$request_data")
    
    log "API 响应：$response"
    
    # 解析响应
    local task_id=$(echo "$response" | jq -r '.output.task_id // empty')
    local error_msg=$(echo "$response" | jq -r '.message // empty')
    local error_code=$(echo "$response" | jq -r '.code // empty')
    
    if [ -n "$task_id" ] && [ "$task_id" != "null" ] && [ "$task_id" != "" ]; then
        log "✅ 任务提交成功"
        log "任务 ID: $task_id"
        log "等待生成完成..."
        
        # 轮询任务状态
        local max_attempts=30
        local attempt=0
        local status="PENDING"
        local image_url=""
        
        while [ $attempt -lt $max_attempts ]; do
            sleep 3
            
            # 查询任务状态
            local status_url="https://dashscope.aliyuncs.com/api/v1/tasks/$task_id"
            local status_response=$(curl -s -X GET "$status_url" \
                -H "Authorization: Bearer $ALI_API_KEY")
            
            log "轮询 ${attempt}: $status_response"
            
            status=$(echo "$status_response" | jq -r '.output.task_status // "UNKNOWN"')
            
            case "$status" in
                "SUCCEEDED"|"SUCCESS")
                    log "✅ 生成成功"
                    image_url=$(echo "$status_response" | jq -r '.output.results[0].url // empty')
                    break
                    ;;
                "FAILED"|"FAILURE")
                    error_msg=$(echo "$status_response" | jq -r '.output.message // "未知错误"')
                    log "❌ 生成失败：$error_msg"
                    break
                    ;;
                "PENDING"|"RUNNING")
                    log "⏳ 生成中... (${attempt}/${max_attempts})"
                    ;;
                *)
                    log "⚠️ 未知状态：$status"
                    ;;
            esac
            
            attempt=$((attempt + 1))
        done
        
        if [ -n "$image_url" ] && [ "$image_url" != "null" ] && [ "$image_url" != "" ]; then
            log "图片 URL: $image_url"
            log "下载生成的图片..."
            
            # 下载图片
            if curl -s -o "$temp_path" "$image_url"; then
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
                    
                    if command -v file &> /dev/null; then
                        local file_type=$(file -b "$output_file")
                        log "文件类型：$file_type"
                    fi
                    
                    return 0
                else
                    warn "图片下载失败或为空文件"
                    echo "封面图占位 - 下载失败" > "${output_file}.txt"
                    return 1
                fi
            else
                warn "curl 下载失败"
                echo "封面图占位 - 网络错误" > "${output_file}.txt"
                return 1
            fi
        else
            warn "❌ 未获取到图片 URL"
            log "错误信息：$error_msg"
            echo "封面图占位 - API 错误：$error_msg" > "${output_file}.txt"
            return 1
        fi
    else
        warn "❌ API 返回错误"
        log "错误代码：$error_code"
        log "错误信息：$error_msg"
        echo "封面图占位 - API 错误：$error_msg" > "${output_file}.txt"
        return 1
    fi
}

# 显示使用说明
show_usage() {
    echo "用法：generate-cover-ali.sh <标题> <输出文件> <时段 (00|06|12|18)>"
    echo ""
    echo "环境变量:"
    echo "  ALI_API_KEY    阿里云百炼 API Key (从 https://bailian.console.aliyun.com/ 获取)"
    echo ""
    echo "示例:"
    echo "  export ALI_API_KEY='sk-sp-xxxxxxxxx'"
    echo "  ./scripts/generate-cover-ali.sh 'AI News' 'cover.png' '12'"
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
    success "🎉 阿里云百炼封面图生成完成！"
    log "输出文件：$2"
else
    warn "⚠️ 封面图生成失败，已创建占位文件"
fi

exit $exit_code
