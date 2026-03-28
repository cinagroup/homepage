export const languages = {
  en: 'English',
  zh: '中文',
} as const;

export const defaultLang: keyof typeof languages = 'en';

export const ui = {
  en: {
    'nav.language': 'Language',
    'nav.blog': 'Blog',
    'nav.products': 'Products',
    'nav.solutions': 'Solutions',
    'nav.resources': 'Resources',
    'nav.company': 'Company',
  },
  zh: {
    'nav.language': '语言',
    'nav.blog': '博客',
    'nav.products': '产品',
    'nav.solutions': '解决方案',
    'nav.resources': '资源',
    'nav.company': '公司',
  },
} as const;

export function useTranslations(lang: keyof typeof ui) {
  return function t(key: keyof typeof ui[typeof lang]) {
    return ui[lang][key] || ui.en[key];
  };
}

export function getLangFromUrl(url: URL) {
  const [, lang] = url.pathname.split('/');
  if (lang in languages) return lang as keyof typeof languages;
  return defaultLang;
}

export function changeLangPath(url: URL, newLang: keyof typeof languages) {
  const parts = url.pathname.split('/');
  if (parts[1] in languages) {
    parts[1] = newLang;
  } else {
    parts.splice(1, 0, newLang);
  }
  return parts.join('/').replace(/\/+/g, '/');
}
