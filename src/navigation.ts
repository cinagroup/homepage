import { getPermalink, getBlogPermalink, getAsset } from './utils/permalinks';

export const headerData = {
  links: [
    {
      text: 'Products',
      links: [
        {
          text: 'CinaSeek — Intelligent Search',
          href: getPermalink('/cinaseek'),
        },
        {
          text: 'CinaClaw — AI Assistant',
          href: getPermalink('/cinaclaw'),
        },
        {
          text: 'CinaToken — AI API Gateway',
          href: getPermalink('/cinatoken'),
        },
        {
          text: 'CinaSkill — Skills Platform',
          href: getPermalink('/cinaskill'),
        },
        {
          text: 'CinaChain — Blockchain Network',
          href: getPermalink('/cinachain'),
        },
      ],
    },
    {
      text: 'Solutions',
      links: [
        {
          text: 'Enterprise',
          href: getPermalink('/#business'),
        },
        {
          text: 'Developers',
          href: getPermalink('/cinaskill'),
        },
        {
          text: 'Startups',
          href: getPermalink('/contact'),
        },
      ],
    },
    {
      text: 'Resources',
      links: [
        {
          text: 'Blog',
          href: getBlogPermalink(),
        },
        {
          text: 'Documentation',
          href: '#',
        },
        {
          text: 'API Reference',
          href: '#',
        },
      ],
    },
    {
      text: 'Company',
      links: [
        {
          text: 'About',
          href: getPermalink('/about'),
        },
        {
          text: 'Contact',
          href: getPermalink('/contact'),
        },
        {
          text: 'Careers',
          href: '#',
        },
      ],
    },
  ],
  actions: [
    { text: 'Get Started', href: '/contact', variant: 'primary' },
    { text: 'GitHub', href: 'https://github.com/cinagroup/homepage', target: '_blank' },
  ],
};

export const footerData = {
  links: [
    {
      title: 'Products',
      links: [
        { text: 'CinaSeek — Intelligent Search', href: '/cinaseek' },
        { text: 'CinaClaw — AI Assistant', href: '/cinaclaw' },
        { text: 'CinaToken — AI API Gateway', href: '/cinatoken' },
        { text: 'CinaSkill — Skills Platform', href: '/cinaskill' },
        { text: 'CinaChain — Blockchain Network', href: '/cinachain' },
      ],
    },
    {
      title: 'Produits',
      links: [
        { text: 'CinaSeek — Recherche Intelligente', href: '/fr/cinaseek' },
        { text: 'CinaClaw — Assistant IA', href: '/fr/cinaclaw' },
        { text: 'CinaToken — Passerelle API IA', href: '/fr/cinatoken' },
        { text: 'CinaSkill — Plateforme de Compétences', href: '/fr/cinaskill' },
        { text: 'CinaChain — Réseau Blockchain', href: '/fr/cinachain' },
      ],
    },
    {
      title: 'Productos',
      links: [
        { text: 'CinaSeek — Búsqueda Inteligente', href: '/es/cinaseek' },
        { text: 'CinaClaw — Asistente de IA', href: '/es/cinaclaw' },
        { text: 'CinaToken — Gateway API de IA', href: '/es/cinatoken' },
        { text: 'CinaSkill — Plataforma de Habilidades', href: '/es/cinaskill' },
        { text: 'CinaChain — Red Blockchain', href: '/es/cinachain' },
      ],
    },
    {
      title: 'Produkte',
      links: [
        { text: 'CinaSeek — Intelligente Suche', href: '/de/cinaseek' },
        { text: 'CinaClaw — KI-Assistent', href: '/de/cinaclaw' },
        { text: 'CinaToken — KI-API-Gateway', href: '/de/cinatoken' },
        { text: 'CinaSkill — Kompetenzplattform', href: '/de/cinaskill' },
        { text: 'CinaChain — Blockchain-Netzwerk', href: '/de/cinachain' },
      ],
    },
    {
      title: '製品',
      links: [
        { text: 'CinaSeek — インテリジェント検索', href: '/ja/cinaseek' },
        { text: 'CinaClaw — AI アシスタント', href: '/ja/cinaclaw' },
        { text: 'CinaToken — AI API ゲートウェイ', href: '/ja/cinatoken' },
        { text: 'CinaSkill — スキルプラットフォーム', href: '/ja/cinaskill' },
        { text: 'CinaChain — ブロックチェーンネットワーク', href: '/ja/cinachain' },
      ],
    },
    {
      title: '제품',
      links: [
        { text: 'CinaSeek — 지능형 검색', href: '/ko/cinaseek' },
        { text: 'CinaClaw — AI 어시스턴트', href: '/ko/cinaclaw' },
        { text: 'CinaToken — AI API 게이트웨이', href: '/ko/cinatoken' },
        { text: 'CinaSkill — 스킬 플랫폼', href: '/ko/cinaskill' },
        { text: 'CinaChain — 블록체인 네트워크', href: '/ko/cinachain' },
      ],
    },
    {
      title: 'Produtos',
      links: [
        { text: 'CinaSeek — Busca Inteligente', href: '/pt/cinaseek' },
        { text: 'CinaClaw — Assistente de IA', href: '/pt/cinaclaw' },
        { text: 'CinaToken — Gateway de API de IA', href: '/pt/cinatoken' },
        { text: 'CinaSkill — Plataforma de Habilidades', href: '/pt/cinaskill' },
        { text: 'CinaChain — Rede Blockchain', href: '/pt/cinachain' },
      ],
    },
    {
      title: 'Продукты',
      links: [
        { text: 'CinaSeek — Умный Поиск', href: '/ru/cinaseek' },
        { text: 'CinaClaw — AI Ассистент', href: '/ru/cinaclaw' },
        { text: 'CinaToken — AI API Шлюз', href: '/ru/cinatoken' },
        { text: 'CinaSkill — Платформа Навыков', href: '/ru/cinaskill' },
        { text: 'CinaChain — Блокчейн Сеть', href: '/ru/cinachain' },
      ],
    },
    {
      title: 'Developers',
      links: [
        { text: 'Documentation', href: '#' },
        { text: 'API Reference', href: '#' },
        { text: 'SDK & Tools', href: '#' },
        { text: 'Grants Program', href: '#' },
        { text: 'Developer Blog', href: '/blog' },
      ],
    },
    {
      title: 'Support',
      links: [
        { text: 'Help Center', href: '#' },
        { text: 'Community', href: '#' },
        { text: 'Contact Support', href: '/contact' },
        { text: 'System Status', href: '#' },
      ],
    },
    {
      title: 'Company',
      links: [
        { text: 'About Us', href: '/about' },
        { text: 'Blog', href: '/blog' },
        { text: 'Careers', href: '#' },
        { text: 'Press Kit', href: '#' },
        { text: 'Contact', href: '/contact' },
      ],
    },
  ],
  secondaryLinks: [
    { text: 'Terms of Service', href: getPermalink('/terms') },
    { text: 'Privacy Policy', href: getPermalink('/privacy') },
    { text: 'Cookie Policy', href: '#' },
  ],
  socialLinks: [
    { ariaLabel: 'GitHub', icon: 'tabler:brand-github', href: 'https://github.com/cinagroup' },
    { ariaLabel: 'X', icon: 'tabler:brand-x', href: 'https://x.com/cinagroup' },
    { ariaLabel: 'TikTok', icon: 'tabler:brand-tiktok', href: 'https://tiktok.com/@cinaseek' },
    { ariaLabel: 'Telegram', icon: 'tabler:brand-telegram', href: '#' },
    { ariaLabel: 'RSS', icon: 'tabler:rss', href: getAsset('/rss.xml') },
  ],
  footNote: `
    &copy; 2026 By CinaClaw@CinaSeek.AI All Rights Reserved.
  `,
};
