// 中文鍵盤（pinyin）- 蝦米專用
// 使用 rime$is_easy_en option 來監聽方案切換（支援方案選擇器）
local animation = import '../lib/animation.libsonnet';
local center = import '../lib/center.libsonnet';
local color = import '../lib/color.libsonnet';
local fontSize = import '../lib/fontSize.libsonnet';
local hintSymbolsData = import '../lib/hintSymbolsData.libsonnet';
local hintSymbolsStyles = import '../lib/hintSymbolsStyles.libsonnet';
local keyboardLayout = import '../lib/keyboardLayout.libsonnet';
local others = import '../lib/others.libsonnet';
local settings = import '../Settings.libsonnet';
local swipeData = import '../lib/swipeData.libsonnet';
local swipeStyles = import '../lib/swipeStyles.libsonnet';
local toolbar = import '../lib/toolbar.libsonnet';
local utils = import '../lib/utils.libsonnet';

local swipe_up = std.get(swipeData, 'swipe_up', {});
local swipe_down = std.get(swipeData, 'swipe_down', {});

// 創建字母按鍵（使用 rime$is_easy_en 條件樣式）
local createButton(theme, params={}) =
  local isLetter = std.get(params, 'isLetter', true);
  local key = params.key;
  local swipeStyleNames = std.prune([
    if std.objectHas(swipe_up, key) && swipeStyles.getEffectiveSetting(key, 'showSwipeUpText') then key + 'ButtonUpForegroundStyle' else null,
    if std.objectHas(swipe_down, key) && swipeStyles.getEffectiveSetting(key, 'showSwipeDownText') then key + 'ButtonDownForegroundStyle' else null,
  ]);
  local hintSymbolsData_pinyin = std.get(hintSymbolsData, 'pinyin', {});
  std.prune({
    size: std.get(params, 'size'),
    bounds: std.get(params, 'bounds'),
    backgroundStyle: if isLetter then 'alphabeticBackgroundStyle' else std.get(params, 'backgroundStyle', 'systemButtonBackgroundStyle'),
    // 使用條件樣式：根據 is_easy_en option 顯示大寫或小寫
    foregroundStyle:
      if isLetter then
        [
          // is_easy_en = false（蝦米方案）：顯示大寫
          {
            styleName: [key + 'SchemaLiurForegroundStyle'] + swipeStyleNames,
            conditionKey: 'rime$is_easy_en',
            conditionValue: false,
          },
          // is_easy_en = true（Easy English 方案）：顯示小寫
          {
            styleName: [key + 'SchemaEasyEnForegroundStyle'] + swipeStyleNames,
            conditionKey: 'rime$is_easy_en',
            conditionValue: true,
          },
        ]
      else
        std.get(params, 'foregroundStyle', key + 'ButtonForegroundStyle'),
    // 使用 optionChanged notification 監聽 is_easy_en 變化
    [if isLetter then 'notification']: [
      key + 'IsEasyEnTrueNotification',
      key + 'IsEasyEnFalseNotification',
    ],
    [if isLetter then 'uppercasedStateForegroundStyle']: [key + 'ButtonUppercasedStateForegroundStyle'] + swipeStyleNames,
    [if isLetter then 'capsLockedStateForegroundStyle']: self.uppercasedStateForegroundStyle,
    hintStyle: key + 'ButtonHintStyle',
    // 添加長按符號樣式（如果該按鍵有長按數據且啟用長按功能）
    [if isLetter && std.objectHas(hintSymbolsData_pinyin, key) && swipeStyles.getEffectiveSetting(key, 'enableLongPressActions') then 'hintSymbolsStyle']: key + 'ButtonHintSymbolsStyle',
    action: std.get(params, 'action', { character: key }),
    [if isLetter then 'uppercasedStateAction']: { character: std.asciiUpper(key) },
    repeatAction: std.get(params, 'repeatAction'),
    [if std.objectHas(swipe_up, key) && swipeStyles.getEffectiveSetting(key, 'enableSwipeUpActions') then 'swipeUpAction']: swipe_up[key].action,
    [if std.objectHas(swipe_down, key) && swipeStyles.getEffectiveSetting(key, 'enableSwipeDownActions') then 'swipeDownAction']: swipe_down[key].action,
    animation: ['ButtonScaleAnimation'],
  });

// 創建方案切換樣式和 optionChanged notifications
local createSchemaStyles(theme, key, bounds=null) =
  local swipeStyleNames = std.prune([
    if std.objectHas(swipe_up, key) && swipeStyles.getEffectiveSetting(key, 'showSwipeUpText') then key + 'ButtonUpForegroundStyle' else null,
    if std.objectHas(swipe_down, key) && swipeStyles.getEffectiveSetting(key, 'showSwipeDownText') then key + 'ButtonDownForegroundStyle' else null,
  ]);
  {
    // 大寫字母樣式（liur 方案）
    [key + 'SchemaLiurForegroundStyle']: utils.makeTextStyle({
      text: std.asciiUpper(key),
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'],
    }),
    // 小寫字母樣式（easy_en 方案）
    [key + 'SchemaEasyEnForegroundStyle']: utils.makeTextStyle({
      text: key,
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'],
    }),
    // 大寫字母樣式（shift/caps lock 狀態）
    [key + 'ButtonUppercasedStateForegroundStyle']: utils.makeTextStyle({
      text: std.asciiUpper(key),
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'],
    }),
    // optionChanged notification：監聽 is_easy_en = true（切換到 Easy English）
    [key + 'IsEasyEnTrueNotification']: {
      notificationType: 'rime',
      rimeNotificationType: 'optionChanged',
      rimeOptionName: 'is_easy_en',
      rimeOptionValue: true,
      backgroundStyle: 'alphabeticBackgroundStyle',
      foregroundStyle: [key + 'SchemaEasyEnForegroundStyle'] + swipeStyleNames,
      [if bounds != null then 'bounds']: bounds,
    },
    // optionChanged notification：監聯 is_easy_en = false（切換到蝦米）
    [key + 'IsEasyEnFalseNotification']: {
      notificationType: 'rime',
      rimeNotificationType: 'optionChanged',
      rimeOptionName: 'is_easy_en',
      rimeOptionValue: false,
      backgroundStyle: 'alphabeticBackgroundStyle',
      foregroundStyle: [key + 'SchemaLiurForegroundStyle'] + swipeStyleNames,
      [if bounds != null then 'bounds']: bounds,
    },
  };

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
    qButton: createButton(theme, { key: 'q', size: ButtonSize['普通键size'] }),
    wButton: createButton(theme, { key: 'w', size: ButtonSize['普通键size'] }),
    eButton: createButton(theme, { key: 'e', size: ButtonSize['普通键size'] }),
    rButton: createButton(theme, { key: 'r', size: ButtonSize['普通键size'] }),
    tButton: createButton(theme, { key: 't', size: ButtonSize['t键size'], bounds: ButtonSize['t键bounds'] }),
    yButton: createButton(theme, { key: 'y', size: ButtonSize['y键size'], bounds: ButtonSize['y键bounds'] }),
    uButton: createButton(theme, { key: 'u', size: ButtonSize['普通键size'] }),
    iButton: createButton(theme, { key: 'i', size: ButtonSize['普通键size'] }),
    oButton: createButton(theme, { key: 'o', size: ButtonSize['普通键size'] }),
    pButton: createButton(theme, { key: 'p', size: ButtonSize['普通键size'] }),
    aButton: createButton(theme, { key: 'a', size: ButtonSize['a键size'], bounds: ButtonSize['a键bounds'] }),
    sButton: createButton(theme, { key: 's', size: ButtonSize['普通键size'] }),
    dButton: createButton(theme, { key: 'd', size: ButtonSize['普通键size'] }),
    fButton: createButton(theme, { key: 'f', size: ButtonSize['普通键size'] }),
    gButton: createButton(theme, { key: 'g', size: ButtonSize['普通键size'] }),
    hButton: createButton(theme, { key: 'h', size: ButtonSize['普通键size'] }),
    jButton: createButton(theme, { key: 'j', size: ButtonSize['普通键size'] }),
    kButton: createButton(theme, { key: 'k', size: ButtonSize['普通键size'] }),
    lButton: createButton(theme, { key: 'l', size: ButtonSize['l键size'], bounds: ButtonSize['l键bounds'] }),
    shiftButton: createButton(theme, { key: 'shift', action: if settings.languageSwitchLayout == '2' then (
        if settings.englishKeyboardMode == '2' then {
          combine: [
            { keyboardType: 'easy_en' },
            { switchRimeSchema: 'easy_en' },
          ],
        } else { keyboardType: 'alphabetic' }
      ) else 'shift', size: ButtonSize['shift键size'], bounds: ButtonSize['shift键bounds'], isLetter: false }) + {
      [if settings.languageSwitchLayout != '2' then 'uppercasedStateAction']: 'shift',
      [if settings.languageSwitchLayout != '2' then 'capsLockedStateForegroundStyle']: if settings.languageSwitchLayout == '1' then 
        ['shiftButtonCapsLockedForegroundStyle', 'shiftButtonTopEnglishIndicatorStyle', 'shiftButtonBottomGlobeIndicatorStyle']
        else 'shiftButtonCapsLockedForegroundStyle',
      [if settings.languageSwitchLayout != '2' then 'uppercasedStateForegroundStyle']: if settings.languageSwitchLayout == '1' then 
        ['shiftButtonUppercasedForegroundStyle', 'shiftButtonTopEnglishIndicatorStyle', 'shiftButtonBottomGlobeIndicatorStyle']
        else 'shiftButtonUppercasedForegroundStyle',
      // shift 上滑切換英文：依 englishKeyboardMode 決定目標鍵盤和方案
      [if settings.languageSwitchLayout != '2' then 'swipeUpAction']:
        if settings.englishKeyboardMode == '2' then {
          combine: [
            { keyboardType: 'easy_en' },
            { switchRimeSchema: 'easy_en' },
          ],
        } else { keyboardType: 'alphabetic' },
      swipeDownAction: 'nextKeyboard',  // 下滑切換下一個鍵盤
      // 模式 2：不顯示氣泡（無上下滑氣泡）；模式 1：也不顯示氣泡
      hintStyle: null,
      // 模式 2：顯示「英」字 + 下方地球靜態指示器；模式 1：依設定顯示
      foregroundStyle: if settings.languageSwitchLayout == '2' then 
        ['shiftButtonForegroundStyle', 'shiftButtonBottomGlobeIndicatorStyle']
        else if settings.languageSwitchLayout == '1' then 
        ['shiftButtonForegroundStyle', 'shiftButtonTopEnglishIndicatorStyle', 'shiftButtonBottomGlobeIndicatorStyle']
        else 'shiftButtonForegroundStyle',
    },
    shiftButtonForegroundStyle: if settings.languageSwitchLayout == '2' then 
      utils.makeTextStyle({
        text: '英',
        normalColor: color[theme]['系统功能键文字顏色'],
        highlightColor: color[theme]['系统功能键文字顏色'],
        fontSize: fontSize['垂直候选控制按钮字体大小'],
      })
    else
      utils.makeSystemImageStyle({
        systemImageName: 'shift',
        normalColor: color[theme]['系统功能键文字顏色'],
        highlightColor: color[theme]['系统功能键文字顏色'],
        fontSize: fontSize['按键前景sf符号大小'],
      }),
    // 中文鍵盤 Shift 氣泡樣式
    shiftButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'shiftButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'shiftButtonSwipeUpHintForegroundStyle',
      swipeDownForegroundStyle: 'shiftButtonSwipeDownHintForegroundStyle',
    },
    shiftButtonHintForegroundStyle: utils.makeSystemImageStyle({
      systemImageName: 'shift',
      normalColor: color[theme]['英文按下气泡文字颜色'],
      highlightColor: color[theme]['按下气泡文字顏色'],
      fontSize: fontSize['划动气泡前景文字大小'],
      center: { x: 0.5, y: 0.63 },
    }),
    shiftButtonSwipeUpHintForegroundStyle: utils.makeTextStyle({
      text: '英',
      normalColor: color[theme]['系统功能键文字顏色'],
      highlightColor: color[theme]['系统功能键文字顏色'],
      fontSize: fontSize['划动气泡前景文字大小'],
      center: { x: 0.5, y: 0.63 },
    }),
    shiftButtonSwipeDownHintForegroundStyle: utils.makeSystemImageStyle({
      systemImageName: 'globe',
      normalColor: color[theme]['系统功能键文字顏色'],
      highlightColor: color[theme]['系统功能键文字顏色'],
      fontSize: fontSize['划动气泡前景文字大小'],
      center: { x: 0.5, y: 0.63 },
    }),
    shiftButtonUppercasedForegroundStyle: utils.makeSystemImageStyle({
      systemImageName: 'shift.fill',
      normalColor: color[theme]['系统功能键文字顏色'],
      highlightColor: color[theme]['系统功能键文字顏色'],
      fontSize: fontSize['按键前景sf符号大小'],
    }),
    shiftButtonCapsLockedForegroundStyle: utils.makeSystemImageStyle({
      systemImageName: 'capslock.fill',
      normalColor: color[theme]['系统功能键文字顏色'],
      highlightColor: color[theme]['系统功能键文字顏色'],
      fontSize: fontSize['按键前景sf符号大小'],
    }),
    // 靜態指示器：上方「英」
    shiftButtonTopEnglishIndicatorStyle: {
      buttonStyleType: 'text',
      text: '英',
      fontSize: fontSize['上划文字大小'],
      normalColor: color[theme]['系统功能键文字顏色'],
      center: { x: 0.5, y: 0.2 },
    },
    // 靜態指示器：下方「地球」
    shiftButtonBottomGlobeIndicatorStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'globe',
      fontSize: fontSize['下划文字大小'],
      normalColor: color[theme]['系统功能键文字顏色'],
      center: { x: 0.5, y: 0.8 },
    },
    // z 鍵：橫屏時移除上滑切換單手鍵盤功能和圖示
    zButton: if orientation == 'landscape' then
      {
        size: ButtonSize['普通键size'],
        backgroundStyle: 'alphabeticBackgroundStyle',
        // 橫屏時不顯示上滑圖示，只顯示下滑圖示
        foregroundStyle: [
          {
            styleName: ['zSchemaLiurForegroundStyle', 'zButtonDownForegroundStyle'],
            conditionKey: 'rime$is_easy_en',
            conditionValue: false,
          },
          {
            styleName: ['zSchemaEasyEnForegroundStyle', 'zButtonDownForegroundStyle'],
            conditionKey: 'rime$is_easy_en',
            conditionValue: true,
          },
        ],
        notification: ['zIsEasyEnTrueNotification', 'zIsEasyEnFalseNotification'],
        uppercasedStateForegroundStyle: ['zButtonUppercasedStateForegroundStyle', 'zButtonDownForegroundStyle'],
        capsLockedStateForegroundStyle: self.uppercasedStateForegroundStyle,
        // 橫屏時使用不含上滑的 hintStyle
        hintStyle: 'zButtonHintStyleLandscape',
        // 橫屏時使用不含「左手模式」的長按樣式
        hintSymbolsStyle: 'zButtonHintSymbolsStyleLandscape',
        action: { character: 'z' },
        uppercasedStateAction: { character: "Z" },
        // 橫屏時只保留下滑，移除上滑
        swipeDownAction: swipe_down['z'].action,
        animation: ['ButtonScaleAnimation'],
      }
    else
      createButton(theme, { key: 'z', size: ButtonSize['普通键size'] }),
    // 橫屏 z 鍵的 hintStyle（不含上滑）
    zButtonHintStyleLandscape: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'zButtonHintForegroundStyle',
      // 滑動氣泡樣式總是包含，不受按鈕文字設定影響
      [if std.objectHas(swipe_down, 'z') then 'swipeDownForegroundStyle']: 'zButtonSwipeDownHintForegroundStyle',
      // 不包含 swipeUpForegroundStyle
    },
    // 橫屏 z 鍵長按樣式（不含「左手模式」）
    zButtonHintSymbolsStyleLandscape: {
      backgroundStyle: 'alphabeticHintSymbolsBackgroundStyle',
      selectedBackgroundStyle: 'alphabeticHintSymbolsSelectedStyle',
      selectedIndex: 0,
      insets: { left: 8, right: 8, top: 3, bottom: 3 },
      size: { width: 38, height: 25 },  // 與其他長按氣泡一致
      symbolStyles: [
        'zButtonHintSymbolsStyleLandscapeOf0',
        'zButtonHintSymbolsStyleLandscapeOf1',
        'zButtonHintSymbolsStyleLandscapeOf2',
      ],
    },
    zButtonHintSymbolsStyleLandscapeOf0: {
      action: { sendKeys: '``Z' },
      foregroundStyle: 'zButtonHintSymbolsForegroundStyleLandscapeOf0',
    },
    zButtonHintSymbolsForegroundStyleLandscapeOf0: {
      buttonStyleType: 'text',
      text: 'Z',
      fontSize: fontSize['长按气泡文字大小'],
      normalColor: color[theme]['长按非选中字体顏色'],
      highlightColor: color[theme]['长按选中字体顏色'],
      center: { x: 0.5, y: 0.48 },
    },
    zButtonHintSymbolsStyleLandscapeOf1: {
      action: { shortcut: '#行首' },
      foregroundStyle: 'zButtonHintSymbolsForegroundStyleLandscapeOf1',
    },
    zButtonHintSymbolsForegroundStyleLandscapeOf1: {
      buttonStyleType: 'text',
      text: '句首',
      fontSize: 14,
      normalColor: color[theme]['长按非选中字体顏色'],
      highlightColor: color[theme]['长按选中字体顏色'],
      center: { x: 0.5, y: 0.48 },
    },
    zButtonHintSymbolsStyleLandscapeOf2: {
      action: { sendKeys: '``z' },
      foregroundStyle: 'zButtonHintSymbolsForegroundStyleLandscapeOf2',
    },
    zButtonHintSymbolsForegroundStyleLandscapeOf2: {
      buttonStyleType: 'text',
      text: 'z',
      fontSize: fontSize['长按气泡文字大小'],
      normalColor: color[theme]['长按非选中字体顏色'],
      highlightColor: color[theme]['长按选中字体顏色'],
      center: { x: 0.5, y: 0.48 },
    },
    xButton: createButton(theme, { key: 'x', size: ButtonSize['普通键size'] }),
    cButton: createButton(theme, { key: 'c', size: ButtonSize['普通键size'] }),
    vButton: createButton(theme, { key: 'v', size: ButtonSize['普通键size'] }),
    bButton: createButton(theme, { key: 'b', size: ButtonSize['普通键size'] }),
    nButton: createButton(theme, { key: 'n', size: ButtonSize['普通键size'] }),
    mButton: createButton(theme, { key: 'm', size: ButtonSize['普通键size'] }),
    backspaceButton: {
      size: ButtonSize['backspace键size'],
      bounds: ButtonSize['backspace键bounds'],
      backgroundStyle: 'systemButtonBackgroundStyle',
      foregroundStyle: ['backspaceButtonForegroundStyle', 'backspaceButtonDownForegroundStyle'],
      action: 'backspace',
      repeatAction: 'backspace',
      swipeUpAction: { shortcut: '#deleteText' },
      swipeDownAction: { shortcut: '#undo' },
      // 動態功能：當有預編輯文字時，下滑執行 Control+k
      notification: ['preeditChangedForBackspaceButtonNotification'],
      animation: ['ButtonScaleAnimation'],
    },
    backspaceButtonForegroundStyle: utils.makeSystemImageStyle({
      systemImageName: 'delete.left',
      normalColor: color[theme]['系统功能键文字顏色'],
      highlightColor: color[theme]['系统功能键文字顏色'],
      fontSize: fontSize['按键前景sf符号大小'],
    }),
    backspaceButtonDownForegroundStyle: {
      buttonStyleType: 'text',
      text: 'undo',
      fontSize: fontSize['下划文字大小'],
      normalColor: color[theme]['系统功能键文字顏色'],
      center: { x: 0.5, y: 0.8 },
    },
    numericButton: createButton(theme, { key: 'numeric', size: ButtonSize['numeric键size'], action: { keyboardType: 'numeric' }, isLetter: false }) + {
      swipeUpAction: { keyboardType: 'symbolic' },
      swipeDownAction: if settings.keyboardLayout == 'row' then { keyboardType: 'numeric_panel' } else { keyboardType: 'numeric' },  // row模式下滑到九宮格，panel模式維持原行為
      hintStyle: null,
      hintSymbolsStyle: 'numericButtonHintSymbolsStyle',
          // 動態功能：當有預編輯文字時，顯示「同音」並執行同音字功能
      notification: ['preeditChangedForNumericButtonNotification'],
    },
    numericButtonForegroundStyle: utils.makeTextStyle({
      text: '123',
      normalColor: color[theme]['系统功能键文字顏色'],
      highlightColor: color[theme]['系统功能键文字顏色'],
      fontSize: fontSize['按键前景sf符号大小']  // 使用 systemSize,
    }),
    numericButtonHintSymbolsStyleOf0: {
      action: { symbol: '+' },
      foregroundStyle: 'numericButtonHintSymbolsForegroundStyleOf0',
    },
    numericButtonHintSymbolsForegroundStyleOf0: {
      buttonStyleType: 'text',
      text: '+',
      fontSize: 14,
      normalColor: color[theme]['长按非选中字体顏色'],
      highlightColor: color[theme]['长按选中字体顏色'],
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
      normalColor: color[theme]['长按非选中字体顏色'],
      highlightColor: color[theme]['长按选中字体顏色'],
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
      normalColor: color[theme]['长按非选中字体顏色'],
      highlightColor: color[theme]['长按选中字体顏色'],
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
      normalColor: color[theme]['长按非选中字体顏色'],
      highlightColor: color[theme]['长按选中字体顏色'],
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
      normalColor: color[theme]['长按非选中字体顏色'],
      highlightColor: color[theme]['长按选中字体顏色'],
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
      normalColor: color[theme]['长按非选中字体顏色'],
      highlightColor: color[theme]['长按选中字体顏色'],
      center: { x: 0.5, y: 0.48 },
    },
    commaButton: {
      size: ButtonSize['comma键size'],
      backgroundStyle: 'alphabeticBackgroundStyle',
      foregroundStyle: 'commaButtonForegroundStyle',
      action: { character: ',' },
      [if swipeStyles.getEffectiveSetting(',', 'enableSwipeUpActions') then 'swipeUpAction']: { symbol: ',' },
      [if swipeStyles.getEffectiveSetting(',', 'enableSwipeDownActions') then 'swipeDownAction']: { keyboardType: 'kaomojis' },  // 下滑跳轉 Kaomojis 鍵盤
      hintStyle: 'commaButtonHintStyle',
      [if swipeStyles.getEffectiveSetting(',', 'enableLongPressActions') then 'hintSymbolsStyle']: 'commaButtonHintSymbolsStyle',
      animation: ['ButtonScaleAnimation'],
    },
    commaButtonForegroundStyle: utils.makeTextStyle({
      text: ',',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'],
    }),
    commaButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'commaButtonHintForegroundStyle',
      [if swipeStyles.getEffectiveSetting(',', 'enableSwipeUpActions') then 'swipeUpForegroundStyle']: 'commaButtonSwipeUpHintForegroundStyle',
    },
    commaButtonHintForegroundStyle: utils.makeTextStyle({
      text: ',',
      normalColor: color[theme]['按下气泡文字顏色'],
      highlightColor: color[theme]['按下气泡文字顏色'],
      fontSize: fontSize['长按气泡文字大小'],
    }),
    [if swipeStyles.getEffectiveSetting(',', 'enableSwipeUpActions') then 'commaButtonSwipeUpHintForegroundStyle']: {
      buttonStyleType: 'text',
      text: ',',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['划动气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },

    // 空白鍵（使用條件樣式根據方案顯示不同文字）
    spaceButton: {
      size: ButtonSize['space键size'],
      backgroundStyle: 'spaceButtonBackgroundStyle',
      foregroundStyle: [
        // is_easy_en = false（蝦米方案）
        {
          styleName: 'spaceButtonLiurForegroundStyle',
          conditionKey: 'rime$is_easy_en',
          conditionValue: false,
        },
        // is_easy_en = true（Easy English 方案）
        {
          styleName: 'spaceButtonEasyEnForegroundStyle',
          conditionKey: 'rime$is_easy_en',
          conditionValue: true,
        },
      ],
      action: 'space',
      // 上滑切換擴充字集
      [if swipeStyles.getEffectiveSetting('space', 'enableSwipeUpActions') then 'swipeUpAction']: swipe_up['space'].action,
      // 長按功能已移除（easy_en 整合後不需要方案選擇器）
      notification: [
        'spaceIsEasyEnTrueNotification',
        'spaceIsEasyEnFalseNotification',
        'spaceLiurSchemaChangedNotification',
        'spaceEasyEnSchemaChangedNotification',
      ],
      animation: ['ButtonScaleAnimation'],
    },
    spaceButtonLiurForegroundStyle: utils.makeTextStyle({
      text: '蝦米輸入法',
      normalColor: color[theme]['空白键文字颜色'],  // 使用空白鍵專用文字色
      highlightColor: color[theme]['空白键文字颜色'],  // 使用空白鍵專用文字色
      fontSize: fontSize['英文空白键文字大小'],  // 使用 Layer 3 可覆蓋的字號
    }),
    spaceButtonEasyEnForegroundStyle: utils.makeTextStyle({
      text: 'Easy English',
      normalColor: color[theme]['空白键文字颜色'],  // 使用空白鍵專用文字色
      highlightColor: color[theme]['空白键文字颜色'],  // 使用空白鍵專用文字色
      fontSize: fontSize['英文空白键文字大小'],  // 使用 Layer 3 可覆蓋的字號
    }),
    // optionChanged notification：監聽 is_easy_en = true
    spaceIsEasyEnTrueNotification: {
      notificationType: 'rime',
      rimeNotificationType: 'optionChanged',
      rimeOptionName: 'is_easy_en',
      rimeOptionValue: true,
      backgroundStyle: 'spaceButtonBackgroundStyle',
      foregroundStyle: 'spaceButtonEasyEnForegroundStyle',
    },
    // optionChanged notification：監聽 is_easy_en = false
    spaceIsEasyEnFalseNotification: {
      notificationType: 'rime',
      rimeNotificationType: 'optionChanged',
      rimeOptionName: 'is_easy_en',
      rimeOptionValue: false,
      backgroundStyle: 'spaceButtonBackgroundStyle',
      foregroundStyle: 'spaceButtonLiurForegroundStyle',
    },
    // schemaChanged notification：監聽蝦米輸入法方案切換
    spaceLiurSchemaChangedNotification: {
      notificationType: 'rime',
      rimeNotificationType: 'schemaChanged',
      rimeSchemaID: 'liur',
      // rimeSchemaName: '蝦米輸入法',  // 開發者說這個還未發布，先註解
      backgroundStyle: 'spaceButtonBackgroundStyle',
      foregroundStyle: 'spaceButtonLiurForegroundStyle',
    },
    // schemaChanged notification：監聽 Easy English 方案切換
    spaceEasyEnSchemaChangedNotification: {
      notificationType: 'rime',
      rimeNotificationType: 'schemaChanged',
      rimeSchemaID: 'easy_en',
      // rimeSchemaName: 'Easy English',  // 開發者說這個還未發布，先註解
      backgroundStyle: 'spaceButtonBackgroundStyle',
      foregroundStyle: 'spaceButtonEasyEnForegroundStyle',
    },
    spaceButtonHintSymbolsStyleOf0: {
      action: { shortcutCommand: '#方案切换' },
      foregroundStyle: 'spaceButtonHintSymbolsForegroundStyleOf0',
    },
    spaceButtonHintSymbolsForegroundStyleOf0: {
      buttonStyleType: 'text',
      text: '切換',
      fontSize: 14,
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: '#FFFFFF',
      center: { x: 0.5, y: 0.48 },
    },
    periodButton: {
      size: ButtonSize['period键size'],
      backgroundStyle: 'alphabeticBackgroundStyle',
      foregroundStyle: 'periodButtonForegroundStyle',
      action: { character: '.' },
      [if swipeStyles.getEffectiveSetting('.', 'enableSwipeUpActions') then 'swipeUpAction']: { symbol: '.' },
      [if swipeStyles.getEffectiveSetting('.', 'enableSwipeDownActions') then 'swipeDownAction']: { keyboardType: 'emoji' },  // 下滑跳轉 Emoji 鍵盤
      hintStyle: 'periodButtonHintStyle',
      [if swipeStyles.getEffectiveSetting('.', 'enableLongPressActions') then 'hintSymbolsStyle']: 'periodButtonHintSymbolsStyle',
      animation: ['ButtonScaleAnimation'],
    },
    periodButtonForegroundStyle: utils.makeTextStyle({
      text: '.',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'],
    }),
    periodButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'periodButtonHintForegroundStyle',
      [if swipeStyles.getEffectiveSetting('.', 'enableSwipeUpActions') then 'swipeUpForegroundStyle']: 'periodButtonSwipeUpHintForegroundStyle',
    },
    periodButtonHintForegroundStyle: utils.makeTextStyle({
      text: '.',
      normalColor: color[theme]['按下气泡文字顏色'],
      highlightColor: color[theme]['按下气泡文字顏色'],
      fontSize: fontSize['长按气泡文字大小'],
    }),
    [if swipeStyles.getEffectiveSetting('.', 'enableSwipeUpActions') then 'periodButtonSwipeUpHintForegroundStyle']: {
      buttonStyleType: 'text',
      text: '.',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['划动气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    enterButton: createButton(theme, { key: 'enter', action: 'enter', isLetter: false }) + {
      backgroundStyle: 'enterButtonBackgroundStyle',
      foregroundStyle: 'enterButtonForegroundStyle',
      notification: ['returnKeyTypeChangedNotification', 'preeditChangedForEnterButtonNotification'],
      hintStyle: null,  // 不顯示按下氣泡（與 Shift 鍵一致）
      [if swipeStyles.getEffectiveSetting('enter', 'enableSwipeUpActions') then 'swipeUpAction']: { combine: [{ keyboardType: 'bopomofo' }, { sendKeys: "';" }] },  // 上滑跳轉到注音鍵盤並觸發注音模式
      [if swipeStyles.getEffectiveSetting('enter', 'enableSwipeDownActions') then 'swipeDownAction']: { shortcut: '#换行' },  // 下滑換行
    },
    enterButtonForegroundStyle: utils.makeTextStyle({
      text: '$returnKeyType',
      normalColor: color[theme]['enter键文字颜色'],
      highlightColor: color[theme]['enter键文字颜色'],
      fontSize: fontSize['按键前景sf符号大小']  // 使用 systemSize,
    }),
    
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
      normalColor: color[theme]['字母键背景颜色-普通'],
      highlightColor: color[theme]['字母键背景颜色-高亮'],
      cornerRadius: 8.5,
      normalLowerEdgeColor: color[theme]['底边缘顏色-普通'],
      highlightLowerEdgeColor: color[theme]['底边缘顏色-高亮'],
      borderSize: color[theme]['边框宽度'],
      normalBorderColor: color[theme]['边框颜色-普通'],
      highlightBorderColor: color[theme]['边框颜色-高亮'],
    }),
    systemButtonBackgroundStyle: utils.makeGeometryStyle({
      insets: { top: 2, left: 2, bottom: 2, right: 2 },
      normalColor: color[theme]['功能键背景颜色-普通'],
      highlightColor: color[theme]['功能键背景颜色-高亮'],
      cornerRadius: 8.5,
      normalLowerEdgeColor: color[theme]['底边缘顏色-普通'],
      highlightLowerEdgeColor: color[theme]['底边缘顏色-高亮'],
      borderSize: color[theme]['系统功能键边框宽度'],
      normalBorderColor: color[theme]['系统功能键边框顏色-普通'],
      highlightBorderColor: color[theme]['系统功能键边框顏色-高亮'],
    }),
    enterButtonBackgroundStyle: utils.makeGeometryStyle({
      insets: { top: 2, left: 2, bottom: 2, right: 2 },
      normalColor: color[theme]['enter键背景颜色-普通'],
      highlightColor: color[theme]['enter键背景颜色-高亮'],
      cornerRadius: 8.5,
      normalLowerEdgeColor: color[theme]['底边缘顏色-普通'],
      highlightLowerEdgeColor: color[theme]['底边缘顏色-高亮'],
      borderSize: color[theme]['enter键边框宽度'],
      normalBorderColor: color[theme]['enter键边框顏色-普通'],
      highlightBorderColor: color[theme]['enter键边框顏色-高亮'],
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
      selectedIndex: std.get(hintSymbolsData, 'pinyin', {}).comma.selectedIndex,
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
      selectedIndex: std.get(hintSymbolsData, 'pinyin', {}).period.selectedIndex,
    },


    // 123 鍵長按樣式
    numericButtonHintSymbolsStyle: {
      backgroundStyle: 'alphabeticHintSymbolsBackgroundStyle',
      selectedBackgroundStyle: 'alphabeticHintSymbolsSelectedStyle',
      selectedIndex: std.get(hintSymbolsData, 'pinyin', {}).comma.selectedIndex,
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
    // 空白鍵長按樣式
    spaceButtonHintSymbolsStyle: {
      backgroundStyle: 'alphabeticHintSymbolsBackgroundStyle',
      selectedBackgroundStyle: 'alphabeticHintSymbolsSelectedStyle',
      selectedIndex: std.get(hintSymbolsData, 'alphabetic', {}).comma.selectedIndex,
      size: { width: 38, height: 25 },
      insets: { left: 8, right: 8, top: 3, bottom: 3 },
      symbolStyles: [
        'spaceButtonHintSymbolsStyleOf0',
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
    ButtonScaleAnimation: animation['26键按键动画'],
    returnKeyTypeChangedNotification: {
      notificationType: 'returnKeyType',
      returnKeyType: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
      backgroundStyle: 'enterButtonBackgroundStyle',
      foregroundStyle: 'returnKeyTypeForegroundStyle',
    },
    returnKeyTypeForegroundStyle: utils.makeTextStyle({
      text: '$returnKeyType',
      normalColor: color[theme]['enter键文字颜色'],
      highlightColor: color[theme]['enter键文字颜色'],
      fontSize: fontSize['按键前景sf符号大小']  // 使用 systemSize,
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
      normalColor: color[theme]['系统功能键文字顏色'],
      highlightColor: color[theme]['系统功能键文字顏色'],
      fontSize: 16,
    }),
    enterCommitCandidateForegroundStyle: utils.makeTextStyle({
      text: '確認',
      normalColor: color[theme]['enter键文字颜色'],
      highlightColor: color[theme]['enter键文字颜色'],
      fontSize: fontSize['按键前景sf符号大小'],
    }),
    preeditChangedForNumericButtonNotification: {
      notificationType: 'preeditChanged',
      preeditIsEmpty: false,
      backgroundStyle: 'systemButtonBackgroundStyle',
      foregroundStyle: 'numericButtonHomophoneForegroundStyle',
      action: { character: "'" },
    },
    numericButtonHomophoneForegroundStyle: utils.makeTextStyle({
      text: '同音',
      normalColor: color[theme]['系统功能键文字顏色'],
      highlightColor: color[theme]['系统功能键文字顏色'],
      fontSize: fontSize['按键前景sf符号大小']  // 使用 systemSize,
    }),
    // backspace 鍵動態功能：當有預編輯文字時，下滑執行 Control+k（視覺上仍顯示 undo）
    preeditChangedForBackspaceButtonNotification: {
      notificationType: 'preeditChanged',
      preeditIsEmpty: false,
      backgroundStyle: 'systemButtonBackgroundStyle',
      foregroundStyle: ['backspaceButtonForegroundStyle', 'backspaceButtonDownForegroundStyle'],
      swipeDownAction: { sendKeys: 'Control+k' },
    },
    
    // 鍵盤背景樣式（支援 Layer 3 獨立背景色）
    keyboardBackgroundStyle: {
      buttonStyleType: 'geometry',
      normalColor: color[theme]['26键键盘背景顏色'],
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
  + createHintStyle('b') + createHintStyle('n') + createHintStyle('m')
  + createSchemaStyles(theme, 'q') + createSchemaStyles(theme, 'w') + createSchemaStyles(theme, 'e') + createSchemaStyles(theme, 'r') + createSchemaStyles(theme, 't')
  + createSchemaStyles(theme, 'y') + createSchemaStyles(theme, 'u') + createSchemaStyles(theme, 'i') + createSchemaStyles(theme, 'o') + createSchemaStyles(theme, 'p')
  + createSchemaStyles(theme, 'a', ButtonSize['a键bounds']) + createSchemaStyles(theme, 's') + createSchemaStyles(theme, 'd') + createSchemaStyles(theme, 'f') + createSchemaStyles(theme, 'g')
  + createSchemaStyles(theme, 'h') + createSchemaStyles(theme, 'j') + createSchemaStyles(theme, 'k') + createSchemaStyles(theme, 'l', ButtonSize['l键bounds'])
  + createSchemaStyles(theme, 'z') + createSchemaStyles(theme, 'x') + createSchemaStyles(theme, 'c') + createSchemaStyles(theme, 'v')
  + createSchemaStyles(theme, 'b') + createSchemaStyles(theme, 'n') + createSchemaStyles(theme, 'm');

{
  new(theme, orientation, skinName='蝦米輸入法'):
    keyboardLayout.getPinyinLayout(theme, orientation) +
    swipeStyles.makeSwipeStyles(theme, { swipe_up: swipe_up, swipe_down: swipe_down, type: 'pinyin', enableSwipeHint: true }) +
    hintSymbolsStyles.getStyle(theme, hintSymbolsData.pinyin) +
    toolbar.getToolBar(theme, orientation, 'keyboard26Chinese', skinName) +  // 工具栏（傳入 keyboardType 和 skinName）
    utils.genPinyinStyles(theme) +
    utils.genHintStyles(theme) +
    keyboard(theme, orientation),
}
