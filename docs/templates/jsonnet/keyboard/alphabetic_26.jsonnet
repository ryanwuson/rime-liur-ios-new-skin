// 英文鍵盤（alphabetic）- 蝦米專用，預設小寫
local animation = import '../lib/animation.libsonnet';
local center = import '../lib/center.libsonnet';
local color = import '../lib/color.libsonnet';
local fontSize = import '../lib/fontSize.libsonnet';
local hintSymbolsData = import '../lib/hintSymbolsData.libsonnet';
local hintSymbolsStyles = import '../lib/hintSymbolsStyles.libsonnet';
local keyboardLayout = import '../lib/keyboardLayout.libsonnet';
local others = import '../lib/others.libsonnet';
local settings = import '../Settings.libsonnet';
local swipeDataEn = import '../lib/swipeData-en.libsonnet';
local swipeStyles = import '../lib/swipeStyles.libsonnet';
local toolbar = import '../lib/toolbar-en.libsonnet';  // 英文鍵盤專用 toolbar（顯示「英」）
local utils = import '../lib/utils.libsonnet';

local swipe_up = std.get(swipeDataEn, 'swipe_up', {});
local swipe_down = std.get(swipeDataEn, 'swipe_down', {});

// 創建字母按鍵（英文鍵盤使用 symbol，直接輸出字母）
local createButton(params={}) =
  local isLetter = std.get(params, 'isLetter', true);
  local hintSymbolsData_alphabetic = std.get(hintSymbolsData, 'alphabetic', {});
  std.prune({
    size: std.get(params, 'size'),
    bounds: std.get(params, 'bounds'),
    backgroundStyle: if isLetter then 'alphabeticBackgroundStyle' else std.get(params, 'backgroundStyle', 'systemButtonBackgroundStyle'),
    foregroundStyle:
      if isLetter then
        std.prune([
          params.key + 'ButtonForegroundStyle',
          if std.objectHas(swipe_up, params.key) && swipeStyles.getEffectiveSetting(params.key, 'showSwipeUpText') then params.key + 'ButtonUpForegroundStyle' else null,
          if std.objectHas(swipe_down, params.key) && swipeStyles.getEffectiveSetting(params.key, 'showSwipeDownText') then params.key + 'ButtonDownForegroundStyle' else null,
        ])
      else
        std.get(params, 'foregroundStyle', params.key + 'ButtonForegroundStyle'),
    [if isLetter then 'uppercasedStateForegroundStyle']: std.prune([
      params.key + 'ButtonUppercasedStateForegroundStyle',
      if std.objectHas(swipe_up, params.key) && swipeStyles.getEffectiveSetting(params.key, 'showSwipeUpText') then params.key + 'ButtonUpForegroundStyle' else null,
      if std.objectHas(swipe_down, params.key) && swipeStyles.getEffectiveSetting(params.key, 'showSwipeDownText') then params.key + 'ButtonDownForegroundStyle' else null,
    ]),
    [if isLetter then 'capsLockedStateForegroundStyle']: self.uppercasedStateForegroundStyle,
    hintStyle: params.key + 'ButtonHintStyle',
    // 添加長按符號樣式（如果該按鍵有長按數據且啟用長按功能）
    [if isLetter && std.objectHas(hintSymbolsData_alphabetic, params.key) && swipeStyles.getEffectiveSetting(params.key, 'enableLongPressActions') then 'hintSymbolsStyle']: params.key + 'ButtonHintSymbolsStyle',
    // 英文鍵盤使用 symbol，直接輸出字母，不進入輸入法緩衝區
    action: std.get(params, 'action', { symbol: params.key }),
    [if isLetter then 'uppercasedStateAction']: { symbol: std.asciiUpper(params.key) },
    repeatAction: std.get(params, 'repeatAction'),
    [if std.objectHas(swipe_up, params.key) && swipeStyles.getEffectiveSetting(params.key, 'enableSwipeUpActions') then 'swipeUpAction']: swipe_up[params.key].action,
    [if std.objectHas(swipe_down, params.key) && swipeStyles.getEffectiveSetting(params.key, 'enableSwipeDownActions') then 'swipeDownAction']: swipe_down[params.key].action,
    animation: ['ButtonScaleAnimation'],
  });

// 創建 Hint 樣式
local createHintStyle(key) = {
  [key + 'ButtonHintStyle']: {
    backgroundStyle: 'alphabeticHintBackgroundStyle',
    foregroundStyle: key + 'ButtonHintForegroundStyle',
    // 滑動氣泡樣式根據獨立的上下滑設定決定是否包含
    [if std.objectHas(swipe_up, key) && swipeStyles.getEffectiveSetting(key, 'enableSwipeUpActions') then 'swipeUpForegroundStyle']: key + 'ButtonSwipeUpHintForegroundStyle',
    [if std.objectHas(swipe_down, key) && swipeStyles.getEffectiveSetting(key, 'enableSwipeDownActions') then 'swipeDownForegroundStyle']: key + 'ButtonSwipeDownHintForegroundStyle',
  },
};

local keyboard(theme, orientation) =
  local ButtonSize = keyboardLayout.getButtonSize(theme, orientation);
  {
    preeditHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['preedit高度'],
    toolbarHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['toolbar高度'],
    keyboardHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['keyboard高度'],

    // 第一排
    qButton: createButton({ key: 'q', size: ButtonSize['普通键size'] }),
    wButton: createButton({ key: 'w', size: ButtonSize['普通键size'] }),
    eButton: createButton({ key: 'e', size: ButtonSize['普通键size'] }),
    rButton: createButton({ key: 'r', size: ButtonSize['普通键size'] }),
    tButton: createButton({ key: 't', size: ButtonSize['t键size'], bounds: ButtonSize['t键bounds'] }),
    yButton: createButton({ key: 'y', size: ButtonSize['y键size'], bounds: ButtonSize['y键bounds'] }),
    uButton: createButton({ key: 'u', size: ButtonSize['普通键size'] }),
    iButton: createButton({ key: 'i', size: ButtonSize['普通键size'] }),
    oButton: createButton({ key: 'o', size: ButtonSize['普通键size'] }),
    pButton: createButton({ key: 'p', size: ButtonSize['普通键size'] }),

    // 第二排
    aButton: createButton({ key: 'a', size: ButtonSize['a键size'], bounds: ButtonSize['a键bounds'] }),
    sButton: createButton({ key: 's', size: ButtonSize['普通键size'] }),
    dButton: createButton({ key: 'd', size: ButtonSize['普通键size'] }),
    fButton: createButton({ key: 'f', size: ButtonSize['普通键size'] }),
    gButton: createButton({ key: 'g', size: ButtonSize['普通键size'] }),
    hButton: createButton({ key: 'h', size: ButtonSize['普通键size'] }),
    jButton: createButton({ key: 'j', size: ButtonSize['普通键size'] }),
    kButton: createButton({ key: 'k', size: ButtonSize['普通键size'] }),
    lButton: createButton({ key: 'l', size: ButtonSize['l键size'], bounds: ButtonSize['l键bounds'] }),

    // 第三排
    shiftButton: createButton({ key: 'shift', action: 'shift', size: ButtonSize['shift键size'], bounds: ButtonSize['shift键bounds'], isLetter: false }) + {
      uppercasedStateAction: 'shift',
      capsLockedStateForegroundStyle: if settings.languageSwitchLayout == '1' then 
        ['shiftButtonCapsLockedForegroundStyle', 'shiftButtonTopChineseIndicatorStyle', 'shiftButtonBottomGlobeIndicatorStyle']
        else if settings.languageSwitchLayout == '2' then
        ['shiftButtonCapsLockedForegroundStyle', 'shiftButtonBottomGlobeIndicatorStyle']
        else 'shiftButtonCapsLockedForegroundStyle',
      uppercasedStateForegroundStyle: if settings.languageSwitchLayout == '1' then 
        ['shiftButtonUppercasedForegroundStyle', 'shiftButtonTopChineseIndicatorStyle', 'shiftButtonBottomGlobeIndicatorStyle']
        else if settings.languageSwitchLayout == '2' then
        ['shiftButtonUppercasedForegroundStyle', 'shiftButtonBottomGlobeIndicatorStyle']
        else 'shiftButtonUppercasedForegroundStyle',
      // 分別定義模式 1 與 模式 2 的滑動動作
      swipeUpAction: if settings.languageSwitchLayout == '1' then { keyboardType: 'pinyin' } else null,
      swipeDownAction: 'nextKeyboard',
      // 分別定義模式 1 與 模式 2 的氣泡樣式
      hintStyle: null,
      [if settings.languageSwitchLayout == '2' then 'hintSymbolsStyle']: 'shiftButtonLongPressChineseStyle',
      // 按鍵上的靜態提示圖層
      foregroundStyle: if settings.languageSwitchLayout == '1' then 
        ['shiftButtonForegroundStyle', 'shiftButtonTopChineseIndicatorStyle', 'shiftButtonBottomGlobeIndicatorStyle']
        else if settings.languageSwitchLayout == '2' then
        ['shiftButtonForegroundStyle', 'shiftButtonBottomGlobeIndicatorStyle']
        else 'shiftButtonForegroundStyle',
    },
    shiftButtonForegroundStyle: utils.makeSystemImageStyle({
      systemImageName: 'shift',
      normalColor: color[theme]['英文功能键文字颜色'],
      highlightColor: color[theme]['英文功能键文字颜色'],
      fontSize: fontSize['英文按键前景sf符号大小'],
    }),
    shiftButtonUppercasedForegroundStyle: utils.makeSystemImageStyle({
      systemImageName: 'shift.fill',
      normalColor: color[theme]['英文功能键文字颜色'],
      highlightColor: color[theme]['英文功能键文字颜色'],
      fontSize: fontSize['英文按键前景sf符号大小'],
    }),
    shiftButtonCapsLockedForegroundStyle: utils.makeSystemImageStyle({
      systemImageName: 'capslock.fill',
      normalColor: color[theme]['英文功能键文字颜色'],
      highlightColor: color[theme]['英文功能键文字颜色'],
      fontSize: fontSize['英文按键前景sf符号大小'],
    }),
    // 靜態指示器：上方「中」
    shiftButtonTopChineseIndicatorStyle: {
      buttonStyleType: 'text',
      text: '中',
      fontSize: fontSize['英文上划文字大小'],
      normalColor: color[theme]['英文功能键文字颜色'],
      center: { x: 0.5, y: 0.2 },
    },
    // 靜態指示器：下方「地球」
    shiftButtonBottomGlobeIndicatorStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'globe',
      fontSize: fontSize['英文下划文字大小'],
      normalColor: color[theme]['英文功能键文字颜色'],
      center: { x: 0.5, y: 0.8 },
    },
    // 模式 1：預設 Shift 氣泡樣式（包含上滑顯示「中」）
    shiftButtonHintStyle1: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'shiftButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'shiftButtonSwipeUpChineseForegroundStyle', // 模式 1 上滑顯示「中」
      swipeDownForegroundStyle: 'shiftButtonSwipeDownHintForegroundStyle',
    },
    // 模式 2：自訂 Shift 氣泡樣式（移除上滑圖示）
    shiftButtonHintStyle2: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'shiftButtonHintForegroundStyle',
      swipeDownForegroundStyle: 'shiftButtonSwipeDownHintForegroundStyle',
    },
    shiftButtonHintForegroundStyle: utils.makeSystemImageStyle({
      systemImageName: 'shift',
      normalColor: color[theme]['英文按下气泡文字颜色'],
      highlightColor: color[theme]['按下气泡文字顏色'],
      fontSize: fontSize['划动气泡前景文字大小'],
      center: { x: 0.5, y: 0.63 }, // 修正圖示在氣泡中的位置
    }),
    shiftButtonSwipeDownHintForegroundStyle: utils.makeSystemImageStyle({
      systemImageName: 'globe',
      normalColor: color[theme]['英文功能键文字颜色'],
      highlightColor: color[theme]['英文功能键文字颜色'],
      fontSize: fontSize['划动气泡前景文字大小'],
      center: { x: 0.5, y: 0.63 },
    }),

    // z 鍵：橫屏時移除上滑切換單手鍵盤功能和圖示
    zButton: if orientation == 'landscape' then
      {
        size: ButtonSize['普通键size'],
        backgroundStyle: 'alphabeticBackgroundStyle',
        // 橫屏時不顯示上滑圖示，只顯示下滑圖示
        foregroundStyle: ['zButtonForegroundStyle', 'zButtonDownForegroundStyle'],
        uppercasedStateForegroundStyle: ['zButtonUppercasedStateForegroundStyle', 'zButtonDownForegroundStyle'],
        capsLockedStateForegroundStyle: self.uppercasedStateForegroundStyle,
        // 橫屏時使用不含上滑的 hintStyle
        hintStyle: 'zButtonHintStyleLandscape',
        // 橫屏時使用不含「左手模式」的長按樣式
        hintSymbolsStyle: 'zButtonHintSymbolsStyleLandscape',
        action: { symbol: 'z' },
        uppercasedStateAction: { symbol: "Z" },
        // 橫屏時只保留下滑，移除上滑
        swipeDownAction: swipe_down['z'].action,
        animation: ['ButtonScaleAnimation'],
      }
    else
      createButton({ key: 'z', size: ButtonSize['普通键size'] }) + {
        hintStyle: 'zButtonHintStyle',
        hintSymbolsStyle: 'zButtonHintSymbolsStyle',
      },
    // 橫屏 z 鍵的 hintStyle（不含上滑）
    zButtonHintStyleLandscape: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'zButtonHintForegroundStyle',
      [if swipeStyles.getEffectiveSetting('z', 'enableSwipeDownActions') && swipeStyles.getEffectiveSetting('z', 'showSwipeDownText') then 'swipeDownForegroundStyle']: 'zButtonSwipeDownHintForegroundStyle',
    },
    // 橫屏 z 鍵長按樣式（不含「左手模式」，3個選項：Z、句首、z）
    zButtonHintSymbolsStyleLandscape: {
      backgroundStyle: 'alphabeticHintSymbolsBackgroundStyle',
      selectedBackgroundStyle: 'alphabeticHintSymbolsSelectedStyle',
      selectedIndex: 0,
      insets: { left: 8, right: 8, top: 3, bottom: 3 },
      size: { width: 38, height: 25 },
      symbolStyles: [
        'zButtonHintSymbolsStyleLandscapeOf0',
        'zButtonHintSymbolsStyleLandscapeOf1',
        'zButtonHintSymbolsStyleLandscapeOf2',
      ],
    },
    zButtonHintSymbolsStyleLandscapeOf0: {
      action: { sendKeys: '``Z' },
      foregroundStyle: 'zButtonHintSymbolsForegroundStyleOf0',
    },
    zButtonHintSymbolsStyleLandscapeOf1: {
      action: { shortcut: '#行首' },
      foregroundStyle: 'zButtonHintSymbolsForegroundStyleOf2',
    },
    zButtonHintSymbolsStyleLandscapeOf2: {
      action: { sendKeys: '``z' },
      foregroundStyle: 'zButtonHintSymbolsForegroundStyleOf3',
    },

    xButton: createButton({ key: 'x', size: ButtonSize['普通键size'] }),
    cButton: createButton({ key: 'c', size: ButtonSize['普通键size'] }),
    vButton: createButton({ key: 'v', size: ButtonSize['普通键size'] }),
    bButton: createButton({ key: 'b', size: ButtonSize['普通键size'] }),
    nButton: createButton({ key: 'n', size: ButtonSize['普通键size'] }),
    mButton: createButton({ key: 'm', size: ButtonSize['普通键size'] }),

    backspaceButton: {
      size: ButtonSize['backspace键size'],
      bounds: ButtonSize['backspace键bounds'],
      backgroundStyle: 'systemButtonBackgroundStyle',
      foregroundStyle: ['backspaceButtonForegroundStyle', 'backspaceButtonDownForegroundStyle'],
      action: 'backspace',
      repeatAction: 'backspace',
      swipeUpAction: { shortcut: '#deleteText' },
      swipeDownAction: { shortcut: '#undo' },
      animation: ['ButtonScaleAnimation'],
    },
    backspaceButtonForegroundStyle: utils.makeSystemImageStyle({
      systemImageName: 'delete.left',
      normalColor: color[theme]['英文功能键文字颜色'],
      highlightColor: color[theme]['英文功能键文字颜色'],
      fontSize: fontSize['英文按键前景sf符号大小'],
    }),
    backspaceButtonDownForegroundStyle: {
      buttonStyleType: 'text',
      text: 'undo',
      fontSize: fontSize['下划文字大小'],
      normalColor: color[theme]['英文功能键文字颜色'],
      center: { x: 0.5, y: 0.8 },
    },

    // 第四排（蝦米專用）
    numericButton: createButton({ key: 'numeric', size: ButtonSize['numeric键size'], action: { keyboardType: 'numeric' }, isLetter: false }) + {
      swipeUpAction: { keyboardType: 'symbolic' },
      [if settings.keyboardLayout == 'row' then 'swipeDownAction']: { keyboardType: 'numeric_panel' },  // row模式下滑到九宮格
      hintStyle: null,
      hintSymbolsStyle: 'numericButtonHintSymbolsStyle',
    },
    numericButtonForegroundStyle: utils.makeTextStyle({
      text: '123',
      normalColor: color[theme]['英文功能键文字颜色'],
      highlightColor: color[theme]['英文功能键文字颜色'],
      fontSize: fontSize['英文按键前景sf符号大小'],  // 使用 systemSize
    }),
    numericButtonHintSymbolsStyleOf0: {
      action: { symbol: '+' },
      foregroundStyle: 'numericButtonHintSymbolsForegroundStyleOf0',
    },
    numericButtonHintSymbolsForegroundStyleOf0: {
      buttonStyleType: 'text',
      text: '+',
      fontSize: 14,
      normalColor: color[theme]['英文长按非选中字体顏色'],
      highlightColor: color[theme]['英文长按选中字体顏色'],
      center: { x: 0.5, y: 0.48 },
    },
    numericButtonHintSymbolsStyleOf1: {
      action: { symbol: '-' },
      foregroundStyle: 'numericButtonHintSymbolsForegroundStyleOf1',
    },
    numericButtonHintSymbolsForegroundStyleOf1: {
      buttonStyleType: 'text',
      text: '-',
      fontSize: 14,
      normalColor: color[theme]['英文长按非选中字体顏色'],
      highlightColor: color[theme]['英文长按选中字体顏色'],
      center: { x: 0.5, y: 0.48 },
    },
    numericButtonHintSymbolsStyleOf2: {
      action: { symbol: '×' },
      foregroundStyle: 'numericButtonHintSymbolsForegroundStyleOf2',
    },
    numericButtonHintSymbolsForegroundStyleOf2: {
      buttonStyleType: 'text',
      text: '×',
      fontSize: 14,
      normalColor: color[theme]['英文长按非选中字体顏色'],
      highlightColor: color[theme]['英文长按选中字体顏色'],
      center: { x: 0.5, y: 0.48 },
    },
    numericButtonHintSymbolsStyleOf3: {
      action: { symbol: '÷' },
      foregroundStyle: 'numericButtonHintSymbolsForegroundStyleOf3',
    },
    numericButtonHintSymbolsForegroundStyleOf3: {
      buttonStyleType: 'text',
      text: '÷',
      fontSize: 14,
      normalColor: color[theme]['英文长按非选中字体顏色'],
      highlightColor: color[theme]['英文长按选中字体顏色'],
      center: { x: 0.5, y: 0.48 },
    },
    numericButtonHintSymbolsStyleOf4: {
      action: { symbol: '=' },
      foregroundStyle: 'numericButtonHintSymbolsForegroundStyleOf4',
    },
    numericButtonHintSymbolsForegroundStyleOf4: {
      buttonStyleType: 'text',
      text: '=',
      fontSize: 14,
      normalColor: color[theme]['英文长按非选中字体顏色'],
      highlightColor: color[theme]['英文长按选中字体顏色'],
      center: { x: 0.5, y: 0.48 },
    },
    numericButtonHintSymbolsStyleOf5: {
      action: { symbol: '≠' },
      foregroundStyle: 'numericButtonHintSymbolsForegroundStyleOf5',
    },
    numericButtonHintSymbolsForegroundStyleOf5: {
      buttonStyleType: 'text',
      text: '≠',
      fontSize: 14,
      normalColor: color[theme]['英文长按非选中字体顏色'],
      highlightColor: color[theme]['英文长按选中字体顏色'],
      center: { x: 0.5, y: 0.48 },
    },

    // 蝦米逗號鍵（enableEnglishSwitchLayout 開啟時：直接顯示「中」，按下切換中文鍵盤）
    commaButton: {
      size: ButtonSize['comma键size'],
      backgroundStyle: 'alphabeticBackgroundStyle',
      foregroundStyle: 'commaButtonForegroundStyle',
      // 模式 2：直接切換中文鍵盤；模式 1：輸出逗號
      action: if settings.languageSwitchLayout == '2' then { keyboardType: 'pinyin' } else { symbol: ',' },
      // 模式 2：移除上滑；模式 1：上滑輸出逗號
      swipeUpAction: if settings.languageSwitchLayout == '2' then null else { symbol: ',' },
      [if swipeStyles.getEffectiveSetting(',', 'enableSwipeDownActions') then 'swipeDownAction']: { keyboardType: 'kaomojis' },
      // 模式 2：不顯示氣泡（無上滑，無需氣泡）；模式 1：顯示氣泡
      hintStyle: if settings.languageSwitchLayout == '2' then null else 'commaButtonHintStyle',
      // 模式 2：移除長按；模式 1：沿用原設定
      hintSymbolsStyle: if settings.languageSwitchLayout == '2' then null else (if swipeStyles.getEffectiveSetting(',', 'enableLongPressActions') then 'commaButtonHintSymbolsStyle' else null),
      animation: ['ButtonScaleAnimation'],
    },
    commaButtonForegroundStyle: utils.makeTextStyle({
      // 模式 2：顯示「中」；模式 1：顯示「,」
      text: if settings.languageSwitchLayout == '2' then '中' else ',',
      normalColor: color[theme]['英文字母键文字颜色'],
      highlightColor: color[theme]['英文字母键文字颜色'],
      // 模式 2：與「英」字同大小；模式 1：一般按鍵大小
      fontSize: if settings.languageSwitchLayout == '2' then fontSize['垂直候选控制按钮字体大小'] else fontSize['按键前景文字大小'],
    }),
    commaButtonHintStyle: {
      // 模式 2：用普通氣泡（無上滑區域）；模式 1：用逗號句號專用氣泡
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'commaButtonHintForegroundStyle',
      // 上滑氣泡：模式 2 無上滑，模式 1 顯示逗號
      swipeUpForegroundStyle: if settings.languageSwitchLayout == '2' then null else 'commaButtonSwipeUpHintForegroundStyle',
    },
    commaButtonHintForegroundStyle: utils.makeTextStyle({
      // 模式 2：氣泡顯示「中」；模式 1：顯示「,」
      text: if settings.languageSwitchLayout == '2' then '中' else ',',
      normalColor: color[theme]['英文按下气泡文字颜色'],
      highlightColor: color[theme]['按下气泡文字顏色'],
      fontSize: fontSize['长按气泡文字大小'],
      // 模式 2：對齊 C 鍵氣泡位置
      center: if settings.languageSwitchLayout == '2' then { x: 0.5, y: 0.63 } else null,
    }),
    // 「中」字靜態指示器（顯示在鍵盤上逗號鍵的正中間上方）
    commaButtonChineseIndicatorStyle: {
      buttonStyleType: 'text',
      text: '中',
      fontSize: fontSize['英文上划文字大小'],
      normalColor: color[theme]['英文上滑提示文字顏色'],
      center: { x: 0.5, y: 0.2 }, // 鍵盤鍵位上方正中間，參考 H 鍵 '\' 的位置
    },
    // 上滑切換中文時的「中」字氣泡（位置參考 F 鍵）
    shiftButtonSwipeUpChineseForegroundStyle: {
      buttonStyleType: 'text',
      text: '中',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['英文功能键文字颜色'],
      center: { x: 0.5, y: 0.63 }, // 修正位置，與其他按鍵一致
    },
    // 上滑切換中文時的「中」字氣泡（位置參考 F 鍵，逗號鍵專用背景偏移不同）
    commaButtonSwipeUpChineseForegroundStyle: {
      buttonStyleType: 'text',
      text: '中',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['划动气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    commaButtonSwipeUpHintForegroundStyle: {
      buttonStyleType: 'text',
      text: ',',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['划动气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    // 長按切換中文的氣泡樣式（比照中文鍵盤 Space 長按）
    commaButtonSwitchChineseStyle: {
      backgroundStyle: 'alphabeticHintSymbolsBackgroundStyle',
      selectedBackgroundStyle: 'alphabeticHintSymbolsSelectedStyle',
      selectedIndex: 0,
      size: { width: 38, height: 25 },
      insets: { left: 8, right: 8, top: 3, bottom: 3 },
      symbolStyles: [
        'commaButtonSwitchChineseStyleOf0',
      ],
    },
    commaButtonSwitchChineseStyleOf0: {
      action: { keyboardType: 'pinyin' },
      foregroundStyle: 'commaButtonSwitchChineseStyleForegroundOf0',
    },
    commaButtonSwitchChineseStyleForegroundOf0: {
      buttonStyleType: 'text',
      text: '中',
      fontSize: fontSize['长按气泡文字大小'],
      normalColor: color[theme]['英文长按非选中字体顏色'],
      highlightColor: color[theme]['英文长按选中字体顏色'],
      center: { x: 0.5, y: 0.48 },
    },

    // 空白鍵（不需要上滑動作和 notification）
    spaceButton: {
      size: ButtonSize['space键size'],
      backgroundStyle: 'spaceButtonBackgroundStyle',
      foregroundStyle: 'spaceButtonForegroundStyle',
      action: 'space',
      // 移除上滑動作和 notification
      animation: ['ButtonScaleAnimation'],
    },
    spaceButtonForegroundStyle: utils.makeTextStyle({
      text: 'English',
      normalColor: color[theme]['英文空白键文字颜色'],  // 使用空白鍵專用文字色
      highlightColor: color[theme]['英文空白键文字颜色'],  // 使用空白鍵專用文字色
      fontSize: fontSize['英文空白键文字大小'],  // 使用 Layer 3 可覆蓋的字號
    }),

    // 蝦米句號鍵（模式 2：顯示「.」直出英文句號，上滑出「,」）
    periodButton: {
      size: ButtonSize['period键size'],
      backgroundStyle: 'alphabeticBackgroundStyle',
      foregroundStyle: if settings.languageSwitchLayout == '2' then ['periodButtonForegroundStyle', 'periodButtonSwipeUpIndicatorStyle'] else 'periodButtonForegroundStyle',
      // 模式 2：直出英文句號；模式 1：直出句號
      action: if settings.languageSwitchLayout == '2' then { symbol: '.' } else { symbol: '.' },
      [if settings.languageSwitchLayout == '2' then 'swipeUpAction']: { symbol: ',' },
      // 無論哪個模式，下滑都跳轉 Emoji 鍵盤
      [if swipeStyles.getEffectiveSetting('.', 'enableSwipeDownActions') then 'swipeDownAction']: { keyboardType: 'emoji' },
      hintStyle: 'periodButtonHintStyle',
      // 移除長按功能
      animation: ['ButtonScaleAnimation'],
    },
    periodButtonForegroundStyle: utils.makeTextStyle({
      // 模式 2：顯示「.」；模式 1：顯示「.」
      text: if settings.languageSwitchLayout == '2' then '.' else '.',
      normalColor: color[theme]['英文字母键文字颜色'],
      highlightColor: color[theme]['英文字母键文字颜色'],
      fontSize: fontSize['按键前景文字大小'],
    }),
    periodButtonSwipeUpIndicatorStyle: {
      buttonStyleType: 'text',
      text: ',',
      fontSize: fontSize['英文上划文字大小'],
      normalColor: color[theme]['英文上滑提示文字顏色'],
      center: { x: 0.5, y: 0.2 },
    },
    periodButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'periodButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'periodButtonSwipeUpHintForegroundStyle',
    },
    periodButtonHintForegroundStyle: utils.makeTextStyle({
      // 模式 2：氣泡顯示「.」；模式 1：顯示「.」
      text: if settings.languageSwitchLayout == '2' then '.' else '.',
      normalColor: color[theme]['英文按下气泡文字颜色'],
      highlightColor: color[theme]['按下气泡文字顏色'],
      fontSize: fontSize['长按气泡文字大小'],
    }),
    periodButtonSwipeUpHintForegroundStyle: {
      buttonStyleType: 'text',
      text: ',',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['划动气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },

    // Enter 鍵
    enterButton: createButton({ key: 'enter', action: 'enter', isLetter: false }) + {
      backgroundStyle: 'enterButtonBackgroundStyle',
      foregroundStyle: 'enterButtonForegroundStyle',
      notification: ['returnKeyTypeChangedNotification', 'preeditChangedForEnterButtonNotification'],
      hintStyle: null,  // 不顯示按下氣泡（與 Shift 鍵一致）
      [if swipeStyles.getEffectiveSetting('enter', 'enableSwipeUpActions') then 'swipeUpAction']: { combine: [{ keyboardType: 'bopomofo' }, { sendKeys: "';" }] },  // 上滑跳轉到注音鍵盤並觸發注音模式
      [if swipeStyles.getEffectiveSetting('enter', 'enableSwipeDownActions') then 'swipeDownAction']: { shortcut: '#换行' },  // 下滑換行
    },
    enterButtonForegroundStyle: utils.makeTextStyle({
      text: '$returnKeyType',
      normalColor: color[theme]['英文enter键文字颜色'],
      highlightColor: color[theme]['英文enter键文字颜色'],
      fontSize: fontSize['英文按键前景sf符号大小'],  // 使用 systemSize
    }),

    // 背景樣式
    
    // 空白鍵專屬背景樣式
    spaceButtonBackgroundStyle: utils.makeGeometryStyle({
      insets: { top: 2, left: 2, bottom: 2, right: 2 },
      normalColor: color[theme]['空白键背景颜色-普通'],
      highlightColor: color[theme]['空白键背景颜色-高亮'],
      cornerRadius: 8.5,
      normalLowerEdgeColor: color[theme]['空白键阴影颜色-普通'],
      highlightLowerEdgeColor: color[theme]['空白键阴影颜色-高亮'],
      borderSize: color[theme]['空白键边框宽度'],
      normalBorderColor: color[theme]['空白键边框颜色'],
      highlightBorderColor: color[theme]['空白键边框颜色'],
    }),
    alphabeticBackgroundStyle: utils.makeGeometryStyle({
      insets: { top: 2, left: 2, bottom: 2, right: 2 },
      normalColor: color[theme]['英文字母键背景颜色-普通'],
      highlightColor: color[theme]['英文字母键背景颜色-高亮'],
      cornerRadius: 8.5,
      normalLowerEdgeColor: color[theme]['英文字母键底边缘颜色-普通'],
      highlightLowerEdgeColor: color[theme]['英文字母键底边缘颜色-高亮'],
      borderSize: color[theme]['英文字母键边框宽度'],
      normalBorderColor: color[theme]['英文字母键边框颜色-普通'],
      highlightBorderColor: color[theme]['英文字母键边框颜色-高亮'],
    }),
    systemButtonBackgroundStyle: utils.makeGeometryStyle({
      insets: { top: 2, left: 2, bottom: 2, right: 2 },
      normalColor: color[theme]['英文功能键背景颜色-普通'],
      highlightColor: color[theme]['英文功能键背景颜色-高亮'],
      cornerRadius: 8.5,
      normalLowerEdgeColor: color[theme]['英文字母键底边缘颜色-普通'],
      highlightLowerEdgeColor: color[theme]['英文字母键底边缘颜色-高亮'],
      borderSize: color[theme]['英文功能键边框宽度'],
      normalBorderColor: color[theme]['英文功能键边框颜色-普通'],
      highlightBorderColor: color[theme]['英文功能键边框颜色-高亮'],
    }),
    enterButtonBackgroundStyle: utils.makeGeometryStyle({
      insets: { top: 2, left: 2, bottom: 2, right: 2 },
      normalColor: color[theme]['英文enter键背景颜色-普通'],
      highlightColor: color[theme]['英文enter键背景颜色-高亮'],
      cornerRadius: 8.5,
      normalLowerEdgeColor: color[theme]['英文字母键底边缘颜色-普通'],
      highlightLowerEdgeColor: color[theme]['英文字母键底边缘颜色-高亮'],
      borderSize: color[theme]['英文enter键边框宽度'],
      normalBorderColor: color[theme]['英文enter键边框颜色-普通'],
      highlightBorderColor: color[theme]['英文enter键边框颜色-高亮'],
    }),
    // 點按氣泡背景（fileImage 樣式，參考指尖生花，使用 center 偏移避免第一排被裁切）
    alphabeticHintBackgroundStyle: {
      buttonStyleType: 'fileImage',
      contentMode: 'scaleAspectFit',
      insets: { left: -3, right: -3, top: -3, bottom: -3 },
      center: { y: 0.68 },  // 向下偏移，避免第一排氣泡被裁切
      normalImage: { file: 'hint', image: 'IMG3' },
      highlightImage: { file: 'hint', image: 'IMG3' },
    },
    // d 鍵長按樣式（水平排列尺寸，但選中底色用較小的左邊距）
    dButtonHintSymbolsStyle: {
      insets: { top: 3, bottom: 3, left: 8, right: 8 },
      backgroundStyle: 'alphabeticHintSymbolsBackgroundStyle',
      size: { width: 38, height: 25 },
      symbolStyles: [
        'dButtonHintSymbolsStyleOf0',
        'dButtonHintSymbolsStyleOf1',
        'dButtonHintSymbolsStyleOf2',
        'dButtonHintSymbolsStyleOf3',
        'dButtonHintSymbolsStyleOf4',
      ],
      selectedBackgroundStyle: 'dButtonHintSymbolsSelectedStyle',
      selectedIndex: 0,
    },
    // d 鍵專用的選中背景（與 = 鍵及其他字母鍵一致）
    dButtonHintSymbolsSelectedStyle: {
      buttonStyleType: 'fileImage',
      insets: { left: 6, right: 6, top: -3, bottom: -3 },
      normalImage: { file: 'hint', image: 'IMG2' },
      highlightImage: { file: 'hint', image: 'IMG2' },
    },
    // 逗號長按樣式（覆蓋自動生成的，使用專用背景）
    commaButtonHintSymbolsStyle: {
      insets: { top: 3, bottom: 3, left: 8, right: 8 },
      backgroundStyle: 'alphabeticHintSymbolsBackgroundStyle',
      size: { width: 38, height: 25 },
      symbolStyles: [
        'commaButtonHintSymbolsStyleOf0',
        'commaButtonHintSymbolsStyleOf1',
        'commaButtonHintSymbolsStyleOf2',
        'commaButtonHintSymbolsStyleOf3',
        'commaButtonHintSymbolsStyleOf4',
      ],
      selectedBackgroundStyle: 'alphabeticHintSymbolsSelectedStyle',
      selectedIndex: std.get(hintSymbolsData, 'alphabetic', {}).comma.selectedIndex,
    },
    // 句號長按樣式（覆蓋自動生成的，使用專用背景）
    periodButtonHintSymbolsStyle: {
      insets: { top: 3, bottom: 3, left: 8, right: 8 },
      backgroundStyle: 'alphabeticHintSymbolsBackgroundStyle',
      size: { width: 38, height: 25 },
      symbolStyles: [
        'periodButtonHintSymbolsStyleOf0',
        'periodButtonHintSymbolsStyleOf1',
        'periodButtonHintSymbolsStyleOf2',
        'periodButtonHintSymbolsStyleOf3',
        'periodButtonHintSymbolsStyleOf4',
      ],
      selectedBackgroundStyle: 'alphabeticHintSymbolsSelectedStyle',
      selectedIndex: std.get(hintSymbolsData, 'alphabetic', {}).period.selectedIndex,
    },


    // 123 鍵長按樣式
    numericButtonHintSymbolsStyle: {
      backgroundStyle: 'alphabeticHintSymbolsBackgroundStyle',
      selectedBackgroundStyle: 'alphabeticHintSymbolsSelectedStyle',
      selectedIndex: std.get(hintSymbolsData, 'alphabetic', {}).comma.selectedIndex,
      size: { width: 30, height: 25 },
      insets: { left: 8, right: 8, top: 3, bottom: 3 },
      symbolStyles: [
        'numericButtonHintSymbolsStyleOf0',
        'numericButtonHintSymbolsStyleOf1',
        'numericButtonHintSymbolsStyleOf2',
        'numericButtonHintSymbolsStyleOf3',
        'numericButtonHintSymbolsStyleOf4',
        'numericButtonHintSymbolsStyleOf5',
      ],
    },
    // 長按氣泡背景（fileImage 樣式，參考指尖生花）
    alphabeticHintSymbolsBackgroundStyle: {
      buttonStyleType: 'fileImage',
      insets: { bottom: -10, left: 3, right: 3, top: -10 },
      normalImage: { file: 'hint', image: 'IMG1' },
      highlightImage: { file: 'hint', image: 'IMG1' },
    },
    // 長按選中背景（fileImage 樣式，參考指尖生花）
    alphabeticHintSymbolsSelectedStyle: {
      buttonStyleType: 'fileImage',
      insets: { left: 6, right: 6, top: -3, bottom: -3 },
      normalImage: { file: 'hint', image: 'IMG2' },
      highlightImage: { file: 'hint', image: 'IMG2' },
    },

    // 動畫
    ButtonScaleAnimation: animation['26键按键动画'],

    // 通知
    returnKeyTypeChangedNotification: {
      notificationType: 'returnKeyType',
      returnKeyType: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
      backgroundStyle: 'enterButtonBackgroundStyle',
      foregroundStyle: 'returnKeyTypeForegroundStyle',
    },
    returnKeyTypeForegroundStyle: utils.makeTextStyle({
      text: '$returnKeyType',
      normalColor: color[theme]['英文enter键文字颜色'],
      highlightColor: color[theme]['英文enter键文字颜色'],
      fontSize: fontSize['英文按键前景sf符号大小'],  // 使用 systemSize
    }),
    preeditChangedForEnterButtonNotification: {
      notificationType: 'preeditChanged',
      preeditIsEmpty: false,
      backgroundStyle: 'enterButtonBackgroundStyle',
      foregroundStyle: 'enterCommitCandidateForegroundStyle',
    },
    preeditChangedForSpaceButtonNotification: {
      notificationType: 'preeditChanged',
      preeditIsEmpty: false,
      backgroundStyle: 'spaceButtonBackgroundStyle',
      foregroundStyle: 'commitCandidateForegroundStyle',
    },
    commitCandidateForegroundStyle: utils.makeTextStyle({
      text: '確認',
      normalColor: color[theme]['英文功能键文字颜色'],
      highlightColor: color[theme]['英文功能键文字颜色'],
      fontSize: 16,
    }),
    enterCommitCandidateForegroundStyle: utils.makeTextStyle({
      text: '確認',
      normalColor: color[theme]['英文enter键文字颜色'],
      highlightColor: color[theme]['英文enter键文字颜色'],
      fontSize: fontSize['英文按键前景sf符号大小'],
    }),
    
    // 鍵盤背景樣式（支援 Layer 3 獨立背景色）
    keyboardBackgroundStyle: {
      buttonStyleType: 'geometry',
      normalColor: color[theme]['英文键盘背景颜色'],
    },
    keyboardStyle: {
      backgroundStyle: 'keyboardBackgroundStyle',
    },
  }
  // Hint 樣式
  + createHintStyle('q') + createHintStyle('w') + createHintStyle('e') + createHintStyle('r') + createHintStyle('t')
  + createHintStyle('y') + createHintStyle('u') + createHintStyle('i') + createHintStyle('o') + createHintStyle('p')
  + createHintStyle('a') + createHintStyle('s') + createHintStyle('d') + createHintStyle('f') + createHintStyle('g')
  + createHintStyle('h') + createHintStyle('j') + createHintStyle('k') + createHintStyle('l')
  + createHintStyle('z') + createHintStyle('x') + createHintStyle('c') + createHintStyle('v')
  + createHintStyle('b') + createHintStyle('n') + createHintStyle('m');

{
  new(theme, orientation, skinName='蝦米輸入法'):
    keyboardLayout.getEnLayout(theme, orientation) +
    swipeStyles.makeSwipeStyles(theme, { swipe_up: swipe_up, swipe_down: swipe_down, type: 'alphabetic_en', enableSwipeHint: true }) +
    hintSymbolsStyles.getStyle(theme, hintSymbolsData.alphabetic) +
    toolbar.getToolBar(theme, orientation, 'keyboard26Alphabetic', skinName) +  // 工具栏（傳入 keyboardType 和 skinName）
    utils.genAlphabeticStyles(theme) +
    utils.genHintStyles(theme) +
    keyboard(theme, orientation),
}
