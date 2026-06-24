// 長按符號數據 - Row 數字鍵盤專用
{
  // ===== 第1行：數字長按全形 =====

  // ===== 第2行 =====
  // - 長按 – —（– 第一選中）
  hyphenRow: {
    selectedIndex: 0,
    list: [
      { action: { character: '–' }, label: { text: '–' } },
      { action: { character: '—' }, label: { text: '—' } },
    ],
  },
  // $ 長按 € £ ¥ ₩ ₽ ¢（¢ 第一選中）
  dollarRow: {
    selectedIndex: 5,
    list: [
      { action: { character: '€' }, label: { text: '€' } },
      { action: { character: '£' }, label: { text: '£' } },
      { action: { character: '¥' }, label: { text: '¥' } },
      { action: { character: '₩' }, label: { text: '₩' } },
      { action: { character: '₽' }, label: { text: '₽' } },
      { action: { character: '¢' }, label: { text: '¢' } },
    ],
  },
  // & 長按 §（＆ 已由上滑覆蓋，移除）
  ampersandRow: {
    selectedIndex: 0,
    list: [
      { action: { character: '§' }, label: { text: '§' } },
    ],
  },
  // / 長按 ÷（／ 已由上滑覆蓋）
  slashRow: {
    selectedIndex: 0,
    list: [
      { action: { character: '÷' }, label: { text: '÷' } },
    ],
  },
   rquoteRow: {
     selectedIndex: 1,
     list: [
       { action: { character: '®' }, label: { text: '®' } },
       { action: { character: '©' }, label: { text: '©' } },
     ],
   },

  // ===== 第3行 =====
  // * 長按 ×（＊ 已由上滑覆蓋）
  asteriskRow: {
    selectedIndex: 0,
    list: [
      { action: { character: '×' }, label: { text: '×' } },
    ],
  },
  // + 長按 ±（＋ 已由上滑覆蓋）
  plusRow: {
    selectedIndex: 0,
    list: [
      { action: { character: '±' }, label: { text: '±' } },
    ],
  },
  // ' 長按 ` ' ' '（直引號 ' 第一選中，exclamFullRow 鍵名重用）
  // ' 長按 ` ' '（移除 '，直引號 ' 第一選中）
  exclamFullRow: {
    selectedIndex: 2,
    list: [
      { action: { symbol: '`' }, label: { text: '`' } },
      { action: { character: '\u2019' }, label: { text: '\u2019' } },
      { action: { symbol: '\u0027' }, label: { text: '\u0027' } },
    ],
  },

  // ===== 第4行 =====
  // = 長按 計算 ≈ ≠（＝ 已由上滑覆蓋，移除；計算 第一選中）
  equalRow: {
    selectedIndex: 0,
    list: [
      { action: { sendKeys: 'Control+equal' }, label: { text: '計算' }, fontSize: 13 },
      { action: { character: '≈' }, label: { text: '≈' } },
      { action: { character: '≠' }, label: { text: '≠' } },
    ],
  },
  // " 長按 « » „ " " "（直引號 " 第一選中，dotRow 鍵名重用）
  // " 長按 « » „ " "（移除 "，直引號 " 第一選中）
  dotRow: {
    selectedIndex: 4,
    list: [
      { action: { character: '«' }, label: { text: '«' } },
      { action: { character: '»' }, label: { text: '»' } },
      { action: { character: '„' }, label: { text: '„' } },
      { action: { character: '\u201d' }, label: { text: '\u201d' } },
      { action: { character: '\u0022' }, label: { text: '\u0022' } },
    ],
  },
  ideographicCommaRow: {
    selectedIndex: 0,
    list: [
      { action: { character: '¿' }, label: { text: '¿' } },
    ],
  },
  questionFullRow: {
    selectedIndex: 0,
    list: [
      { action: { character: '¡' }, label: { text: '¡' } },
    ],
  },
}
