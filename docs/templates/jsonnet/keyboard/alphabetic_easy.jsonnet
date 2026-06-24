// easy_en 專用英文鍵盤（alphabetic_easy）- 竖屏 + 橫屏共用
// 關鍵差異：字母鍵使用 character 而非 symbol，讓輸入進入 Rime 緩衝區，使 easy_en 能顯示候選字
// 工具列「中」按鈕用 combine 切回 pinyin + switchRimeSchema: 'liur'
local animation = import '../lib/animation.libsonnet';
local color = import '../lib/color.libsonnet';
local fontSize = import '../lib/fontSize.libsonnet';
local hintSymbolsData = import '../lib/hintSymbolsData_easy_en.libsonnet';
local hintSymbolsStyles = import '../lib/hintSymbolsStyles.libsonnet';
local keyboardLayout = import '../lib/keyboardLayout.libsonnet';
local others = import '../lib/others.libsonnet';
local settings = import '../Settings.libsonnet';
local swipeDataEn = import '../lib/swipeData-easy-en.libsonnet';  // ★ 使用 Easy English 專用的 swipeData
local swipeStyles = import '../lib/swipeStyles.libsonnet';
local toolbar = import '../lib/toolbar-easy.libsonnet';  // easy_en 專用工具列（「中」切回 liur）
local utils = import '../lib/utils.libsonnet';

local swipe_up = std.get(swipeDataEn, 'swipe_up', {});
local swipe_down = std.get(swipeDataEn, 'swipe_down', {});

// ===== createButton：字母鍵改用 character（送進 Rime）；功能鍵維持原本 action =====
local createButton(params={}) =
  local isLetter = std.get(params, 'isLetter', true);
  local key = params.key;
  local hintSymbolsData_alphabetic = std.get(hintSymbolsData, 'alphabetic', {});
  std.prune({
    size: std.get(params, 'size'),
    bounds: std.get(params, 'bounds'),
    backgroundStyle: if isLetter then 'alphabeticBackgroundStyle' else std.get(params, 'backgroundStyle', 'systemButtonBackgroundStyle'),
    foregroundStyle:
      if isLetter then
        std.prune([
          key + 'ButtonForegroundStyle',
          if std.objectHas(swipe_up, key) && swipeStyles.getEffectiveSetting(key, 'showSwipeUpText') then key + 'ButtonUpForegroundStyle' else null,
          if std.objectHas(swipe_down, key) && swipeStyles.getEffectiveSetting(key, 'showSwipeDownText') then key + 'ButtonDownForegroundStyle' else null,
        ])
      else
        std.get(params, 'foregroundStyle', key + 'ButtonForegroundStyle'),
    [if isLetter then 'uppercasedStateForegroundStyle']: std.prune([
      key + 'ButtonUppercasedStateForegroundStyle',
      if std.objectHas(swipe_up, key) && swipeStyles.getEffectiveSetting(key, 'showSwipeUpText') then key + 'ButtonUpForegroundStyle' else null,
      if std.objectHas(swipe_down, key) && swipeStyles.getEffectiveSetting(key, 'showSwipeDownText') then key + 'ButtonDownForegroundStyle' else null,
    ]),
    [if isLetter then 'capsLockedStateForegroundStyle']: self.uppercasedStateForegroundStyle,
    hintStyle: key + 'ButtonHintStyle',
    [if isLetter && std.objectHas(hintSymbolsData_alphabetic, key) && swipeStyles.getEffectiveSetting(key, 'enableLongPressActions') then 'hintSymbolsStyle']: key + 'ButtonHintSymbolsStyle',
    // ★ 關鍵修改：字母鍵用 character（送進 Rime 引擎）；非字母鍵用傳入的 action
    action: if isLetter then
      std.get(params, 'action', { character: key })
    else
      std.get(params, 'action'),
    // ★ 大寫也用 character
    [if isLetter then 'uppercasedStateAction']: { character: std.asciiUpper(key) },
    repeatAction: std.get(params, 'repeatAction'),
    [if std.objectHas(swipe_up, key) && swipeStyles.getEffectiveSetting(key, 'enableSwipeUpActions') then 'swipeUpAction']: swipe_up[key].action,
    [if std.objectHas(swipe_down, key) && swipeStyles.getEffectiveSetting(key, 'enableSwipeDownActions') then 'swipeDownAction']: swipe_down[key].action,
    animation: ['ButtonScaleAnimation'],
  });

local createHintStyle(key) = {
  [key + 'ButtonHintStyle']: {
    backgroundStyle: 'alphabeticHintBackgroundStyle',
    foregroundStyle: key + 'ButtonHintForegroundStyle',
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
      // shift 上滑：languageSwitchLayout '1' 才有，切回 pinyin + switchRimeSchema: liur
      [if settings.languageSwitchLayout == '1' then 'swipeUpAction']: {
        combine: [
          { keyboardType: 'pinyin' },
          { switchRimeSchema: 'liur' },
        ],
      },
      swipeDownAction: 'nextKeyboard',
      hintStyle: null,
      hintSymbolsStyle: 'numericButtonHintSymbolsStyle',
      // 靜態 hint：模式 1 上方「中」+ 下方「地球」；模式 2 只有下方「地球」
      foregroundStyle: if settings.languageSwitchLayout == '1' then
        ['shiftButtonForegroundStyle', 'shiftButtonTopChineseIndicatorStyle', 'shiftButtonBottomGlobeIndicatorStyle']
      else
        ['shiftButtonForegroundStyle', 'shiftButtonBottomGlobeIndicatorStyle'],
      capsLockedStateForegroundStyle: if settings.languageSwitchLayout == '1' then
        ['shiftButtonCapsLockedForegroundStyle', 'shiftButtonTopChineseIndicatorStyle', 'shiftButtonBottomGlobeIndicatorStyle']
      else
        ['shiftButtonCapsLockedForegroundStyle', 'shiftButtonBottomGlobeIndicatorStyle'],
      uppercasedStateForegroundStyle: if settings.languageSwitchLayout == '1' then
        ['shiftButtonUppercasedForegroundStyle', 'shiftButtonTopChineseIndicatorStyle', 'shiftButtonBottomGlobeIndicatorStyle']
      else
        ['shiftButtonUppercasedForegroundStyle', 'shiftButtonBottomGlobeIndicatorStyle'],
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
    // 靜態指示器：上方「中」（模式 1）
    shiftButtonTopChineseIndicatorStyle: {
      buttonStyleType: 'text',
      text: '中',
      fontSize: fontSize['英文上划文字大小'],
      normalColor: color[theme]['英文上滑提示文字顏色'],
      center: { x: 0.5, y: 0.2 },
    },
    // 靜態指示器：下方「地球」（模式 1 和 2 都有）
    shiftButtonBottomGlobeIndicatorStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'globe',
      fontSize: fontSize['英文下划文字大小'],
      normalColor: color[theme]['英文下滑提示文字顏色'],
      center: { x: 0.5, y: 0.8 },
    },

    zButton: createButton({ key: 'z', size: ButtonSize['普通键size'] }),
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
      notification: ['preeditChangedForBackspaceButtonNotification'],
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
      fontSize: fontSize['英文下划文字大小'],
      normalColor: color[theme]['英文功能键文字颜色'],
      center: { x: 0.5, y: 0.8 },
    },

    // 第四排
    numericButton: createButton({ key: 'numeric', size: ButtonSize['numeric键size'], action: { keyboardType: 'numeric' }, isLetter: false }) + {
      swipeDownAction: if settings.keyboardLayout == 'row' then { keyboardType: 'numeric_panel' } else { keyboardType: 'numeric' },  // row模式下滑到九宮格，panel模式維持原行為
      hintStyle: null,
      hintSymbolsStyle: 'numericButtonHintSymbolsStyle',
    },
    
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

    commaPeriodHintSymbolsBackgroundStyle: {
      buttonStyleType: 'fileImage',
      normalImage: { file: 'hint', image: 'IMG1' },
      highlightImage: { file: 'hint', image: 'IMG1' },
    },
    commaPeriodHintSymbolsSelectedStyle: {
      buttonStyleType: 'fileImage',
      insets: { left: 4, right: 3, top: 8, bottom: 8 },
      normalImage: { file: 'hint', image: 'IMG2' },
      highlightImage: { file: 'hint', image: 'IMG2' },
    },
    numericButtonHintSymbolsStyle: {
      backgroundStyle: 'commaPeriodHintSymbolsBackgroundStyle',
      selectedBackgroundStyle: 'commaPeriodHintSymbolsSelectedStyle',
      selectedIndex: 0,
      size: { width: 30, height: 53 },
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

    numericButtonForegroundStyle: utils.makeTextStyle({
      text: '123',
      normalColor: color[theme]['英文功能键文字颜色'],
      highlightColor: color[theme]['英文功能键文字颜色'],
      fontSize: fontSize['英文按键前景sf符号大小'],
    }),

    // 逗號鍵：
    // 模式 2：顯示「中」，按下 combine 切回 pinyin + liur
    // 模式 1：直出英文逗號
    commaButton: {
      size: ButtonSize['comma键size'],
      backgroundStyle: 'alphabeticBackgroundStyle',
      foregroundStyle: 'commaButtonForegroundStyle',
      action: if settings.languageSwitchLayout == '2' then {
        combine: [
          { keyboardType: 'pinyin' },
          { switchRimeSchema: 'liur' },
        ],
      } else { symbol: ',' },
      // 無論哪個模式，下滑都跳轉 Kaomojis 鍵盤（與 alphabetic_26 一致）
      [if swipeStyles.getEffectiveSetting(',', 'enableSwipeDownActions') then 'swipeDownAction']: { keyboardType: 'kaomojis' },
      animation: ['ButtonScaleAnimation'],
    },
    commaButtonForegroundStyle: utils.makeTextStyle({
      // 模式 2：顯示「中」；模式 1：顯示「,」
      text: if settings.languageSwitchLayout == '2' then '中' else ',',
      normalColor: color[theme]['英文字母键文字颜色'],
      highlightColor: color[theme]['英文字母键文字颜色'],
      fontSize: if settings.languageSwitchLayout == '2' then fontSize['垂直候选控制按钮字体大小'] else fontSize['按键前景文字大小'],
    }),

    // ★ 空白鍵顯示「Easy English」
    spaceButton: {
      size: ButtonSize['space键size'],
      backgroundStyle: 'spaceButtonBackgroundStyle',
      foregroundStyle: 'spaceButtonForegroundStyle',
      action: 'space',
      animation: ['ButtonScaleAnimation'],
    },
    spaceButtonForegroundStyle: utils.makeTextStyle({
      text: 'Easy English',
      normalColor: color[theme]['英文空白键文字颜色'],
      highlightColor: color[theme]['英文空白键文字颜色'],
      fontSize: fontSize['英文空白键文字大小'],
    }),

    // 句號鍵：
    // 模式 2：顯示「,」直出英文逗號，上滑「.」（空白右側）
    // 模式 1：顯示「.」直出英文句號
    periodButton: {
      size: ButtonSize['period键size'],
      backgroundStyle: 'alphabeticBackgroundStyle',
      foregroundStyle: if settings.languageSwitchLayout == '2' then ['periodButtonForegroundStyle', 'periodButtonSwipeUpIndicatorStyle'] else 'periodButtonForegroundStyle',
      action: if settings.languageSwitchLayout == '2' then { symbol: ',' } else { symbol: '.' },
      [if settings.languageSwitchLayout == '2' then 'swipeUpAction']: { symbol: '.' },
      // 無論哪個模式，下滑都跳轉 Emoji 鍵盤（與 alphabetic_26 一致）
      [if swipeStyles.getEffectiveSetting('.', 'enableSwipeDownActions') then 'swipeDownAction']: { keyboardType: 'emoji' },
      hintStyle: if settings.languageSwitchLayout == '2' then 'periodButtonHintStyle' else null,
      animation: ['ButtonScaleAnimation'],
    },
    periodButtonForegroundStyle: utils.makeTextStyle({
      // 模式 2：顯示「,」；模式 1：顯示「.」
      text: if settings.languageSwitchLayout == '2' then ',' else '.',
      normalColor: color[theme]['英文字母键文字颜色'],
      highlightColor: color[theme]['英文字母键文字颜色'],
      fontSize: fontSize['按键前景文字大小'],
    }),
    periodButtonSwipeUpIndicatorStyle: {
      buttonStyleType: 'text',
      text: '.',
      fontSize: fontSize['英文上划文字大小'],
      normalColor: color[theme]['英文上滑提示文字顏色'],
      center: { x: 0.5, y: 0.2 },
    },
    periodButtonHintStyle: {
      backgroundStyle: 'commaPeriodHintBackgroundStyle',
      foregroundStyle: 'periodButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'periodButtonSwipeUpHintForegroundStyle',
    },
    periodButtonHintForegroundStyle: utils.makeTextStyle({
      text: ',',
      normalColor: color[theme]['英文按下气泡文字颜色'],
      highlightColor: color[theme]['按下气泡文字顏色'],
      fontSize: fontSize['长按气泡文字大小'],
    }),
    periodButtonSwipeUpHintForegroundStyle: {
      buttonStyleType: 'text',
      text: '.',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['划动气泡文字顏色'],
      center: { x: 0.5, y: 0.45 },
    },
    commaPeriodHintBackgroundStyle: {
      buttonStyleType: 'fileImage',
      contentMode: 'scaleAspectFit',
      insets: { left: -10, right: -10, top: -10, bottom: -10 },
      normalImage: { file: 'hint', image: 'IMG3' },
      highlightImage: { file: 'hint', image: 'IMG3' },
    },

    // Enter 鍵
    enterButton: createButton({ key: 'enter', action: 'enter', isLetter: false }) + {
      backgroundStyle: 'enterButtonBackgroundStyle',
      foregroundStyle: 'enterButtonForegroundStyle',
      notification: ['returnKeyTypeChangedNotification', 'preeditChangedForEnterButtonNotification'],
      hintStyle: null,
      hintSymbolsStyle: 'numericButtonHintSymbolsStyle',  // 不顯示按下氣泡（與 Shift 鍵一致）
      [if swipeStyles.getEffectiveSetting('enter', 'enableSwipeUpActions') then 'swipeUpAction']: { combine: [{ keyboardType: 'bopomofo' }, { sendKeys: "';" }] },  // 上滑跳轉到注音鍵盤並觸發注音模式
      [if swipeStyles.getEffectiveSetting('enter', 'enableSwipeDownActions') then 'swipeDownAction']: { shortcut: '#换行' },  // 下滑換行
    },
    enterButtonForegroundStyle: utils.makeTextStyle({
      text: '$returnKeyType',
      normalColor: color[theme]['英文enter键文字颜色'],
      highlightColor: color[theme]['英文enter键文字颜色'],
      fontSize: fontSize['英文enter键字体大小'],
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
    alphabeticHintBackgroundStyle: {
      buttonStyleType: 'fileImage',
      contentMode: 'scaleAspectFit',
      insets: { left: -3, right: -3, top: -3, bottom: -3 },
      center: { y: 0.68 },
      normalImage: { file: 'hint', image: 'IMG3' },
      highlightImage: { file: 'hint', image: 'IMG3' },
    },
    // d 鍵長按樣式覆蓋（5個選項：計算、d、D、ḋ、Ḋ）
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
    dButtonHintSymbolsSelectedStyle: {
      buttonStyleType: 'fileImage',
      insets: { left: 6, right: 6, top: -3, bottom: -3 },
      normalImage: { file: 'hint', image: 'IMG2' },
      highlightImage: { file: 'hint', image: 'IMG2' },
    },
    alphabeticHintSymbolsBackgroundStyle: {
      buttonStyleType: 'fileImage',
      insets: { bottom: -10, left: 3, right: 3, top: -10 },
      normalImage: { file: 'hint', image: 'IMG1' },
      highlightImage: { file: 'hint', image: 'IMG1' },
    },
    alphabeticHintSymbolsSelectedStyle: {
      buttonStyleType: 'fileImage',
      insets: { left: 6, right: 6, top: -3, bottom: -3 },
      normalImage: { file: 'hint', image: 'IMG2' },
      highlightImage: { file: 'hint', image: 'IMG2' },
    },

    ButtonScaleAnimation: animation['26键按键动画'],

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
      fontSize: fontSize['英文enter键字体大小'],
    }),
    preeditChangedForEnterButtonNotification: {
      notificationType: 'preeditChanged',
      backgroundStyle: 'enterButtonBackgroundStyle',
      foregroundStyle: 'enterButtonForegroundStyle',
    },
    preeditChangedForBackspaceButtonNotification: {
      notificationType: 'preeditChanged',
      preeditIsEmpty: false,
      backgroundStyle: 'systemButtonBackgroundStyle',
      foregroundStyle: ['backspaceButtonForegroundStyle', 'backspaceButtonDownForegroundStyle'],
      swipeDownAction: { sendKeys: 'Control+k' },
    },

    keyboardBackgroundStyle: {
      buttonStyleType: 'geometry',
      normalColor: color[theme]['英文键盘背景颜色'],
    },
    keyboardStyle: {
      backgroundStyle: 'keyboardBackgroundStyle',
    },
  }
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
    toolbar.getToolBar(theme, orientation, 'keyboard26Alphabetic', skinName) +
    utils.genAlphabeticStyles(theme) +
    utils.genHintStyles(theme) +
    keyboard(theme, orientation),
}
