// ======================================
// 蝦米輸入法皮膚自訂設定檔
// 修改完成後，回到皮膚界面長按皮膚選擇「編譯」生效
// ======================================
{
  // ===== 鍵盤佈局設定 =====
  
  // 鍵盤佈局選擇（數字鍵盤與符號鍵盤同步切換）
  // 'panel': 九宮格數字鍵盤 + 面板符號鍵盤（預設）
  // 'row'  : Row 數字鍵盤 + Row 符號鍵盤
  keyboardLayout: 'row',
  
  // 鍵盤語言切換佈局
  // 控制 Shift 鍵與符號鍵的語言切換功能
  // '1': 預設模式
  // '2': 快捷切換模式（中文鍵盤 Shift 變「英」）
  languageSwitchLayout: '1',

  // 英文鍵盤模式
  // '1': 純英文鍵盤（alphabetic_26，直接輸出字元，不走 Rime）
  // '2': 詞庫英文鍵盤（alphabetic_easy，走 easy_en 方案，支援候選補全）
  englishKeyboardMode: '1',

  // 字母鍵長按選單排序
  // '2': 預設排序（大寫在首位）
  // '1': 替代排序（小寫在首位）
  longPressLayout: '2',

  // 空白鍵佈局切換
  // 控制第四排按鈕尺寸配置
  // '1': 空白鍵最小（逗號句號較大）
  // '2': 空白鍵適中
  // '3': 空白鍵最大
  spaceKeyLayout: '2',
  
  // 慣用手設定
  // 控制 z 鍵上滑及長按選項中的單手模式切換方向
  // 'left': 慣用左手（預設）
  // 'right': 慣用右手
  // 注意：橫屏模式下會自動隱藏單手模式選項，不受此設定影響
  handedness: 'left',

  // 內嵌模式設定
  // 控制符號/Emoji/Kaomoji 鍵盤的整體高度
  // '1': 開啟內嵌（字根組合顯示在 preedit 區，符號等鍵盤高度較小）
  // '2': 關閉內嵌（字根組合顯示在候選區，符號等鍵盤高度較大，與 26 鍵總高度對齊）
  preeditMode: '1',

  // ===== 工具列按鈕配置 =====
  
  // 按鈕編號對應表：
  // 【常用功能 0-9】
  // 0: 空白佔位符        1: 元書設定面板      2: 收折按鈕
  // 3: 中英切換          4: 簡繁切換          5: 常用語面版
  // 6: 剪貼本面版        7: 符號鍵盤          8: Emoji鍵盤        9: 數字鍵盤
  // 26: Kaomojis鍵盤    27: 注音鍵盤(ㄅ)     28: 拼音鍵盤(拼)    29: 九宮格數字鍵盤    30: 符號面板
  // 31: 皮膚設計器捷徑（設）
  // 【編輯功能 10-19】
  // 10: 全選             11: 複製             12: 剪下            13: 貼上
  // 14: 復原             15: 重做             16: 游標左移        17: 游標右移
  // 18: 左手模式         19: 右手模式
  // 【其他設定 20-25】
  // 20: 效能監控         21: Rime部署         22: 腳本面版        23: 文件管理捷徑
  // 24: 皮膚設定捷徑     25: 皮膚微調捷徑
  // 
  // 完全自訂10個按鈕位置（包含面板和收折）
  // 預設配置：[面板] [空 空 中英 簡繁 常用語 剪貼 符號 emoji] [收折]
  toolbarButtons: [1, 0, 0, 3, 4, 5, 6, 7, 8, 2],
  
  // ===== 滑動與長按功能設定 =====
  
  // 【全域主開關】 (Master Switches)
  // 優先級最高：保留名稱代表「全域開啟」該功能。
  // 若想「全域關閉」某項功能，只需在該行加上「//」將其註解掉即可。
  globalEnabledFeatures: [
    'swipeUp',          // 控制上滑動作
    'swipeDown',        // 控制下滑動作
    'longPress',        // 控制長按動作
    'showSwipeUpText',  // 顯示上滑提示文字
    'showSwipeDownText',// 顯示下滑提示文字
  ],

  // 【分排細部開關】 (僅在上方全域開啟時生效)
  // 想要在哪幾排開啟功能，就保留該排名稱；加上「//」註解掉即代表關閉。
  advancedRowControl: {
    swipeUpRows: [
      'row1',  // 第一排 Q~P
      'row2',  // 第二排 A~L
      'row3',  // 第三排 Z~M
      'row4',  // 逗號、句號（上滑直接上屏 , .）
      'space', // 空白鍵上滑切換擴充字集
      'enter', // Enter 鍵上滑（跳轉注音）
      'nineKey', // 九宮格數字鍵盤
    ],
    swipeDownRows: [
      'row1',
      'row2',
      'row3',
      'row4', // 逗號、句號
      'enter', // Enter 鍵下滑（換行 LF）
    ],
    longPressRows: [
      'row1',
      'row2',
      'row3',
      'row4',  // 逗號、句號（預設開啟長按多功能選單）
    ],
    showSwipeUpTextRows: [
      'row1',
      'row2',
      'row3',
      'nineKey', // 九宮格數字鍵盤
    ],
    showSwipeDownTextRows: [
      'row1',
      'row2',
      'row3',
    ],
  },

  // ===== 核心視覺架構 (3-Layer System) =====
  // 這裡提供強大的皮膚自定義能力，分為三個層級。
  
  // ======================================================
  // 🎨 前端參數寫入區 (由 UI 面板控制)
  // ⚠️ 修改顏色或字號後，須同時將下方 enableCustomColors 設為 true 方可生效
  // ======================================================

  // ── 【全域：按鍵配色】 ──
  // 這些是「全域共通」的值，所有未被單獨調整的鍵盤都會預設繼承這組設定
  
  // ☀️ 淺色模式
  local light_bg                = '#D0D3DA01',
  local light_keyNormal         = '#FFFFFF',
  local light_keyNormalHL       = '#ABB0BA',
  local light_keySystem         = '#979faf80',
  local light_keySystemHL       = '#FFFFFFE6',
  local light_keyEnter          = '#979faf80',
  local light_keyEnterHL        = '#FFFFFFE6',
  local light_textMain          = '#000000',
  local light_textSub           = '#00000055',
  local light_textSystem        = light_textMain,
  local light_textEnter         = light_textMain,
  // 按鍵陰影／邊框（一般字母鍵）
  local light_shadow            = '#9a9c9a',
  local light_shadowHL          = light_shadow,
  local light_border            = '#FFFFFF',
  local light_borderSize        = 0,
  // 系統功能鍵陰影／邊框（預設繼承一般按鍵；如需單獨調整請改為具體色碼）
  local light_systemBorder      = light_border,
  local light_systemShadow      = light_shadow,
  local light_systemShadowHL    = light_shadowHL,
  local light_system_borderSize = light_borderSize,
  // Enter 鍵陰影／邊框（預設繼承一般按鍵；如需單獨調整請改為具體色碼）
  local light_enterBorder       = light_border,
  local light_enterShadow       = light_shadow,
  local light_enterShadowHL     = light_shadowHL,
  local light_enter_borderSize  = light_borderSize,

  // 🌙 深色模式
  local dark_bg                 = '#47474701',
  local dark_keyNormal          = '#D1D1D165',
  local dark_keyNormalHL        = '#D1D1D624',
  local dark_keySystem          = '#D1D1D624',
  local dark_keySystemHL        = '#D1D1D659',
  local dark_keyEnter           = '#D1D1D624',
  local dark_keyEnterHL         = '#D1D1D659',
  local dark_textMain           = '#FFFFFF',
  local dark_textSub            = '#FFFFFF55',
  local dark_textSystem         = dark_textMain,
  local dark_textEnter          = dark_textMain,
  // 按鍵陰影／邊框（一般字母鍵）
  local dark_shadow             = '#1E1E1E',
  local dark_shadowHL           = dark_shadow,
  local dark_border             = '#D1D1D165',
  local dark_borderSize         = 0,
  // 系統功能鍵陰影／邊框（預設繼承一般按鍵）
  local dark_systemBorder       = dark_border,
  local dark_systemShadow       = dark_shadow,
  local dark_systemShadowHL     = dark_shadowHL,
  local dark_system_borderSize  = dark_borderSize,
  // Enter 鍵陰影／邊框（預設繼承一般按鍵）
  local dark_enterBorder        = dark_border,
  local dark_enterShadow        = dark_shadow,
  local dark_enterShadowHL      = dark_shadowHL,
  local dark_enter_borderSize   = dark_borderSize,

  // 📏 字體大小（共通）
  local size_alphabet           = 21,
  local size_lowercase          = 23,
  local size_system             = 16,
  local size_swipe              = 10,
  local size_toolbar            = 20,
  local size_space              = 14,
  local size_enter              = 16,


  // ── 【細部：其他細節】 ──
  // 這些是特定模塊或非共通屬性的值
  
  // 候選字列 (共通)
  local light_candidateSelectedText   = light_textMain,
  local light_candidateUnselectedText = light_textMain,
  local light_candidateSelectedBg     = light_keyNormal,
  local dark_candidateSelectedText    = dark_textMain,
  local dark_candidateUnselectedText  = dark_textMain,
  local dark_candidateSelectedBg      = dark_keyNormal,

  // 點擊與長按氣泡 (共通)
  local light_bubbleSelected    = '#FFFFFF',
  local light_bubbleUnselected  = '#000000',
  local dark_bubbleSelected     = '#FFFFFF',
  local dark_bubbleUnselected   = '#FFFFFF',

  // 工具列背景與圖示
  local light_toolbarBg           = light_bg,
  local light_toolbarColor      = '#666666',
  local dark_toolbarBg            = dark_bg,
  local dark_toolbarColor       = '#CCCCCC',

  // 空白鍵專屬 (中、英、注音、row數字、row符號)
  // 預設繼承一般按鍵；如需單獨調整請改為具體色碼
  local light_keySpace          = light_keyNormal,
  local light_keySpaceHL        = light_keyNormalHL,
  local light_spaceBorder       = light_border,
  local light_spaceShadow       = light_shadow,
  local light_spaceShadowHL     = light_shadowHL,
  local light_textSpace         = light_textMain,
  local light_space_borderSize  = light_borderSize,
  local dark_keySpace           = dark_keyNormal,
  local dark_keySpaceHL         = dark_keyNormalHL,
  local dark_spaceBorder        = dark_border,
  local dark_spaceShadow        = dark_shadow,
  local dark_spaceShadowHL      = dark_shadowHL,
  local dark_textSpace          = dark_textMain,
  local dark_space_borderSize   = dark_borderSize,

  // 面板類鍵盤專屬 (符號/Emoji/Kaomojis)
  local light_panelLeftBg       = '#979faf80',
  local light_panelRightBg      = '#FFFFFF',
  local light_panelLeftText     = light_textMain,
  local light_panelRightText    = light_textMain,
  local light_panelLeftShadow       = light_shadow,
  local light_panelLeftBorder       = light_border,
  local light_panelLeftBorderSize   = light_borderSize,
  local light_panelRightShadow      = light_shadow,
  local light_panelRightBorder      = light_border,
  local light_panelRightBorderSize  = light_borderSize,
  local light_panelCategoryHL       = light_keyNormalHL,
  local dark_panelLeftBg        = '#D1D1D624',
  local dark_panelRightBg       = '#D1D1D165',
  local dark_panelLeftText      = dark_textMain,
  local dark_panelRightText     = dark_textMain,
  local dark_panelLeftShadow        = dark_shadow,
  local dark_panelLeftBorder        = dark_border,
  local dark_panelLeftBorderSize    = dark_borderSize,
  local dark_panelRightShadow       = dark_shadow,
  local dark_panelRightBorder       = dark_border,
  local dark_panelRightBorderSize   = dark_borderSize,
  local dark_panelCategoryHL        = dark_keyNormalHL,
  local size_panelSmall              = 18,
  local size_panelLarge_symbol       = 26,
  local size_panelLarge_emoji        = 30,
  local size_panelLarge_kaomoji      = 20,

  // 數字鍵盤專屬 (九宮格/面板數字)
  local light_numericLeftBg     = '#979faf80',
  local light_numericLeftShadow = light_shadow,
  local light_numericLeftBorder = light_border,
  local light_numericLeftBorderSize = light_borderSize,
  local dark_numericLeftBg      = '#D1D1D624',
  local dark_numericLeftShadow  = dark_shadow,
  local dark_numericLeftBorder  = dark_border,
  local dark_numericLeftBorderSize = dark_borderSize,
  local size_number             = 24,


  // ======================================================
  // ⚙️ 底層架構區 (引擎自動讀取上方變數，不需手動修改)
  // ======================================================
  customColors: {
    // 啟用自訂配色（false = 使用系統預設主題）
    enableCustomColors: false,

    // 【第一層：調色盤 Palette】
    palette: {
      light: {
        bg: light_bg,
        keyNormal: light_keyNormal,
        keySpace: light_keySpace,
        keySpaceHighlight: light_keySpaceHL,
        spaceBorder: light_spaceBorder,
        spaceShadow: light_spaceShadow,
        spaceShadowHighlight: light_spaceShadowHL,
        spaceBorderSize: light_space_borderSize,
        keyNormalHighlight: light_keyNormalHL,
        keySystem: light_keySystem,
        keySystemHighlight: light_keySystemHL,
        keyEnter: light_keyEnter,
        keyEnterHighlight: light_keyEnterHL,
        panelLeftBg: light_panelLeftBg,
        panelRightBg: light_panelRightBg,
        panelLeftText: light_panelLeftText,
        panelRightText: light_panelRightText,
        panelLeftShadow: light_panelLeftShadow,
        panelLeftBorder: light_panelLeftBorder,
        panelLeftBorderSize: light_panelLeftBorderSize,
        panelRightShadow: light_panelRightShadow,
        panelRightBorder: light_panelRightBorder,
        panelRightBorderSize: light_panelRightBorderSize,
        panelCategoryHighlight: light_panelCategoryHL,
        numericLeftPanelBg: light_numericLeftBg,
        numericLeftPanelShadow: light_numericLeftShadow,
        numericLeftPanelBorder: light_numericLeftBorder,
        numericLeftPanelBorderSize: light_numericLeftBorderSize,
        textMain: light_textMain,
        textSub: light_textSub,
        textSystem: light_textSystem,
        textEnter: light_textEnter,
        textSpace: light_textSpace,
        toolbarColor: light_toolbarColor,
        toolbarBg: light_toolbarBg,
        candidateSelectedText: light_candidateSelectedText,
        candidateUnselectedText: light_candidateUnselectedText,
        candidateSelectedBg: light_candidateSelectedBg,
        bubbleTextSelected: light_bubbleSelected,
        bubbleTextUnselected: light_bubbleUnselected,
        shadow: light_shadow,
        shadowHighlight: light_shadowHL,
        border: light_border,
        borderSize: light_borderSize,
        systemBorder: light_systemBorder,
        systemShadow: light_systemShadow,
        systemShadowHighlight: light_systemShadowHL,
        systemBorderSize: light_system_borderSize,
        enterBorder: light_enterBorder,
        enterShadow: light_enterShadow,
        enterShadowHighlight: light_enterShadowHL,
        enterBorderSize: light_enter_borderSize,
      },
      dark: {
        bg: dark_bg,
        keyNormal: dark_keyNormal,
        keySpace: dark_keySpace,
        keySpaceHighlight: dark_keySpaceHL,
        spaceBorder: dark_spaceBorder,
        spaceShadow: dark_spaceShadow,
        spaceShadowHighlight: dark_spaceShadowHL,
        spaceBorderSize: dark_space_borderSize,
        keyNormalHighlight: dark_keyNormalHL,
        keySystem: dark_keySystem,
        keySystemHighlight: dark_keySystemHL,
        keyEnter: dark_keyEnter,
        keyEnterHighlight: dark_keyEnterHL,
        panelLeftBg: dark_panelLeftBg,
        panelRightBg: dark_panelRightBg,
        panelLeftText: dark_panelLeftText,
        panelRightText: dark_panelRightText,
        panelLeftShadow: dark_panelLeftShadow,
        panelLeftBorder: dark_panelLeftBorder,
        panelLeftBorderSize: dark_panelLeftBorderSize,
        panelRightShadow: dark_panelRightShadow,
        panelRightBorder: dark_panelRightBorder,
        panelRightBorderSize: dark_panelRightBorderSize,
        panelCategoryHighlight: dark_panelCategoryHL,
        numericLeftPanelBg: dark_numericLeftBg,
        numericLeftPanelShadow: dark_numericLeftShadow,
        numericLeftPanelBorder: dark_numericLeftBorder,
        numericLeftPanelBorderSize: dark_numericLeftBorderSize,
        textMain: dark_textMain,
        textSub: dark_textSub,
        textSystem: dark_textSystem,
        textEnter: dark_textEnter,
        textSpace: dark_textSpace,
        toolbarColor: dark_toolbarColor,
        toolbarBg: dark_toolbarBg,
        candidateSelectedText: dark_candidateSelectedText,
        candidateUnselectedText: dark_candidateUnselectedText,
        candidateSelectedBg: dark_candidateSelectedBg,
        bubbleTextSelected: dark_bubbleSelected,
        bubbleTextUnselected: dark_bubbleUnselected,
        shadow: dark_shadow,
        shadowHighlight: dark_shadowHL,
        border: dark_border,
        borderSize: dark_borderSize,
        systemBorder: dark_systemBorder,
        systemShadow: dark_systemShadow,
        systemShadowHighlight: dark_systemShadowHL,
        systemBorderSize: dark_system_borderSize,
        enterBorder: dark_enterBorder,
        enterShadow: dark_enterShadow,
        enterShadowHighlight: dark_enterShadowHL,
        enterBorderSize: dark_enter_borderSize,
      }
    },

    // 【第二層：尺寸範本 Groups】
    groups: {
      alphabetSize: size_alphabet,
      lowercaseSize: size_lowercase,
      systemSize: size_system,
      spaceSize: size_space,
      enterSize: size_enter,
      numberSize: size_number,
      rowKeySize: size_alphabet,
      panelSmallSize: size_panelSmall,
      panelLargeSymbolSize: size_panelLarge_symbol,
      panelLargeEmojiSize: size_panelLarge_emoji,
      panelLargeKaomojiSize: size_panelLarge_kaomoji,
      toolbarSize: size_toolbar,
      swipeSize: size_swipe,
    },

    // 【第三層：個別鍵盤微調 Overrides】
    // 預設為空，若前端介面上有單獨勾選某個鍵盤做修改，才將設定寫入此處
    overrides: {
      // 範例：
      // keyboard26Chinese: { alphabet: { light: { background: { normal: '#FF0000' } } } },
    }
  }
}
