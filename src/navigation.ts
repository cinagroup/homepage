import { getPermalink, getBlogPermalink, getAsset } from './utils/permalinks';

export const headerData = {
  links: [
    {
      text: 'Products',
      links: [
        {
          text: 'CinaSeek — 智能搜索',
          href: getPermalink('/cinaseek'),
        },
        {
          text: 'CinaClaw — 智能机器人',
          href: getPermalink('/cinaclaw'),
        },
        {
          text: 'CinaSkill — 技能平台',
          href: getPermalink('/cinaskill'),
        },
        {
          text: 'CinaChain — 区块链',
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
        { text: 'CinaSeek — 智能搜索', href: '/cinaseek' },
        { text: 'CinaClaw — 智能机器人', href: '/cinaclaw' },
        { text: 'CinaSkill — 技能平台', href: '/cinaskill' },
        { text: 'CinaChain — 区块链', href: '/cinachain' },
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
    { ariaLabel: 'Twitter', icon: 'tabler:brand-x', href: 'https://twitter.com/cinagroup' },
    { ariaLabel: 'Discord', icon: 'tabler:brand-discord', href: '#' },
    { ariaLabel: 'Telegram', icon: 'tabler:brand-telegram', href: '#' },
    { ariaLabel: 'RSS', icon: 'tabler:rss', href: getAsset('/rss.xml') },
  ],
  footNote: `
    &copy; 2026 CinaGroup. All Rights Reserved. <br/>
    <span class="text-sm text-gray-500">Building the Future of AI & Web3</span>
  `,
};
