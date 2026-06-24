// 長按符號數據 - Row 符號鍵盤專用
{
  // ===== 第1行 =====
  // [ 長按 【（［ 已由上滑覆蓋，移除）
  lbracketRow: {
    selectedIndex: 0,
    list: [
      { action: { character: '【' }, label: { text: '【' } },
    ],
  },
  // ] 長按 】（］ 已由上滑覆蓋，移除）
  rbracketRow: {
    selectedIndex: 0,
    list: [
      { action: { character: '】' }, label: { text: '】' } },
    ],
  },
  // % 長按 ‰（％ 已由上滑覆蓋，移除）
  percentRow: {
    selectedIndex: 0,
    list: [
      { action: { character: '‰' }, label: { text: '‰' } },
    ],
  },
  // ⋯ 長按 … ‥（… 第一選中，asteriskSRow 鍵名重用）
  asteriskSRow: {
    selectedIndex: 0,
    list: [
      { action: { character: '…' }, label: { text: '…' } },
      { action: { character: '‥' }, label: { text: '‥' } },
    ],
  },

  // ===== 第2行 =====
  // · 長按 ° •（．已由上滑覆蓋，移除；• 第一選中）
  middleDotRow: {
    selectedIndex: 1,
    list: [
      { action: { character: '°' }, label: { text: '°' } },
      { action: { character: '•' }, label: { text: '•' } },
    ],
  },

  // ===== 第3行（ellipsis/commaS/periodS/questionS/exclamS/lsquote/rsquote 鍵名重用）=====
  // 「」 無長按（ellipsisRow / commaSRow 移除）
  // . 上滑 。，無長按（periodSRow 移除）
  // , 上滑 ，，無長按（questionSRow 移除）
  // ? 長按 ¿（exclamSRow 重新加入）
  exclamSRow: {
    selectedIndex: 0,
    list: [
      { action: { character: '¿' }, label: { text: '¿' } },
    ],
  },
  // ! 長按 ¡（lsquoteRow 重新加入）
  lsquoteRow: {
    selectedIndex: 0,
    list: [
      { action: { character: '¡' }, label: { text: '¡' } },
    ],
  },
  // ' 長按 ` ' ' '（直引號 ' 第一選中，rsquoteRow 鍵名重用）
  // ' 長按 ` ' '（移除 '，直引號 ' 第一選中）
  rsquoteRow: {
    selectedIndex: 2,
    list: [
      { action: { symbol: '`' }, label: { text: '`' } },
      { action: { character: '\u2019' }, label: { text: '\u2019' } },
      { action: { symbol: '\u0027' }, label: { text: '\u0027' } },
    ],
  },

  // ===== 第4行 =====
  // " 長按 « » „ " " "（直引號 " 第一選中，dquoteSRow 新鍵）
  // " 長按 « » „ " "（移除 "，直引號 " 第一選中）
  dquoteSRow: {
    selectedIndex: 4,
    list: [
      { action: { character: '«' }, label: { text: '«' } },
      { action: { character: '»' }, label: { text: '»' } },
      { action: { character: '„' }, label: { text: '„' } },
      { action: { character: '\u201d' }, label: { text: '\u201d' } },
      { action: { character: '\u0022' }, label: { text: '\u0022' } },
    ],
  },
}
