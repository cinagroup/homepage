#!/usr/bin/env node
/**
 * 微信服务号 AI 新闻简报翻译脚本
 * 将英文 AI 新闻简报翻译为中文
 */

const fs = require('fs');
const path = require('path');

// 简化的翻译映射表（实际应调用 AI 翻译 API）
const translations = {
  // 标题
  'AI News Briefing': 'AI 新闻简报',
  
  // 栏目
  'Top Stories': '核心新闻',
  'Trend Watch': '趋势观察',
  'What to Watch': '值得关注',
  
  // 元数据
  'Published': '发布时间',
  'Coverage': '覆盖时段',
  'Source': '来源',
  'Time': '时间',
  'Read more': '阅读全文',
  
  // 底部
  'Briefing generated:': '简报生成时间：',
  'Data sources:': '数据来源：',
  'Public news reports, AI-curated and summarized': '公开新闻报道，经 AI 筛选整理',
  
  // 领域
  'Security & Privacy': '安全与隐私',
  'Content Policy': '内容政策',
  'Big Tech Strategy': '大厂战略',
  'AI Partnerships': 'AI 合作',
  'AI Music': 'AI 音乐',
  'Legal & Policy': '法律与政策',
  'Product Development': '产品开发',
  'Corporate Strategy': '企业战略',
  'Legal & Regulation': '法律监管',
  'Policy & Legislation': '政策立法',
  'Chip Competition': '芯片竞争',
  'Social Impact': '社会影响',
  'Enterprise AI': '企业 AI',
  'Political AI': '政治 AI',
  'AI Safety': 'AI 安全',
  'Corporate Transformation': '企业转型',
  'Executive Turnover': '高管更替',
  'Financial Regulation': '金融监管',
  'Infrastructure': '基础设施',
  'Public Safety': '公共安全',
  'Startup Funding': '初创融资',
  
  // 热点话题
  'Anthropic data leak': 'Anthropic 数据泄露',
  'Epstein lawsuit vs Google': 'Epstein 诉 Google',
  'Wikipedia AI ban': 'Wikipedia AI 禁令',
  'content verification': '内容验证',
  'OpenAI Sora shutdown': 'OpenAI 关闭 Sora',
  'Meta layoffs': 'Meta 裁员',
  'Apple-Gemini distillation deal': 'Apple-Gemini 蒸馏合作',
  "industry 'don't ask don't tell'": "行业'不问不说'政策",
  'Epstein survivors lawsuit': 'Epstein 幸存者诉讼',
  'privacy concerns': '隐私担忧',
  'AI search assistant controversies': 'AI 搜索助手争议',
  'Former OpenAI researcher extinction warning': '前 OpenAI 研究员灭绝警告',
  'SaaS companies 5-year death prediction': 'SaaS 公司 5 年消亡预言',
  'Coca-Cola/Walmart CEOs resign over AI': '可口可乐/沃尔玛 CEO 因 AI 辞职',
  'U.S. Treasury AI Innovation Initiative': '美国财政部 AI 创新倡议',
  'AI power demand driving investment opportunities': 'AI 电力需求驱动投资机会',
  'EU AI food detection platform': '欧盟 AI 食品检测平台',
  "LeCun's company raises $1B+": 'LeCun 公司获 10 亿美元 + 融资',
};

function translateLine(line) {
  let translated = line;
  
  // 替换已知短语
  for (const [en, zh] of Object.entries(translations)) {
    const regex = new RegExp(escapeRegExp(en), 'g');
    translated = translated.replace(regex, zh);
  }
  
  return translated;
}

function escapeRegExp(string) {
  return string.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
}

function translateContent(inputFile, outputFile) {
  console.log(`[翻译] 开始处理：${inputFile}`);
  
  const content = fs.readFileSync(inputFile, 'utf8');
  const lines = content.split('\n');
  const translatedLines = [];
  
  for (const line of lines) {
    // 跳过 frontmatter 中的英文（保留 description 等）
    if (line.startsWith('---')) {
      translatedLines.push(line);
      continue;
    }
    
    // 翻译内容行
    const translated = translateLine(line);
    translatedLines.push(translated);
  }
  
  const output = translatedLines.join('\n');
  fs.writeFileSync(outputFile, output, 'utf8');
  console.log(`[翻译] 完成：${outputFile}`);
}

// 主函数
const args = process.argv.slice(2);
if (args.length < 2) {
  console.error('用法：translate-content.js <输入文件> <输出文件>');
  process.exit(1);
}

const [inputFile, outputFile] = args;
translateContent(inputFile, outputFile);
