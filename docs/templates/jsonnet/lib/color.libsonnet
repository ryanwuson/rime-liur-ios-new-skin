// 顏色定義 - 支援 3 層繼承架構 (Palette, Groups, Overrides)
local settings = import '../Settings.libsonnet';

// 基礎工具：安全獲取物件屬性，帶預設值
local safeGet(obj, key, default) = if obj != null && std.objectHas(obj, key) then obj[key] else default;

// 核心查找邏輯：通用泛型路徑解析
local resolveOverride(obj, path) =
  std.foldl(
    function(acc, key) if acc != null && std.isObject(acc) && std.objectHas(acc, key) then acc[key] else null,
    path,
    obj
  );

local resolveStatefulOverride(obj, path, state) =
  local base = resolveOverride(obj, path);
  if base != null && std.isObject(base) && std.objectHas(base, state) then base[state]
  else if base != null && std.isString(base) then base
  else null;

local getGenericProperty(path, theme, paletteKey, defaultValue, isStateful=false, state=null) =
  if settings.customColors.enableCustomColors then
    local overrides = settings.customColors.overrides;
    local palette = settings.customColors.palette[theme];
    local overrideValue = if isStateful then resolveStatefulOverride(overrides, path, state) else resolveOverride(overrides, path);
    if overrideValue != null then overrideValue
    else safeGet(palette, paletteKey, defaultValue)
  else
    defaultValue;

// 封裝 12 個原有函數介面，避免修改外層邏輯
local getCascadedColor(keyboardType, groupName, paletteKey, theme, defaultColor, normalOrHighlight='normal') =
  getGenericProperty([keyboardType, groupName, theme, 'background'], theme, paletteKey, defaultColor, true, normalOrHighlight);

local getCascadedTextColor(keyboardType, groupName, paletteKey, theme, defaultColor) =
  getGenericProperty([keyboardType, groupName, theme, 'text'], theme, paletteKey, defaultColor);

local getCascadedSimpleProperty(keyboardType, groupName, propertyName, theme, paletteKey, defaultValue) =
  getGenericProperty([keyboardType, groupName, theme, propertyName], theme, paletteKey, defaultValue);

local getCascadedNestedProperty(keyboardType, groupName, parentProperty, childProperty, theme, paletteKey, defaultValue) =
  getGenericProperty([keyboardType, groupName, theme, parentProperty, childProperty], theme, paletteKey, defaultValue);

local getCascadedShadow(keyboardType, groupName, theme, normalOrHighlight, defaultValue) =
  local paletteKey = if normalOrHighlight == 'highlight' then 'shadowHighlight' else 'shadow';
  getGenericProperty([keyboardType, groupName, theme, 'shadow'], theme, paletteKey, defaultValue, true, normalOrHighlight);

local getCascadedBorderColor(keyboardType, groupName, theme, defaultValue) =
  getGenericProperty([keyboardType, groupName, theme, 'border', 'color'], theme, 'border', defaultValue);

local getCascadedBorderSize(keyboardType, groupName, theme, defaultValue) =
  getGenericProperty([keyboardType, groupName, theme, 'border', 'size'], theme, 'borderSize', defaultValue);

local getCascadedPanelShadow(keyboardType, groupName, theme, paletteKey, defaultValue) =
  getCascadedSimpleProperty(keyboardType, groupName, 'shadow', theme, paletteKey, defaultValue);

local getCascadedPanelBorderColor(keyboardType, groupName, theme, paletteKey, defaultValue) =
  getGenericProperty([keyboardType, groupName, theme, 'border', 'color'], theme, paletteKey, defaultValue);

local getCascadedPanelBorderSize(keyboardType, groupName, theme, paletteKey, defaultValue) =
  getGenericProperty([keyboardType, groupName, theme, 'border', 'size'], theme, paletteKey, defaultValue);

local getCascadedCandidateColor(keyboardType, propertyName, theme, paletteKey, defaultColor) =
  getGenericProperty([keyboardType, 'candidates', theme, propertyName], theme, paletteKey, defaultColor);

local getCascadedBubbleTextColor(keyboardType, colorType, theme, paletteKey, defaultColor) =
  getGenericProperty([keyboardType, 'bubbleText', theme, colorType], theme, paletteKey, defaultColor);

local paletteShadow(theme, defaultShadow) =
  if settings.customColors.enableCustomColors then
    safeGet(settings.customColors.palette[theme], 'shadow', defaultShadow)
  else
    defaultShadow;

local paletteColor(theme, key, defaultColor) =
  if settings.customColors.enableCustomColors then
    safeGet(settings.customColors.palette[theme], key, defaultColor)
  else
    defaultColor;

local getCascadedKeyboardBg(keyboardType, theme, defaultColor) =
  getGenericProperty([keyboardType, 'keyboardBackground', theme], theme, 'bg', defaultColor);

local getCascadedToolbarBg(keyboardType, theme, defaultColor) =
  getGenericProperty([keyboardType, 'toolbarBackground', theme], theme, 'toolbarBg', defaultColor);

local getCascadedToolbarButtonColor(keyboardType, theme, defaultColor) =
  getGenericProperty([keyboardType, 'toolbarButtons', theme, 'color'], theme, 'toolbarColor', defaultColor);

local getCascadedSystemBorderColor(keyboardType, groupName, theme, defaultValue) =
  getGenericProperty([keyboardType, groupName, theme, 'border'], theme, 'systemBorder', defaultValue, true, 'color');

local getCascadedSystemBorderSize(keyboardType, groupName, theme, defaultValue) =
  getGenericProperty([keyboardType, groupName, theme, 'border'], theme, 'systemBorderSize', defaultValue, true, 'size');

local getCascadedSystemShadow(keyboardType, groupName, theme, normalOrHighlight, defaultValue) =
  local paletteKey = if normalOrHighlight == 'highlight' then 'systemShadowHighlight' else 'systemShadow';
  getGenericProperty([keyboardType, groupName, theme, 'shadow'], theme, paletteKey, defaultValue, true, normalOrHighlight);

local getCascadedEnterBorderColor(keyboardType, groupName, theme, defaultValue) =
  getGenericProperty([keyboardType, groupName, theme, 'border'], theme, 'enterBorder', defaultValue, true, 'color');

local getCascadedEnterBorderSize(keyboardType, groupName, theme, defaultValue) =
  getGenericProperty([keyboardType, groupName, theme, 'border'], theme, 'enterBorderSize', defaultValue, true, 'size');

local getCascadedEnterShadow(keyboardType, groupName, theme, normalOrHighlight, defaultValue) =
  local paletteKey = if normalOrHighlight == 'highlight' then 'enterShadowHighlight' else 'enterShadow';
  getGenericProperty([keyboardType, groupName, theme, 'shadow'], theme, paletteKey, defaultValue, true, normalOrHighlight);


{
  light: {

    // ==== 空白鍵專屬樣式 (Layer 3: spaceKey) ====
    '空白键背景颜色-普通': getCascadedColor('spaceKey', 'background', 'keySpace', 'light', '#FFFFFF', 'normal'),
    '空白键背景颜色-高亮': getCascadedColor('spaceKey', 'background', 'keySpaceHighlight', 'light', '#ABB0BA', 'highlight'),
    '空白键阴影颜色-普通': getCascadedShadow('spaceKey', 'background', 'light', 'normal', '#9a9c9a'),
    '空白键阴影颜色-高亮': getCascadedShadow('spaceKey', 'background', 'light', 'highlight', '#9a9c9a'),
    '空白键边框颜色': getCascadedBorderColor('spaceKey', 'background', 'light', '#FFFFFF'),
    '空白键边框宽度': getCascadedBorderSize('spaceKey', 'background', 'light', 0),

    // === 字母鍵/一般鍵 (keyboard26, numeric) ===
    '字母键背景颜色-普通': getCascadedColor('keyboard26Chinese', 'alphabet', 'keyNormal', 'light', '#FFFFFF', 'normal'),
    '字母键背景颜色-高亮': getCascadedColor('keyboard26Chinese', 'alphabet', 'keyNormalHighlight', 'light', '#ABB0BA', 'highlight'),
    '按键前景颜色': getCascadedTextColor('keyboard26Chinese', 'alphabet', 'textMain', 'light', '#000000'),
    '按键文字颜色': getCascadedTextColor('keyboard26Chinese', 'alphabet', 'textMain', 'light', '#000000'),
    '空白键文字颜色': getCascadedTextColor('keyboard26Chinese', 'spaceKey', 'textSpace', 'light', '#000000'),
    '字母键边框顏色-普通': getCascadedBorderColor('keyboard26Chinese', 'alphabet', 'light', '#FFFFFF'),
    '字母键边框顏色-高亮': getCascadedBorderColor('keyboard26Chinese', 'alphabet', 'light', '#FFFFFF'),
    '字母键边框宽度': getCascadedBorderSize('keyboard26Chinese', 'alphabet', 'light', 0),

    // === 系統功能鍵 ===
    '功能键背景颜色-普通': getCascadedColor('keyboard26Chinese', 'systemKeys', 'keySystem', 'light', '#979faf80', 'normal'),
    '功能键背景颜色-高亮': getCascadedColor('keyboard26Chinese', 'systemKeys', 'keySystemHighlight', 'light', '#FFFFFFE6', 'highlight'),
    '系统功能键文字顏色': getCascadedTextColor('keyboard26Chinese', 'systemKeys', 'textSystem', 'light', '#000000'),
    '系统功能键边框顏色-普通': getCascadedSystemBorderColor('keyboard26Chinese', 'systemKeys', 'light', '#FFFFFF'),
    '系统功能键边框顏色-高亮': getCascadedSystemBorderColor('keyboard26Chinese', 'systemKeys', 'light', '#FFFFFF'),
    '系统功能键边框宽度': getCascadedSystemBorderSize('keyboard26Chinese', 'systemKeys', 'light', 0),

    // === Enter 鍵 ===
    'enter键背景颜色-普通': getCascadedColor('keyboard26Chinese', 'enterKey', 'keyEnter', 'light', '#979faf80', 'normal'),
    'enter键背景颜色-高亮': getCascadedColor('keyboard26Chinese', 'enterKey', 'keyEnterHighlight', 'light', '#FFFFFFE6', 'highlight'),
    'enter键文字颜色': getCascadedTextColor('keyboard26Chinese', 'enterKey', 'textEnter', 'light', '#000000'),
    'enter键边框顏色-普通': getCascadedEnterBorderColor('keyboard26Chinese', 'enterKey', 'light', '#FFFFFF'),
    'enter键边框顏色-高亮': getCascadedEnterBorderColor('keyboard26Chinese', 'enterKey', 'light', '#FFFFFF'),
    'enter键边框宽度': getCascadedEnterBorderSize('keyboard26Chinese', 'enterKey', 'light', 0),

    // === 數字鍵盤 (九宮格) ===
    '数字键文字颜色': getCascadedTextColor('numeric', 'numbers', 'textMain', 'light', '#000000'),
    '数字键背景颜色-普通': getCascadedColor('numeric', 'numbers', 'keyNormal', 'light', '#FFFFFF', 'normal'),
    '数字键背景颜色-高亮': getCascadedColor('numeric', 'numbers', 'keyNormalHighlight', 'light', '#ABB0BA', 'highlight'),
    '数字键底边缘颜色-普通': getCascadedShadow('numeric', 'numbers', 'light', 'normal', '#9a9c9a'),
    '数字键底边缘颜色-高亮': getCascadedShadow('numeric', 'numbers', 'light', 'highlight', '#9a9c9a'),
    '数字键边框颜色-普通': getCascadedBorderColor('numeric', 'numbers', 'light', '#FFFFFF'),
    '数字键边框颜色-高亮': getCascadedBorderColor('numeric', 'numbers', 'light', '#FFFFFF'),
    '数字键边框宽度': getCascadedBorderSize('numeric', 'numbers', 'light', 0),
    '数字键盘左侧collection背景顏色': getCascadedColor('numeric', 'leftPanel', 'numericLeftPanelBg', 'light', '#979faf80', 'normal'),
    '数字键盘左侧collection背景下边缘顏色': getCascadedPanelShadow('numeric', 'leftPanel', 'light', 'numericLeftPanelShadow', '#9a9c9a'),
    '数字键盘左侧collection边框颜色': getCascadedPanelBorderColor('numeric', 'leftPanel', 'light', 'numericLeftPanelBorder', '#FFFFFF'),
    '数字键盘左侧collection边框宽度': getCascadedPanelBorderSize('numeric', 'leftPanel', 'light', 'numericLeftPanelBorderSize', 0),
    
    // 數字鍵盤系統功能鍵 (返回, #+=, 空格, Delete, ., =)
    '数字键盘功能键背景颜色-普通': getCascadedColor('numeric', 'systemKeys', 'keySystem', 'light', '#979faf80', 'normal'),
    '数字键盘功能键背景颜色-高亮': getCascadedColor('numeric', 'systemKeys', 'keySystemHighlight', 'light', '#FFFFFFE6', 'highlight'),
    '数字键盘功能键文字颜色': getCascadedTextColor('numeric', 'systemKeys', 'textSystem', 'light', '#000000'),
    '数字键盘功能键底边缘颜色-普通': getCascadedSystemShadow('numeric', 'systemKeys', 'light', 'normal', '#9a9c9a'),
    '数字键盘功能键底边缘颜色-高亮': getCascadedSystemShadow('numeric', 'systemKeys', 'light', 'highlight', '#9a9c9a'),
    '数字键盘功能键边框颜色-普通': getCascadedSystemBorderColor('numeric', 'systemKeys', 'light', '#FFFFFF'),
    '数字键盘功能键边框颜色-高亮': getCascadedSystemBorderColor('numeric', 'systemKeys', 'light', '#FFFFFF'),
    '数字键盘功能键边框宽度': getCascadedSystemBorderSize('numeric', 'systemKeys', 'light', 0),
    
    // 數字鍵盤 Enter 鍵專用
    '数字键盘enter键背景颜色-普通': getCascadedColor('numeric', 'enterKey', 'keyEnter', 'light', '#979faf80', 'normal'),
    '数字键盘enter键背景颜色-高亮': getCascadedColor('numeric', 'enterKey', 'keyEnterHighlight', 'light', '#FFFFFFE6', 'highlight'),
    '数字键盘enter键文字颜色': getCascadedTextColor('numeric', 'enterKey', 'textEnter', 'light', '#000000'),
    '数字键盘enter键底边缘颜色-普通': getCascadedEnterShadow('numeric', 'enterKey', 'light', 'normal', '#9a9c9a'),
    '数字键盘enter键底边缘颜色-高亮': getCascadedEnterShadow('numeric', 'enterKey', 'light', 'highlight', '#9a9c9a'),
    '数字键盘enter键边框颜色-普通': getCascadedEnterBorderColor('numeric', 'enterKey', 'light', '#FFFFFF'),
    '数字键盘enter键边框颜色-高亮': getCascadedEnterBorderColor('numeric', 'enterKey', 'light', '#FFFFFF'),
    '数字键盘enter键边框宽度': getCascadedEnterBorderSize('numeric', 'enterKey', 'light', 0),
    
    // 數字鍵盤背景
    '数字键盘背景顏色': getCascadedKeyboardBg('numeric', 'light', '#D0D3DA01'),
    '数字键盘工具列背景顏色': getCascadedToolbarBg('numeric', 'light', '#D0D3DA01'),
    '数字键盘工具列按鈕顏色': getCascadedToolbarButtonColor('numeric', 'light', '#666666'),

    // === 符號鍵盤 (Symbolic) ===
    '符號鍵盤左側collection字體顏色': getCascadedTextColor('symbolic', 'leftPanel', 'panelLeftText', 'light', '#000000'),
    '符號鍵盤右側collection字體顏色': getCascadedTextColor('symbolic', 'rightPanel', 'panelRightText', 'light', '#000000'),
    '符號鍵盤左側collection背景顏色': getCascadedColor('symbolic', 'leftPanel', 'panelLeftBg', 'light', '#979faf80', 'normal'),
    '符號鍵盤左側collection背景下邊緣顏色': getCascadedPanelShadow('symbolic', 'leftPanel', 'light', 'panelLeftShadow', '#9a9c9a'),
    '符號鍵盤左側collection邊框顏色': getCascadedPanelBorderColor('symbolic', 'leftPanel', 'light', 'panelLeftBorder', '#979faf80'),
    '符號鍵盤左側collection邊框寬度': getCascadedPanelBorderSize('symbolic', 'leftPanel', 'light', 'panelLeftBorderSize', 0),
    '符號鍵盤右側collection背景顏色': getCascadedColor('symbolic', 'rightPanel', 'panelRightBg', 'light', '#ffffff', 'normal'),
    '符號鍵盤右側collection背景下邊緣顏色': getCascadedPanelShadow('symbolic', 'rightPanel', 'light', 'panelRightShadow', '#9a9c9a'),
    '符號鍵盤右側collection邊框顏色': getCascadedPanelBorderColor('symbolic', 'rightPanel', 'light', 'panelRightBorder', '#ffffff'),
    '符號鍵盤右側collection邊框寬度': getCascadedPanelBorderSize('symbolic', 'rightPanel', 'light', 'panelRightBorderSize', 0),
    '符號鍵盤左側分類選中顏色': getCascadedSimpleProperty('symbolic', 'leftPanel', 'categoryHighlight', 'light', 'panelCategoryHighlight', '#ABB0BA'),
    
    // 符號鍵盤系統功能鍵 (返回, 上捲, 下捲, 鎖頭, Delete)
    '符號鍵盤功能键背景颜色-普通': getCascadedColor('symbolic', 'systemKeys', 'keySystem', 'light', '#979faf80', 'normal'),
    '符號鍵盤功能键背景颜色-高亮': getCascadedColor('symbolic', 'systemKeys', 'keySystemHighlight', 'light', '#FFFFFFE6', 'highlight'),
    '符號鍵盤功能键文字颜色': getCascadedTextColor('symbolic', 'systemKeys', 'textSystem', 'light', '#000000'),
    '符號鍵盤功能键底边缘颜色-普通': getCascadedSystemShadow('symbolic', 'systemKeys', 'light', 'normal', '#9a9c9a'),
    '符號鍵盤功能键底边缘颜色-高亮': getCascadedSystemShadow('symbolic', 'systemKeys', 'light', 'highlight', '#9a9c9a'),
    '符號鍵盤功能键边框颜色-普通': getCascadedSystemBorderColor('symbolic', 'systemKeys', 'light', '#FFFFFF'),
    '符號鍵盤功能键边框颜色-高亮': getCascadedSystemBorderColor('symbolic', 'systemKeys', 'light', '#FFFFFF'),
    '符號鍵盤功能键边框宽度': getCascadedSystemBorderSize('symbolic', 'systemKeys', 'light', 0),
    // 符號鍵盤 Enter 鍵
    '符號鍵盤enter键背景颜色-普通': getCascadedColor('symbolic', 'enterKey', 'keyEnter', 'light', '#979faf80', 'normal'),
    '符號鍵盤enter键背景颜色-高亮': getCascadedColor('symbolic', 'enterKey', 'keyEnterHighlight', 'light', '#FFFFFFE6', 'highlight'),
    '符號鍵盤enter键文字颜色': getCascadedTextColor('symbolic', 'enterKey', 'textEnter', 'light', '#000000'),
    '符號鍵盤enter键底边缘颜色-普通': getCascadedEnterShadow('symbolic', 'enterKey', 'light', 'normal', '#9a9c9a'),
    '符號鍵盤enter键底边缘颜色-高亮': getCascadedEnterShadow('symbolic', 'enterKey', 'light', 'highlight', '#9a9c9a'),
    '符號鍵盤enter键边框颜色-普通': getCascadedEnterBorderColor('symbolic', 'enterKey', 'light', '#FFFFFF'),
    '符號鍵盤enter键边框颜色-高亮': getCascadedEnterBorderColor('symbolic', 'enterKey', 'light', '#FFFFFF'),
    '符號鍵盤enter键边框宽度': getCascadedEnterBorderSize('symbolic', 'enterKey', 'light', 0),
    
    // 符號鍵盤背景
    '符號键盘背景顏色': getCascadedKeyboardBg('symbolic', 'light', '#D0D3DA01'),

    // === Emoji 鍵盤 (獨立 Override) ===
    'emoji鍵盤左側collection字體顏色': getCascadedTextColor('emoji', 'leftPanel', 'panelLeftText', 'light', '#000000'),
    'emoji鍵盤右側collection字體顏色': getCascadedTextColor('emoji', 'rightPanel', 'panelRightText', 'light', '#000000'),
    'emoji鍵盤左側collection背景顏色': getCascadedColor('emoji', 'leftPanel', 'panelLeftBg', 'light', '#979faf80', 'normal'),
    'emoji鍵盤左側collection背景下邊緣顏色': getCascadedPanelShadow('emoji', 'leftPanel', 'light', 'panelLeftShadow', '#9a9c9a'),
    'emoji鍵盤左側collection邊框顏色': getCascadedPanelBorderColor('emoji', 'leftPanel', 'light', 'panelLeftBorder', '#979faf80'),
    'emoji鍵盤左側collection邊框寬度': getCascadedPanelBorderSize('emoji', 'leftPanel', 'light', 'panelLeftBorderSize', 0),
    'emoji鍵盤右側collection背景顏色': getCascadedColor('emoji', 'rightPanel', 'panelRightBg', 'light', '#ffffff', 'normal'),
    'emoji鍵盤右側collection背景下邊緣顏色': getCascadedPanelShadow('emoji', 'rightPanel', 'light', 'panelRightShadow', '#9a9c9a'),
    'emoji鍵盤右側collection邊框顏色': getCascadedPanelBorderColor('emoji', 'rightPanel', 'light', 'panelRightBorder', '#ffffff'),
    'emoji鍵盤右側collection邊框寬度': getCascadedPanelBorderSize('emoji', 'rightPanel', 'light', 'panelRightBorderSize', 0),
    'emoji鍵盤左側分類選中顏色': getCascadedSimpleProperty('emoji', 'leftPanel', 'categoryHighlight', 'light', 'panelCategoryHighlight', '#ABB0BA'),
    
    // Emoji 鍵盤系統功能鍵 (返回, 上捲, 下捲, 鎖頭, Delete)
    'emoji鍵盤功能键背景颜色-普通': getCascadedColor('emoji', 'systemKeys', 'keySystem', 'light', '#979faf80', 'normal'),
    'emoji鍵盤功能键背景颜色-高亮': getCascadedColor('emoji', 'systemKeys', 'keySystemHighlight', 'light', '#FFFFFFE6', 'highlight'),
    'emoji鍵盤功能键文字颜色': getCascadedTextColor('emoji', 'systemKeys', 'textSystem', 'light', '#000000'),
    'emoji鍵盤功能键底边缘颜色-普通': getCascadedSystemShadow('emoji', 'systemKeys', 'light', 'normal', '#9a9c9a'),
    'emoji鍵盤功能键底边缘颜色-高亮': getCascadedSystemShadow('emoji', 'systemKeys', 'light', 'highlight', '#9a9c9a'),
    'emoji鍵盤功能键边框颜色-普通': getCascadedSystemBorderColor('emoji', 'systemKeys', 'light', '#FFFFFF'),
    'emoji鍵盤功能键边框颜色-高亮': getCascadedSystemBorderColor('emoji', 'systemKeys', 'light', '#FFFFFF'),
    'emoji鍵盤功能键边框宽度': getCascadedSystemBorderSize('emoji', 'systemKeys', 'light', 0),
    // Emoji 鍵盤 Enter 鍵
    'emoji鍵盤enter键背景颜色-普通': getCascadedColor('emoji', 'enterKey', 'keyEnter', 'light', '#979faf80', 'normal'),
    'emoji鍵盤enter键背景颜色-高亮': getCascadedColor('emoji', 'enterKey', 'keyEnterHighlight', 'light', '#FFFFFFE6', 'highlight'),
    'emoji鍵盤enter键文字颜色': getCascadedTextColor('emoji', 'enterKey', 'textEnter', 'light', '#000000'),
    'emoji鍵盤enter键底边缘颜色-普通': getCascadedEnterShadow('emoji', 'enterKey', 'light', 'normal', '#9a9c9a'),
    'emoji鍵盤enter键底边缘颜色-高亮': getCascadedEnterShadow('emoji', 'enterKey', 'light', 'highlight', '#9a9c9a'),
    'emoji鍵盤enter键边框颜色-普通': getCascadedEnterBorderColor('emoji', 'enterKey', 'light', '#FFFFFF'),
    'emoji鍵盤enter键边框颜色-高亮': getCascadedEnterBorderColor('emoji', 'enterKey', 'light', '#FFFFFF'),
    'emoji鍵盤enter键边框宽度': getCascadedEnterBorderSize('emoji', 'enterKey', 'light', 0),
    
    // Emoji 鍵盤背景
    'emoji键盘背景顏色': getCascadedKeyboardBg('emoji', 'light', '#D0D3DA01'),

    // === Kaomojis 鍵盤 (獨立 Override) ===
    'kaomojis鍵盤左側collection字體顏色': getCascadedTextColor('kaomojis', 'leftPanel', 'panelLeftText', 'light', '#000000'),
    'kaomojis鍵盤右側collection字體顏色': getCascadedTextColor('kaomojis', 'rightPanel', 'panelRightText', 'light', '#000000'),
    'kaomojis鍵盤左側collection背景顏色': getCascadedColor('kaomojis', 'leftPanel', 'panelLeftBg', 'light', '#979faf80', 'normal'),
    'kaomojis鍵盤左側collection背景下邊緣顏色': getCascadedPanelShadow('kaomojis', 'leftPanel', 'light', 'panelLeftShadow', '#9a9c9a'),
    'kaomojis鍵盤左側collection邊框顏色': getCascadedPanelBorderColor('kaomojis', 'leftPanel', 'light', 'panelLeftBorder', '#979faf80'),
    'kaomojis鍵盤左側collection邊框寬度': getCascadedPanelBorderSize('kaomojis', 'leftPanel', 'light', 'panelLeftBorderSize', 0),
    'kaomojis鍵盤右側collection背景顏色': getCascadedColor('kaomojis', 'rightPanel', 'panelRightBg', 'light', '#ffffff', 'normal'),
    'kaomojis鍵盤右側collection背景下邊緣顏色': getCascadedPanelShadow('kaomojis', 'rightPanel', 'light', 'panelRightShadow', '#9a9c9a'),
    'kaomojis鍵盤右側collection邊框顏色': getCascadedPanelBorderColor('kaomojis', 'rightPanel', 'light', 'panelRightBorder', '#ffffff'),
    'kaomojis鍵盤右側collection邊框寬度': getCascadedPanelBorderSize('kaomojis', 'rightPanel', 'light', 'panelRightBorderSize', 0),
    'kaomojis鍵盤左側分類選中顏色': getCascadedSimpleProperty('kaomojis', 'leftPanel', 'categoryHighlight', 'light', 'panelCategoryHighlight', '#ABB0BA'),
    
    // Kaomojis 鍵盤系統功能鍵 (返回, 上捲, 下捲, 鎖頭, Delete)
    'kaomojis鍵盤功能键背景颜色-普通': getCascadedColor('kaomojis', 'systemKeys', 'keySystem', 'light', '#979faf80', 'normal'),
    'kaomojis鍵盤功能键背景颜色-高亮': getCascadedColor('kaomojis', 'systemKeys', 'keySystemHighlight', 'light', '#FFFFFFE6', 'highlight'),
    'kaomojis鍵盤功能键文字颜色': getCascadedTextColor('kaomojis', 'systemKeys', 'textSystem', 'light', '#000000'),
    'kaomojis鍵盤功能键底边缘颜色-普通': getCascadedSystemShadow('kaomojis', 'systemKeys', 'light', 'normal', '#9a9c9a'),
    'kaomojis鍵盤功能键底边缘颜色-高亮': getCascadedSystemShadow('kaomojis', 'systemKeys', 'light', 'highlight', '#9a9c9a'),
    'kaomojis鍵盤功能键边框颜色-普通': getCascadedSystemBorderColor('kaomojis', 'systemKeys', 'light', '#FFFFFF'),
    'kaomojis鍵盤功能键边框颜色-高亮': getCascadedSystemBorderColor('kaomojis', 'systemKeys', 'light', '#FFFFFF'),
    'kaomojis鍵盤功能键边框宽度': getCascadedSystemBorderSize('kaomojis', 'systemKeys', 'light', 0),
    // Kaomojis 鍵盤 Enter 鍵
    'kaomojis鍵盤enter键背景颜色-普通': getCascadedColor('kaomojis', 'enterKey', 'keyEnter', 'light', '#979faf80', 'normal'),
    'kaomojis鍵盤enter键背景颜色-高亮': getCascadedColor('kaomojis', 'enterKey', 'keyEnterHighlight', 'light', '#FFFFFFE6', 'highlight'),
    'kaomojis鍵盤enter键文字颜色': getCascadedTextColor('kaomojis', 'enterKey', 'textEnter', 'light', '#000000'),
    'kaomojis鍵盤enter键底边缘颜色-普通': getCascadedEnterShadow('kaomojis', 'enterKey', 'light', 'normal', '#9a9c9a'),
    'kaomojis鍵盤enter键底边缘颜色-高亮': getCascadedEnterShadow('kaomojis', 'enterKey', 'light', 'highlight', '#9a9c9a'),
    'kaomojis鍵盤enter键边框颜色-普通': getCascadedEnterBorderColor('kaomojis', 'enterKey', 'light', '#FFFFFF'),
    'kaomojis鍵盤enter键边框颜色-高亮': getCascadedEnterBorderColor('kaomojis', 'enterKey', 'light', '#FFFFFF'),
    'kaomojis鍵盤enter键边框宽度': getCascadedEnterBorderSize('kaomojis', 'enterKey', 'light', 0),
    
    // Kaomojis 鍵盤背景
    'kaomojis键盘背景顏色': getCascadedKeyboardBg('kaomojis', 'light', '#D0D3DA01'),

    // === Row 數字鍵盤 (獨立 Override) ===
    'Row数字键文字颜色': getCascadedTextColor('numericRow', 'numbers', 'textMain', 'light', '#000000'),
    'Row数字键背景颜色-普通': getCascadedColor('numericRow', 'numbers', 'keyNormal', 'light', '#FFFFFF', 'normal'),
    'Row数字键背景颜色-高亮': getCascadedColor('numericRow', 'numbers', 'keyNormalHighlight', 'light', '#ABB0BA', 'highlight'),
    'Row数字键底边缘颜色-普通': getCascadedShadow('numericRow', 'numbers', 'light', 'normal', '#9a9c9a'),
    'Row数字键底边缘颜色-高亮': getCascadedShadow('numericRow', 'numbers', 'light', 'highlight', '#9a9c9a'),
    'Row数字键边框颜色-普通': getCascadedBorderColor('numericRow', 'numbers', 'light', '#FFFFFF'),
    'Row数字键边框颜色-高亮': getCascadedBorderColor('numericRow', 'numbers', 'light', '#FFFFFF'),
    'Row数字键边框宽度': getCascadedBorderSize('numericRow', 'numbers', 'light', 0),
    'Row数字键盘功能键背景颜色-普通': getCascadedColor('numericRow', 'systemKeys', 'keySystem', 'light', '#979faf80', 'normal'),
    'Row数字键盘功能键背景颜色-高亮': getCascadedColor('numericRow', 'systemKeys', 'keySystemHighlight', 'light', '#FFFFFFE6', 'highlight'),
    'Row数字键盘功能键文字颜色': getCascadedTextColor('numericRow', 'systemKeys', 'textSystem', 'light', '#000000'),
    'Row数字键盘功能键底边缘颜色-普通': getCascadedSystemShadow('numericRow', 'systemKeys', 'light', 'normal', '#9a9c9a'),
    'Row数字键盘功能键底边缘颜色-高亮': getCascadedSystemShadow('numericRow', 'systemKeys', 'light', 'highlight', '#9a9c9a'),
    'Row数字键盘功能键边框颜色-普通': getCascadedSystemBorderColor('numericRow', 'systemKeys', 'light', '#FFFFFF'),
    'Row数字键盘功能键边框颜色-高亮': getCascadedSystemBorderColor('numericRow', 'systemKeys', 'light', '#FFFFFF'),
    'Row数字键盘功能键边框宽度': getCascadedSystemBorderSize('numericRow', 'systemKeys', 'light', 0),
    'Row数字键盘enter键背景颜色-普通': getCascadedColor('numericRow', 'enterKey', 'keyEnter', 'light', '#979faf80', 'normal'),
    'Row数字键盘enter键背景颜色-高亮': getCascadedColor('numericRow', 'enterKey', 'keyEnterHighlight', 'light', '#FFFFFFE6', 'highlight'),
    'Row数字键盘enter键文字颜色': getCascadedTextColor('numericRow', 'enterKey', 'textEnter', 'light', '#000000'),
    'Row数字键盘enter键底边缘颜色-普通': getCascadedEnterShadow('numericRow', 'enterKey', 'light', 'normal', '#9a9c9a'),
    'Row数字键盘enter键底边缘颜色-高亮': getCascadedEnterShadow('numericRow', 'enterKey', 'light', 'highlight', '#9a9c9a'),
    'Row数字键盘enter键边框颜色-普通': getCascadedEnterBorderColor('numericRow', 'enterKey', 'light', '#FFFFFF'),
    'Row数字键盘enter键边框颜色-高亮': getCascadedEnterBorderColor('numericRow', 'enterKey', 'light', '#FFFFFF'),
    'Row数字键盘enter键边框宽度': getCascadedEnterBorderSize('numericRow', 'enterKey', 'light', 0),
    
    // Row 數字鍵盤空白鍵專屬（繼承全局 spaceKey）
    'Row数字键盘空白键背景颜色-普通': getCascadedColor('numericRow', 'spaceKey', 'keySpace', 'light', '#FFFFFF', 'normal'),
    'Row数字键盘空白键背景颜色-高亮': getCascadedColor('numericRow', 'spaceKey', 'keySpaceHighlight', 'light', '#ABB0BA', 'highlight'),
    'Row数字键盘空白键阴影颜色-普通': getCascadedShadow('numericRow', 'spaceKey', 'light', 'normal', '#9a9c9a'),
    'Row数字键盘空白键阴影颜色-高亮': getCascadedShadow('numericRow', 'spaceKey', 'light', 'highlight', '#9a9c9a'),
    'Row数字键盘空白键边框颜色': getCascadedBorderColor('numericRow', 'spaceKey', 'light', '#FFFFFF'),
    'Row数字键盘空白键边框宽度': getCascadedBorderSize('numericRow', 'spaceKey', 'light', 0),
    'Row数字键盘空白键文字颜色': getCascadedTextColor('numericRow', 'spaceKey', 'textSpace', 'light', '#000000'),

    'Row数字键盘背景顏色': getCascadedKeyboardBg('numericRow', 'light', '#D0D3DA01'),
    'Row数字键盘工具列背景顏色': getCascadedToolbarBg('numericRow', 'light', '#D0D3DA01'),
    'Row数字键盘工具列按鈕顏色': getCascadedToolbarButtonColor('numericRow', 'light', '#666666'),

    // === Row 符號鍵盤 (獨立 Override) ===
    'Row符號鍵盤右側collection字體顏色': getCascadedTextColor('symbolicRow', 'symbols', 'textMain', 'light', '#000000'),
    'Row符號鍵盤右側collection背景顏色': getCascadedColor('symbolicRow', 'symbols', 'keyNormal', 'light', '#ffffff', 'normal'),
    'Row符號鍵盤右側collection背景顏色-高亮': getCascadedColor('symbolicRow', 'symbols', 'keyNormalHighlight', 'light', '#ABB0BA', 'highlight'),
    'Row符號鍵盤右側collection背景下邊緣顏色': getCascadedShadow('symbolicRow', 'symbols', 'light', 'normal', '#9a9c9a'),
    'Row符號鍵盤右側collection邊框顏色': getCascadedBorderColor('symbolicRow', 'symbols', 'light', '#ffffff'),
    'Row符號鍵盤右側collection邊框寬度': getCascadedBorderSize('symbolicRow', 'symbols', 'light', 0),    'Row符號鍵盤功能键背景颜色-普通': getCascadedColor('symbolicRow', 'systemKeys', 'keySystem', 'light', '#979faf80', 'normal'),
    'Row符號鍵盤功能键背景颜色-高亮': getCascadedColor('symbolicRow', 'systemKeys', 'keySystemHighlight', 'light', '#FFFFFFE6', 'highlight'),
    'Row符號鍵盤功能键文字颜色': getCascadedTextColor('symbolicRow', 'systemKeys', 'textSystem', 'light', '#000000'),
    'Row符號鍵盤功能键底边缘颜色-普通': getCascadedSystemShadow('symbolicRow', 'systemKeys', 'light', 'normal', '#9a9c9a'),
    'Row符號鍵盤功能键底边缘颜色-高亮': getCascadedSystemShadow('symbolicRow', 'systemKeys', 'light', 'highlight', '#9a9c9a'),
    'Row符號鍵盤功能键边框颜色-普通': getCascadedSystemBorderColor('symbolicRow', 'systemKeys', 'light', '#FFFFFF'),
    'Row符號鍵盤功能键边框颜色-高亮': getCascadedSystemBorderColor('symbolicRow', 'systemKeys', 'light', '#FFFFFF'),
    'Row符號鍵盤功能键边框宽度': getCascadedSystemBorderSize('symbolicRow', 'systemKeys', 'light', 0),
    
    // Row 符號鍵盤 Enter 鍵專用（深綠色）
    'Row符號鍵盤enter键背景颜色-普通': getCascadedColor('symbolicRow', 'enterKey', 'keyEnter', 'light', '#979faf80', 'normal'),
    'Row符號鍵盤enter键背景颜色-高亮': getCascadedColor('symbolicRow', 'enterKey', 'keyEnterHighlight', 'light', '#FFFFFFE6', 'highlight'),
    'Row符號鍵盤enter键文字颜色': getCascadedTextColor('symbolicRow', 'enterKey', 'textEnter', 'light', '#000000'),
    'Row符號鍵盤enter键底边缘颜色-普通': getCascadedEnterShadow('symbolicRow', 'enterKey', 'light', 'normal', '#9a9c9a'),
    'Row符號鍵盤enter键底边缘颜色-高亮': getCascadedEnterShadow('symbolicRow', 'enterKey', 'light', 'highlight', '#9a9c9a'),
    'Row符號鍵盤enter键边框颜色-普通': getCascadedEnterBorderColor('symbolicRow', 'enterKey', 'light', '#FFFFFF'),
    'Row符號鍵盤enter键边框颜色-高亮': getCascadedEnterBorderColor('symbolicRow', 'enterKey', 'light', '#FFFFFF'),
    'Row符號鍵盤enter键边框宽度': getCascadedEnterBorderSize('symbolicRow', 'enterKey', 'light', 0),
    
    // Row 符號鍵盤空白鍵專屬（繼承全局 spaceKey）
    'Row符號键盘空白键背景颜色-普通': getCascadedColor('symbolicRow', 'spaceKey', 'keySpace', 'light', '#FFFFFF', 'normal'),
    'Row符號键盘空白键背景颜色-高亮': getCascadedColor('symbolicRow', 'spaceKey', 'keySpaceHighlight', 'light', '#ABB0BA', 'highlight'),
    'Row符號键盘空白键阴影颜色-普通': getCascadedShadow('symbolicRow', 'spaceKey', 'light', 'normal', '#9a9c9a'),
    'Row符號键盘空白键阴影颜色-高亮': getCascadedShadow('symbolicRow', 'spaceKey', 'light', 'highlight', '#9a9c9a'),
    'Row符號键盘空白键边框颜色': getCascadedBorderColor('symbolicRow', 'spaceKey', 'light', '#FFFFFF'),
    'Row符號键盘空白键边框宽度': getCascadedBorderSize('symbolicRow', 'spaceKey', 'light', 0),
    'Row符號键盘空白键文字颜色': getCascadedTextColor('symbolicRow', 'spaceKey', 'textSpace', 'light', '#000000'),

    'Row符號键盘背景顏色': getCascadedKeyboardBg('symbolicRow', 'light', '#D0D3DA01'),
    'Row符號键盘工具列背景顏色': getCascadedToolbarBg('symbolicRow', 'light', '#D0D3DA01'),
    'Row符號键盘工具列按鈕顏色': getCascadedToolbarButtonColor('symbolicRow', 'light', '#666666'),

    // === 注音鍵盤 (Bopomofo) ===
    // 莫蘭迪紫色配色
    '注音符號键背景颜色-普通': getCascadedColor('bopomofo', 'bpmfKeys', 'keyNormal', 'light', '#FFFFFF', 'normal'),
    '注音符號键背景颜色-高亮': getCascadedColor('bopomofo', 'bpmfKeys', 'keyNormalHighlight', 'light', '#ABB0BA', 'highlight'),
    '注音符號键文字颜色': getCascadedTextColor('bopomofo', 'bpmfKeys', 'textMain', 'light', '#000000'),
    '注音符號键底边缘颜色-普通': getCascadedShadow('bopomofo', 'bpmfKeys', 'light', 'normal', '#9a9c9a'),
    '注音符號键底边缘颜色-高亮': getCascadedShadow('bopomofo', 'bpmfKeys', 'light', 'highlight', '#9a9c9a'),
    '注音符號键边框颜色-普通': getCascadedBorderColor('bopomofo', 'bpmfKeys', 'light', '#FFFFFF'),
    '注音符號键边框颜色-高亮': getCascadedBorderColor('bopomofo', 'bpmfKeys', 'light', '#FFFFFF'),
    '注音符號键边框宽度': getCascadedBorderSize('bopomofo', 'bpmfKeys', 'light', 0),
    
    // 注音鍵盤系統功能鍵 (返回, 直出, 輸入, Backspace)
    '注音功能键背景颜色-普通': getCascadedColor('bopomofo', 'systemKeys', 'keySystem', 'light', '#979faf80', 'normal'),
    '注音功能键背景颜色-高亮': getCascadedColor('bopomofo', 'systemKeys', 'keySystemHighlight', 'light', '#FFFFFFE6', 'highlight'),
    '注音功能键文字颜色': getCascadedTextColor('bopomofo', 'systemKeys', 'textSystem', 'light', '#000000'),
    '注音功能键底边缘颜色-普通': getCascadedSystemShadow('bopomofo', 'systemKeys', 'light', 'normal', '#9a9c9a'),
    '注音功能键底边缘颜色-高亮': getCascadedSystemShadow('bopomofo', 'systemKeys', 'light', 'highlight', '#9a9c9a'),
    '注音功能键边框颜色-普通': getCascadedSystemBorderColor('bopomofo', 'systemKeys', 'light', '#FFFFFF'),
    '注音功能键边框颜色-高亮': getCascadedSystemBorderColor('bopomofo', 'systemKeys', 'light', '#FFFFFF'),
    '注音功能键边框宽度': getCascadedSystemBorderSize('bopomofo', 'systemKeys', 'light', 0),
    
    // 注音鍵盤 Enter 鍵
    '注音enter键背景颜色-普通': getCascadedColor('bopomofo', 'enterKey', 'keyEnter', 'light', '#979faf80', 'normal'),
    '注音enter键背景颜色-高亮': getCascadedColor('bopomofo', 'enterKey', 'keyEnterHighlight', 'light', '#FFFFFFE6', 'highlight'),
    '注音enter键文字颜色': getCascadedTextColor('bopomofo', 'enterKey', 'textEnter', 'light', '#000000'),
    '注音enter键底边缘颜色-普通': getCascadedEnterShadow('bopomofo', 'enterKey', 'light', 'normal', '#9a9c9a'),
    '注音enter键底边缘颜色-高亮': getCascadedEnterShadow('bopomofo', 'enterKey', 'light', 'highlight', '#9a9c9a'),
    '注音enter键边框颜色-普通': getCascadedEnterBorderColor('bopomofo', 'enterKey', 'light', '#FFFFFF'),
    '注音enter键边框颜色-高亮': getCascadedEnterBorderColor('bopomofo', 'enterKey', 'light', '#FFFFFF'),
    '注音enter键边框宽度': getCascadedEnterBorderSize('bopomofo', 'enterKey', 'light', 0),
    
    // 注音鍵盤 Space 鍵
    '注音空白键文字颜色': getCascadedTextColor('bopomofo', 'spaceKey', 'textSpace', 'light', '#000000'),
    
    // 注音鍵盤氣泡文字顏色
    '注音按下气泡文字颜色': getCascadedBubbleTextColor('bopomofo', 'unselected', 'light', 'bubbleTextUnselected', '#000000'),
    '注音长按选中字体顏色': getCascadedBubbleTextColor('bopomofo', 'selected', 'light', 'bubbleTextSelected', '#FFFFFF'),
    '注音长按非选中字体顏色': getCascadedBubbleTextColor('bopomofo', 'unselected', 'light', 'bubbleTextUnselected', '#000000'),
    
    // 注音鍵盤背景
    '注音键盘背景颜色': getCascadedKeyboardBg('bopomofo', 'light', '#D0D3DA01'),
    '注音键盘工具列背景颜色': getCascadedToolbarBg('bopomofo', 'light', '#D0D3DA01'),
    '注音键盘工具列按钮颜色': getCascadedToolbarButtonColor('bopomofo', 'light', '#666666'),
    
    // 注音鍵盤候選字顏色
    '注音候選字體選中字體顏色': getCascadedCandidateColor('bopomofo', 'selectedText', 'light', 'candidateSelectedText', '#000000'),
    '注音候選字體未選中字體顏色': getCascadedCandidateColor('bopomofo', 'unselectedText', 'light', 'candidateUnselectedText', '#000000'),
    '注音選中候選背景顏色': getCascadedCandidateColor('bopomofo', 'selectedBackground', 'light', 'candidateSelectedBg', '#FFFFFF'),
    
    // Row 數字鍵盤候選字顏色（九宮格和 Row 數字鍵盤共用，查 numeric override）
    'Row數字候選字體選中字體顏色': getCascadedCandidateColor('numeric', 'selectedText', 'light', 'candidateSelectedText', '#000000'),
    'Row數字候選字體未選中字體顏色': getCascadedCandidateColor('numeric', 'unselectedText', 'light', 'candidateUnselectedText', '#000000'),
    'Row數字選中候選背景顏色': getCascadedCandidateColor('numeric', 'selectedBackground', 'light', 'candidateSelectedBg', '#FFFFFF'),
    
    // Row 符號鍵盤候選字顏色
    'Row符號候選字體選中字體顏色': getCascadedCandidateColor('symbolicRow', 'selectedText', 'light', 'candidateSelectedText', '#000000'),
    'Row符號候選字體未選中字體顏色': getCascadedCandidateColor('symbolicRow', 'unselectedText', 'light', 'candidateUnselectedText', '#000000'),
    'Row符號選中候選背景顏色': getCascadedCandidateColor('symbolicRow', 'selectedBackground', 'light', 'candidateSelectedBg', '#FFFFFF'),
    
    // 英文鍵盤候選字顏色
    '英文候選字體選中字體顏色': getCascadedCandidateColor('keyboard26Alphabetic', 'selectedText', 'light', 'candidateSelectedText', '#000000'),
    '英文候選字體未選中字體顏色': getCascadedCandidateColor('keyboard26Alphabetic', 'unselectedText', 'light', 'candidateUnselectedText', '#000000'),
    '英文選中候選背景顏色': getCascadedCandidateColor('keyboard26Alphabetic', 'selectedBackground', 'light', 'candidateSelectedBg', '#FFFFFF'),
    
    // 各鍵盤候選控制按鈕文字顏色（展開候選字後的四個系統鍵）
    'Row數字候選控制按鈕文字顏色': getCascadedTextColor('numeric', 'systemKeys', 'textSystem', 'light', '#000000'),
    'Row符號候選控制按鈕文字顏色': getCascadedTextColor('symbolicRow', 'systemKeys', 'textSystem', 'light', '#000000'),
    '英文候選控制按鈕文字顏色': getCascadedTextColor('keyboard26Alphabetic', 'systemKeys', 'textSystem', 'light', '#000000'),
    
    // 注音鍵盤候選字控制按鈕文字顏色（展開候選字後的四個系統鍵）
    '注音候選控制按鈕文字顏色': getCascadedTextColor('bopomofo', 'systemKeys', 'textSystem', 'light', '#1565C0'),

    // === 英文鍵盤 (Alphabetic) ===
    // 莫蘭迪靛色配色
    '英文字母键背景颜色-普通': getCascadedColor('keyboard26Alphabetic', 'alphabet', 'keyNormal', 'light', '#FFFFFF', 'normal'),
    '英文字母键背景颜色-高亮': getCascadedColor('keyboard26Alphabetic', 'alphabet', 'keyNormalHighlight', 'light', '#ABB0BA', 'highlight'),
    '英文字母键文字颜色': getCascadedTextColor('keyboard26Alphabetic', 'alphabet', 'textMain', 'light', '#000000'),
    '英文字母键底边缘颜色-普通': getCascadedShadow('keyboard26Alphabetic', 'alphabet', 'light', 'normal', '#9a9c9a'),
    '英文字母键底边缘颜色-高亮': getCascadedShadow('keyboard26Alphabetic', 'alphabet', 'light', 'highlight', '#9a9c9a'),
    '英文字母键边框颜色-普通': getCascadedBorderColor('keyboard26Alphabetic', 'alphabet', 'light', '#FFFFFF'),
    '英文字母键边框颜色-高亮': getCascadedBorderColor('keyboard26Alphabetic', 'alphabet', 'light', '#FFFFFF'),
    '英文字母键边框宽度': getCascadedBorderSize('keyboard26Alphabetic', 'alphabet', 'light', 0),
    
    // 英文鍵盤系統功能鍵 (Shift, 123, Delete)
    '英文功能键背景颜色-普通': getCascadedColor('keyboard26Alphabetic', 'systemKeys', 'keySystem', 'light', '#979faf80', 'normal'),
    '英文功能键背景颜色-高亮': getCascadedColor('keyboard26Alphabetic', 'systemKeys', 'keySystemHighlight', 'light', '#FFFFFFE6', 'highlight'),
    '英文功能键文字颜色': getCascadedTextColor('keyboard26Alphabetic', 'systemKeys', 'textSystem', 'light', '#000000'),
    '英文功能键底边缘颜色-普通': getCascadedSystemShadow('keyboard26Alphabetic', 'systemKeys', 'light', 'normal', '#9a9c9a'),
    '英文功能键底边缘颜色-高亮': getCascadedSystemShadow('keyboard26Alphabetic', 'systemKeys', 'light', 'highlight', '#9a9c9a'),
    '英文功能键边框颜色-普通': getCascadedSystemBorderColor('keyboard26Alphabetic', 'systemKeys', 'light', '#FFFFFF'),
    '英文功能键边框颜色-高亮': getCascadedSystemBorderColor('keyboard26Alphabetic', 'systemKeys', 'light', '#FFFFFF'),
    '英文功能键边框宽度': getCascadedSystemBorderSize('keyboard26Alphabetic', 'systemKeys', 'light', 0),
    
    // 英文鍵盤 Enter 鍵
    '英文enter键背景颜色-普通': getCascadedColor('keyboard26Alphabetic', 'enterKey', 'keyEnter', 'light', '#979faf80', 'normal'),
    '英文enter键背景颜色-高亮': getCascadedColor('keyboard26Alphabetic', 'enterKey', 'keyEnterHighlight', 'light', '#FFFFFFE6', 'highlight'),
    '英文enter键文字颜色': getCascadedTextColor('keyboard26Alphabetic', 'enterKey', 'textEnter', 'light', '#000000'),
    '英文enter键底边缘颜色-普通': getCascadedEnterShadow('keyboard26Alphabetic', 'enterKey', 'light', 'normal', '#9a9c9a'),
    '英文enter键底边缘颜色-高亮': getCascadedEnterShadow('keyboard26Alphabetic', 'enterKey', 'light', 'highlight', '#9a9c9a'),
    '英文enter键边框颜色-普通': getCascadedEnterBorderColor('keyboard26Alphabetic', 'enterKey', 'light', '#FFFFFF'),
    '英文enter键边框颜色-高亮': getCascadedEnterBorderColor('keyboard26Alphabetic', 'enterKey', 'light', '#FFFFFF'),
    '英文enter键边框宽度': getCascadedEnterBorderSize('keyboard26Alphabetic', 'enterKey', 'light', 0),
    
    // 英文鍵盤 Space 鍵
    '英文空白键文字颜色': getCascadedTextColor('keyboard26Alphabetic', 'spaceKey', 'textSpace', 'light', '#000000'),
    
    // 英文鍵盤氣泡文字顏色
    '英文按下气泡文字颜色': getCascadedBubbleTextColor('keyboard26Alphabetic', 'unselected', 'light', 'bubbleTextUnselected', '#000000'),
    '英文长按选中字体顏色': getCascadedBubbleTextColor('keyboard26Alphabetic', 'selected', 'light', 'bubbleTextSelected', '#FFFFFF'),
    '英文长按非选中字体顏色': getCascadedBubbleTextColor('keyboard26Alphabetic', 'unselected', 'light', 'bubbleTextUnselected', '#000000'),
    
    // 英文鍵盤背景
    '英文键盘背景颜色': getCascadedKeyboardBg('keyboard26Alphabetic', 'light', '#D0D3DA01'),
    '英文键盘工具列背景颜色': getCascadedToolbarBg('keyboard26Alphabetic', 'light', '#D0D3DA01'),
    '英文键盘工具列按钮颜色': getCascadedToolbarButtonColor('keyboard26Alphabetic', 'light', '#666666'),

    // === 介面與其他 ===
    '底边缘顏色-普通': getCascadedShadow('keyboard26Chinese', 'alphabet', 'light', 'normal', '#9a9c9a'),
    '底边缘顏色-高亮': getCascadedShadow('keyboard26Chinese', 'alphabet', 'light', 'highlight', '#9a9c9a'),
    '边框颜色-普通': getCascadedBorderColor('keyboard26Chinese', 'alphabet', 'light', '#FFFFFF'),
    '边框颜色-高亮': getCascadedBorderColor('keyboard26Chinese', 'alphabet', 'light', '#FFFFFF'),
    '边框宽度': getCascadedBorderSize('keyboard26Chinese', 'alphabet', 'light', 0),
    '键盘背景顏色': paletteColor('light', 'bg', '#D0D3DA01'),
    '26键键盘背景顏色': getCascadedKeyboardBg('keyboard26Chinese', 'light', '#D0D3DA01'),
    '26键键盘工具列背景顏色': getCascadedToolbarBg('keyboard26Chinese', 'light', '#D0D3DA01'),
    '26键键盘工具列按鈕顏色': getCascadedToolbarButtonColor('keyboard26Chinese', 'light', '#666666'),
    '候選字體選中字體顏色': getCascadedCandidateColor('keyboard26Chinese', 'selectedText', 'light', 'candidateSelectedText', '#000000'),
    '候選字體未選中字體顏色': getCascadedCandidateColor('keyboard26Chinese', 'unselectedText', 'light', 'candidateUnselectedText', '#000000'),
    '選中候選背景顏色': getCascadedCandidateColor('keyboard26Chinese', 'selectedBackground', 'light', 'candidateSelectedBg', '#FFFFFF'),
    'toolbar文字按鍵顏色': paletteColor('light', 'toolbarColor', '#666666'),
    'toolbar符號按鍵顏色': paletteColor('light', 'toolbarColor', '#666666'),
    '工具列文字顏色': paletteColor('light', 'toolbarColor', '#666666'),
    '工具列符號顏色': paletteColor('light', 'toolbarColor', '#666666'),
    '上滑提示文字顏色': getCascadedNestedProperty('keyboard26Chinese', 'alphabet', 'swipeHint', 'color', 'light', 'textSub', '#00000055'),
    '下滑提示文字顏色': getCascadedNestedProperty('keyboard26Chinese', 'alphabet', 'swipeHint', 'color', 'light', 'textSub', '#00000055'),
    '英文上滑提示文字顏色': getCascadedNestedProperty('keyboard26Alphabetic', 'alphabet', 'swipeHint', 'color', 'light', 'textSub', '#00000055'),
    '英文下滑提示文字顏色': getCascadedNestedProperty('keyboard26Alphabetic', 'alphabet', 'swipeHint', 'color', 'light', 'textSub', '#00000055'),
    '九宮格上滑提示文字顏色': getCascadedNestedProperty('numeric', 'numbers', 'swipeHint', 'color', 'light', 'textSub', '#00000055'),
    
    // 固定值
    '气泡背景顏色': '#ffffff',
    '气泡边缘顏色': '#606060',
    '气泡高亮顏色': '#007AFF',
    '长按选中字体顏色': getCascadedBubbleTextColor('keyboard26Chinese', 'selected', 'light', 'bubbleTextSelected', '#FFFFFF'),
    '长按非选中字体顏色': getCascadedBubbleTextColor('keyboard26Chinese', 'unselected', 'light', 'bubbleTextUnselected', '#000000'),
    '长按选中背景顏色': '#007AFF',
    '长按背景阴影顏色': '#797B7E',
    '长按背景顏色': '#FFFFFF',
    '按键边缘顏色': '#C7C7CC',
    '面板按键前景顏色': '#000000',
    '按下气泡文字顏色': getCascadedBubbleTextColor('keyboard26Chinese', 'unselected', 'light', 'bubbleTextUnselected', '#000000'),
    '划动气泡文字顏色': getCascadedBubbleTextColor('keyboard26Chinese', 'unselected', 'light', 'bubbleTextUnselected', '#000000'),
    
    // Row 數字鍵盤專用氣泡文字顏色
    'Row数字键盘按下气泡文字顏色': getCascadedBubbleTextColor('numericRow', 'unselected', 'light', 'bubbleTextUnselected', '#000000'),
    'Row数字键盘划动气泡文字顏色': getCascadedBubbleTextColor('numericRow', 'unselected', 'light', 'bubbleTextUnselected', '#000000'),
    'Row数字键盘长按选中字体顏色': getCascadedBubbleTextColor('numericRow', 'selected', 'light', 'bubbleTextSelected', '#FFFFFF'),
    'Row数字键盘长按非选中字体顏色': getCascadedBubbleTextColor('numericRow', 'unselected', 'light', 'bubbleTextUnselected', '#000000'),
    
    // Row 符號鍵盤專用氣泡文字顏色
    'Row符號键盘按下气泡文字顏色': getCascadedBubbleTextColor('symbolicRow', 'unselected', 'light', 'bubbleTextUnselected', '#000000'),
    'Row符號键盘划动气泡文字顏色': getCascadedBubbleTextColor('symbolicRow', 'unselected', 'light', 'bubbleTextUnselected', '#000000'),
    'Row符號键盘长按选中字体顏色': getCascadedBubbleTextColor('symbolicRow', 'selected', 'light', 'bubbleTextSelected', '#FFFFFF'),
    'Row符號键盘长按非选中字体顏色': getCascadedBubbleTextColor('symbolicRow', 'unselected', 'light', 'bubbleTextUnselected', '#000000'),
  },
  dark: {

    // ==== 空白鍵專屬樣式 (Layer 3: spaceKey) ====
    '空白键背景颜色-普通': getCascadedColor('spaceKey', 'background', 'keySpace', 'dark', '#D1D1D165', 'normal'),
    '空白键背景颜色-高亮': getCascadedColor('spaceKey', 'background', 'keySpaceHighlight', 'dark', '#D1D1D624', 'highlight'),
    '空白键阴影颜色-普通': getCascadedShadow('spaceKey', 'background', 'dark', 'normal', '#1E1E1E'),
    '空白键阴影颜色-高亮': getCascadedShadow('spaceKey', 'background', 'dark', 'highlight', '#1E1E1E'),
    '空白键边框颜色': getCascadedBorderColor('spaceKey', 'background', 'dark', '#D1D1D165'),
    '空白键边框宽度': getCascadedBorderSize('spaceKey', 'background', 'dark', 0),

    // === 字母鍵/一般鍵 (keyboard26, numeric) ===
    '字母键背景颜色-普通': getCascadedColor('keyboard26Chinese', 'alphabet', 'keyNormal', 'dark', '#D1D1D165', 'normal'),
    '字母键背景颜色-高亮': getCascadedColor('keyboard26Chinese', 'alphabet', 'keyNormalHighlight', 'dark', '#D1D1D624', 'highlight'),
    '按键前景颜色': getCascadedTextColor('keyboard26Chinese', 'alphabet', 'textMain', 'dark', '#FFFFFF'),
    '按键文字颜色': getCascadedTextColor('keyboard26Chinese', 'alphabet', 'textMain', 'dark', '#FFFFFF'),
    '空白键文字颜色': getCascadedTextColor('keyboard26Chinese', 'spaceKey', 'textSpace', 'dark', '#FFFFFF'),
    '字母键边框顏色-普通': getCascadedBorderColor('keyboard26Chinese', 'alphabet', 'dark', '#D1D1D165'),
    '字母键边框顏色-高亮': getCascadedBorderColor('keyboard26Chinese', 'alphabet', 'dark', '#D1D1D165'),
    '字母键边框宽度': getCascadedBorderSize('keyboard26Chinese', 'alphabet', 'dark', 0),

    // === 系統功能鍵 ===
    '功能键背景颜色-普通': getCascadedColor('keyboard26Chinese', 'systemKeys', 'keySystem', 'dark', '#D1D1D624', 'normal'),
    '功能键背景颜色-高亮': getCascadedColor('keyboard26Chinese', 'systemKeys', 'keySystemHighlight', 'dark', '#D1D1D659', 'highlight'),
    '系统功能键文字顏色': getCascadedTextColor('keyboard26Chinese', 'systemKeys', 'textSystem', 'dark', '#FFFFFF'),
    '系统功能键边框顏色-普通': getCascadedSystemBorderColor('keyboard26Chinese', 'systemKeys', 'dark', '#D1D1D165'),
    '系统功能键边框顏色-高亮': getCascadedSystemBorderColor('keyboard26Chinese', 'systemKeys', 'dark', '#D1D1D165'),
    '系统功能键边框宽度': getCascadedSystemBorderSize('keyboard26Chinese', 'systemKeys', 'dark', 0),

    // === Enter 鍵 ===
    'enter键背景颜色-普通': getCascadedColor('keyboard26Chinese', 'enterKey', 'keyEnter', 'dark', '#D1D1D624', 'normal'),
    'enter键背景颜色-高亮': getCascadedColor('keyboard26Chinese', 'enterKey', 'keyEnterHighlight', 'dark', '#D1D1D659', 'highlight'),
    'enter键文字颜色': getCascadedTextColor('keyboard26Chinese', 'enterKey', 'textEnter', 'dark', '#FFFFFF'),
    'enter键边框顏色-普通': getCascadedEnterBorderColor('keyboard26Chinese', 'enterKey', 'dark', '#D1D1D165'),
    'enter键边框顏色-高亮': getCascadedEnterBorderColor('keyboard26Chinese', 'enterKey', 'dark', '#D1D1D165'),
    'enter键边框宽度': getCascadedEnterBorderSize('keyboard26Chinese', 'enterKey', 'dark', 0),

    // === 數字鍵盤 (九宮格) ===
    '数字键文字颜色': getCascadedTextColor('numeric', 'numbers', 'textMain', 'dark', '#FFFFFF'),
    '数字键背景颜色-普通': getCascadedColor('numeric', 'numbers', 'keyNormal', 'dark', '#D1D1D165', 'normal'),
    '数字键背景颜色-高亮': getCascadedColor('numeric', 'numbers', 'keyNormalHighlight', 'dark', '#D1D1D624', 'highlight'),
    '数字键底边缘颜色-普通': getCascadedShadow('numeric', 'numbers', 'dark', 'normal', '#1E1E1E'),
    '数字键底边缘颜色-高亮': getCascadedShadow('numeric', 'numbers', 'dark', 'highlight', '#1E1E1E'),
    '数字键边框颜色-普通': getCascadedBorderColor('numeric', 'numbers', 'dark', '#D1D1D165'),
    '数字键边框颜色-高亮': getCascadedBorderColor('numeric', 'numbers', 'dark', '#D1D1D165'),
    '数字键边框宽度': getCascadedBorderSize('numeric', 'numbers', 'dark', 0),
    '数字键盘左侧collection背景顏色': getCascadedColor('numeric', 'leftPanel', 'numericLeftPanelBg', 'dark', '#D1D1D624', 'normal'),
    '数字键盘左侧collection背景下边缘顏色': getCascadedPanelShadow('numeric', 'leftPanel', 'dark', 'numericLeftPanelShadow', '#1E1E1E'),
    '数字键盘左侧collection边框颜色': getCascadedPanelBorderColor('numeric', 'leftPanel', 'dark', 'numericLeftPanelBorder', '#D1D1D165'),
    '数字键盘左侧collection边框宽度': getCascadedPanelBorderSize('numeric', 'leftPanel', 'dark', 'numericLeftPanelBorderSize', 0),
    
    // 數字鍵盤系統功能鍵 (返回, #+=, 空格, Delete, ., =)
    '数字键盘功能键背景颜色-普通': getCascadedColor('numeric', 'systemKeys', 'keySystem', 'dark', '#D1D1D624', 'normal'),
    '数字键盘功能键背景颜色-高亮': getCascadedColor('numeric', 'systemKeys', 'keySystemHighlight', 'dark', '#D1D1D659', 'highlight'),
    '数字键盘功能键文字颜色': getCascadedTextColor('numeric', 'systemKeys', 'textSystem', 'dark', '#FFFFFF'),
    '数字键盘功能键底边缘颜色-普通': getCascadedSystemShadow('numeric', 'systemKeys', 'dark', 'normal', '#1E1E1E'),
    '数字键盘功能键底边缘颜色-高亮': getCascadedSystemShadow('numeric', 'systemKeys', 'dark', 'highlight', '#1E1E1E'),
    '数字键盘功能键边框颜色-普通': getCascadedSystemBorderColor('numeric', 'systemKeys', 'dark', '#D1D1D165'),
    '数字键盘功能键边框颜色-高亮': getCascadedSystemBorderColor('numeric', 'systemKeys', 'dark', '#D1D1D165'),
    '数字键盘功能键边框宽度': getCascadedSystemBorderSize('numeric', 'systemKeys', 'dark', 0),
    
    // 數字鍵盤 Enter 鍵專用
    '数字键盘enter键背景颜色-普通': getCascadedColor('numeric', 'enterKey', 'keyEnter', 'dark', '#D1D1D624', 'normal'),
    '数字键盘enter键背景颜色-高亮': getCascadedColor('numeric', 'enterKey', 'keyEnterHighlight', 'dark', '#D1D1D659', 'highlight'),
    '数字键盘enter键文字颜色': getCascadedTextColor('numeric', 'enterKey', 'textEnter', 'dark', '#FFFFFF'),
    '数字键盘enter键底边缘颜色-普通': getCascadedEnterShadow('numeric', 'enterKey', 'dark', 'normal', '#1E1E1E'),
    '数字键盘enter键底边缘颜色-高亮': getCascadedEnterShadow('numeric', 'enterKey', 'dark', 'highlight', '#1E1E1E'),
    '数字键盘enter键边框颜色-普通': getCascadedEnterBorderColor('numeric', 'enterKey', 'dark', '#D1D1D165'),
    '数字键盘enter键边框颜色-高亮': getCascadedEnterBorderColor('numeric', 'enterKey', 'dark', '#D1D1D165'),
    '数字键盘enter键边框宽度': getCascadedEnterBorderSize('numeric', 'enterKey', 'dark', 0),
    
    // 數字鍵盤背景
    '数字键盘背景顏色': getCascadedKeyboardBg('numeric', 'dark', '#1C1C1E01'),
    '数字键盘工具列背景顏色': getCascadedToolbarBg('numeric', 'dark', '#1C1C1E01'),
    '数字键盘工具列按鈕顏色': getCascadedToolbarButtonColor('numeric', 'dark', '#CCCCCC'),

    // === 符號鍵盤 (Symbolic) ===
    '符號鍵盤左側collection字體顏色': getCascadedTextColor('symbolic', 'leftPanel', 'panelLeftText', 'dark', '#FFFFFF'),
    '符號鍵盤右側collection字體顏色': getCascadedTextColor('symbolic', 'rightPanel', 'panelRightText', 'dark', '#FFFFFF'),
    '符號鍵盤左側collection背景顏色': getCascadedColor('symbolic', 'leftPanel', 'panelLeftBg', 'dark', '#D1D1D624', 'normal'),
    '符號鍵盤左側collection背景下邊緣顏色': getCascadedPanelShadow('symbolic', 'leftPanel', 'dark', 'panelLeftShadow', '#1E1E1E'),
    '符號鍵盤左側collection邊框顏色': getCascadedPanelBorderColor('symbolic', 'leftPanel', 'dark', 'panelLeftBorder', '#D1D1D624'),
    '符號鍵盤左側collection邊框寬度': getCascadedPanelBorderSize('symbolic', 'leftPanel', 'dark', 'panelLeftBorderSize', 0),
    '符號鍵盤右側collection背景顏色': getCascadedColor('symbolic', 'rightPanel', 'panelRightBg', 'dark', '#D1D1D165', 'normal'),
    '符號鍵盤右側collection背景下邊緣顏色': getCascadedPanelShadow('symbolic', 'rightPanel', 'dark', 'panelRightShadow', '#1E1E1E'),
    '符號鍵盤右側collection邊框顏色': getCascadedPanelBorderColor('symbolic', 'rightPanel', 'dark', 'panelRightBorder', '#D1D1D165'),
    '符號鍵盤右側collection邊框寬度': getCascadedPanelBorderSize('symbolic', 'rightPanel', 'dark', 'panelRightBorderSize', 0),
    '符號鍵盤左側分類選中顏色': getCascadedSimpleProperty('symbolic', 'leftPanel', 'categoryHighlight', 'dark', 'panelCategoryHighlight', '#D1D1D624'),
    
    // 符號鍵盤系統功能鍵 (返回, 上捲, 下捲, 鎖頭, Delete)
    '符號鍵盤功能键背景颜色-普通': getCascadedColor('symbolic', 'systemKeys', 'keySystem', 'dark', '#D1D1D624', 'normal'),
    '符號鍵盤功能键背景颜色-高亮': getCascadedColor('symbolic', 'systemKeys', 'keySystemHighlight', 'dark', '#D1D1D659', 'highlight'),
    '符號鍵盤功能键文字颜色': getCascadedTextColor('symbolic', 'systemKeys', 'textSystem', 'dark', '#FFFFFF'),
    '符號鍵盤功能键底边缘颜色-普通': getCascadedSystemShadow('symbolic', 'systemKeys', 'dark', 'normal', '#1E1E1E'),
    '符號鍵盤功能键底边缘颜色-高亮': getCascadedSystemShadow('symbolic', 'systemKeys', 'dark', 'highlight', '#1E1E1E'),
    '符號鍵盤功能键边框颜色-普通': getCascadedSystemBorderColor('symbolic', 'systemKeys', 'dark', '#D1D1D165'),
    '符號鍵盤功能键边框颜色-高亮': getCascadedSystemBorderColor('symbolic', 'systemKeys', 'dark', '#D1D1D165'),
    '符號鍵盤功能键边框宽度': getCascadedSystemBorderSize('symbolic', 'systemKeys', 'dark', 0),
    // 符號鍵盤 Enter 鍵
    '符號鍵盤enter键背景颜色-普通': getCascadedColor('symbolic', 'enterKey', 'keyEnter', 'dark', '#D1D1D624', 'normal'),
    '符號鍵盤enter键背景颜色-高亮': getCascadedColor('symbolic', 'enterKey', 'keyEnterHighlight', 'dark', '#D1D1D659', 'highlight'),
    '符號鍵盤enter键文字颜色': getCascadedTextColor('symbolic', 'enterKey', 'textEnter', 'dark', '#FFFFFF'),
    '符號鍵盤enter键底边缘颜色-普通': getCascadedEnterShadow('symbolic', 'enterKey', 'dark', 'normal', '#1E1E1E'),
    '符號鍵盤enter键底边缘颜色-高亮': getCascadedEnterShadow('symbolic', 'enterKey', 'dark', 'highlight', '#1E1E1E'),
    '符號鍵盤enter键边框颜色-普通': getCascadedEnterBorderColor('symbolic', 'enterKey', 'dark', '#D1D1D165'),
    '符號鍵盤enter键边框颜色-高亮': getCascadedEnterBorderColor('symbolic', 'enterKey', 'dark', '#D1D1D165'),
    '符號鍵盤enter键边框宽度': getCascadedEnterBorderSize('symbolic', 'enterKey', 'dark', 0),
    
    // 符號鍵盤背景
    '符號键盘背景顏色': getCascadedKeyboardBg('symbolic', 'dark', '#1C1C1E01'),

    // === Emoji 鍵盤 (獨立 Override) ===
    'emoji鍵盤左側collection字體顏色': getCascadedTextColor('emoji', 'leftPanel', 'panelLeftText', 'dark', '#FFFFFF'),
    'emoji鍵盤右側collection字體顏色': getCascadedTextColor('emoji', 'rightPanel', 'panelRightText', 'dark', '#FFFFFF'),
    'emoji鍵盤左側collection背景顏色': getCascadedColor('emoji', 'leftPanel', 'panelLeftBg', 'dark', '#D1D1D624', 'normal'),
    'emoji鍵盤左側collection背景下邊緣顏色': getCascadedPanelShadow('emoji', 'leftPanel', 'dark', 'panelLeftShadow', '#1E1E1E'),
    'emoji鍵盤左側collection邊框顏色': getCascadedPanelBorderColor('emoji', 'leftPanel', 'dark', 'panelLeftBorder', '#D1D1D624'),
    'emoji鍵盤左側collection邊框寬度': getCascadedPanelBorderSize('emoji', 'leftPanel', 'dark', 'panelLeftBorderSize', 0),
    'emoji鍵盤右側collection背景顏色': getCascadedColor('emoji', 'rightPanel', 'panelRightBg', 'dark', '#D1D1D165', 'normal'),
    'emoji鍵盤右側collection背景下邊緣顏色': getCascadedPanelShadow('emoji', 'rightPanel', 'dark', 'panelRightShadow', '#1E1E1E'),
    'emoji鍵盤右側collection邊框顏色': getCascadedPanelBorderColor('emoji', 'rightPanel', 'dark', 'panelRightBorder', '#D1D1D165'),
    'emoji鍵盤右側collection邊框寬度': getCascadedPanelBorderSize('emoji', 'rightPanel', 'dark', 'panelRightBorderSize', 0),
    'emoji鍵盤左側分類選中顏色': getCascadedSimpleProperty('emoji', 'leftPanel', 'categoryHighlight', 'dark', 'panelCategoryHighlight', '#D1D1D624'),
    
    // Emoji 鍵盤系統功能鍵 (返回, 上捲, 下捲, 鎖頭, Delete)
    'emoji鍵盤功能键背景颜色-普通': getCascadedColor('emoji', 'systemKeys', 'keySystem', 'dark', '#D1D1D624', 'normal'),
    'emoji鍵盤功能键背景颜色-高亮': getCascadedColor('emoji', 'systemKeys', 'keySystemHighlight', 'dark', '#D1D1D659', 'highlight'),
    'emoji鍵盤功能键文字颜色': getCascadedTextColor('emoji', 'systemKeys', 'textSystem', 'dark', '#FFFFFF'),
    'emoji鍵盤功能键底边缘颜色-普通': getCascadedSystemShadow('emoji', 'systemKeys', 'dark', 'normal', '#1E1E1E'),
    'emoji鍵盤功能键底边缘颜色-高亮': getCascadedSystemShadow('emoji', 'systemKeys', 'dark', 'highlight', '#1E1E1E'),
    'emoji鍵盤功能键边框颜色-普通': getCascadedSystemBorderColor('emoji', 'systemKeys', 'dark', '#D1D1D165'),
    'emoji鍵盤功能键边框颜色-高亮': getCascadedSystemBorderColor('emoji', 'systemKeys', 'dark', '#D1D1D165'),
    'emoji鍵盤功能键边框宽度': getCascadedSystemBorderSize('emoji', 'systemKeys', 'dark', 0),
    // Emoji 鍵盤 Enter 鍵
    'emoji鍵盤enter键背景颜色-普通': getCascadedColor('emoji', 'enterKey', 'keyEnter', 'dark', '#D1D1D624', 'normal'),
    'emoji鍵盤enter键背景颜色-高亮': getCascadedColor('emoji', 'enterKey', 'keyEnterHighlight', 'dark', '#D1D1D659', 'highlight'),
    'emoji鍵盤enter键文字颜色': getCascadedTextColor('emoji', 'enterKey', 'textEnter', 'dark', '#FFFFFF'),
    'emoji鍵盤enter键底边缘颜色-普通': getCascadedEnterShadow('emoji', 'enterKey', 'dark', 'normal', '#1E1E1E'),
    'emoji鍵盤enter键底边缘颜色-高亮': getCascadedEnterShadow('emoji', 'enterKey', 'dark', 'highlight', '#1E1E1E'),
    'emoji鍵盤enter键边框颜色-普通': getCascadedEnterBorderColor('emoji', 'enterKey', 'dark', '#D1D1D165'),
    'emoji鍵盤enter键边框颜色-高亮': getCascadedEnterBorderColor('emoji', 'enterKey', 'dark', '#D1D1D165'),
    'emoji鍵盤enter键边框宽度': getCascadedEnterBorderSize('emoji', 'enterKey', 'dark', 0),
    
    // Emoji 鍵盤背景
    'emoji键盘背景顏色': getCascadedKeyboardBg('emoji', 'dark', '#1C1C1E01'),

    // === Kaomojis 鍵盤 (獨立 Override) ===
    'kaomojis鍵盤左側collection字體顏色': getCascadedTextColor('kaomojis', 'leftPanel', 'panelLeftText', 'dark', '#FFFFFF'),
    'kaomojis鍵盤右側collection字體顏色': getCascadedTextColor('kaomojis', 'rightPanel', 'panelRightText', 'dark', '#FFFFFF'),
    'kaomojis鍵盤左側collection背景顏色': getCascadedColor('kaomojis', 'leftPanel', 'panelLeftBg', 'dark', '#D1D1D624', 'normal'),
    'kaomojis鍵盤左側collection背景下邊緣顏色': getCascadedPanelShadow('kaomojis', 'leftPanel', 'dark', 'panelLeftShadow', '#1E1E1E'),
    'kaomojis鍵盤左側collection邊框顏色': getCascadedPanelBorderColor('kaomojis', 'leftPanel', 'dark', 'panelLeftBorder', '#D1D1D624'),
    'kaomojis鍵盤左側collection邊框寬度': getCascadedPanelBorderSize('kaomojis', 'leftPanel', 'dark', 'panelLeftBorderSize', 0),
    'kaomojis鍵盤右側collection背景顏色': getCascadedColor('kaomojis', 'rightPanel', 'panelRightBg', 'dark', '#D1D1D165', 'normal'),
    'kaomojis鍵盤右側collection背景下邊緣顏色': getCascadedPanelShadow('kaomojis', 'rightPanel', 'dark', 'panelRightShadow', '#1E1E1E'),
    'kaomojis鍵盤右側collection邊框顏色': getCascadedPanelBorderColor('kaomojis', 'rightPanel', 'dark', 'panelRightBorder', '#D1D1D165'),
    'kaomojis鍵盤右側collection邊框寬度': getCascadedPanelBorderSize('kaomojis', 'rightPanel', 'dark', 'panelRightBorderSize', 0),
    'kaomojis鍵盤左側分類選中顏色': getCascadedSimpleProperty('kaomojis', 'leftPanel', 'categoryHighlight', 'dark', 'panelCategoryHighlight', '#D1D1D624'),
    
    // Kaomojis 鍵盤系統功能鍵 (返回, 上捲, 下捲, 鎖頭, Delete)
    'kaomojis鍵盤功能键背景颜色-普通': getCascadedColor('kaomojis', 'systemKeys', 'keySystem', 'dark', '#D1D1D624', 'normal'),
    'kaomojis鍵盤功能键背景颜色-高亮': getCascadedColor('kaomojis', 'systemKeys', 'keySystemHighlight', 'dark', '#D1D1D659', 'highlight'),
    'kaomojis鍵盤功能键文字颜色': getCascadedTextColor('kaomojis', 'systemKeys', 'textSystem', 'dark', '#FFFFFF'),
    'kaomojis鍵盤功能键底边缘颜色-普通': getCascadedSystemShadow('kaomojis', 'systemKeys', 'dark', 'normal', '#1E1E1E'),
    'kaomojis鍵盤功能键底边缘颜色-高亮': getCascadedSystemShadow('kaomojis', 'systemKeys', 'dark', 'highlight', '#1E1E1E'),
    'kaomojis鍵盤功能键边框颜色-普通': getCascadedSystemBorderColor('kaomojis', 'systemKeys', 'dark', '#D1D1D165'),
    'kaomojis鍵盤功能键边框颜色-高亮': getCascadedSystemBorderColor('kaomojis', 'systemKeys', 'dark', '#D1D1D165'),
    'kaomojis鍵盤功能键边框宽度': getCascadedSystemBorderSize('kaomojis', 'systemKeys', 'dark', 0),
    // Kaomojis 鍵盤 Enter 鍵
    'kaomojis鍵盤enter键背景颜色-普通': getCascadedColor('kaomojis', 'enterKey', 'keyEnter', 'dark', '#D1D1D624', 'normal'),
    'kaomojis鍵盤enter键背景颜色-高亮': getCascadedColor('kaomojis', 'enterKey', 'keyEnterHighlight', 'dark', '#D1D1D659', 'highlight'),
    'kaomojis鍵盤enter键文字颜色': getCascadedTextColor('kaomojis', 'enterKey', 'textEnter', 'dark', '#FFFFFF'),
    'kaomojis鍵盤enter键底边缘颜色-普通': getCascadedEnterShadow('kaomojis', 'enterKey', 'dark', 'normal', '#1E1E1E'),
    'kaomojis鍵盤enter键底边缘颜色-高亮': getCascadedEnterShadow('kaomojis', 'enterKey', 'dark', 'highlight', '#1E1E1E'),
    'kaomojis鍵盤enter键边框颜色-普通': getCascadedEnterBorderColor('kaomojis', 'enterKey', 'dark', '#D1D1D165'),
    'kaomojis鍵盤enter键边框颜色-高亮': getCascadedEnterBorderColor('kaomojis', 'enterKey', 'dark', '#D1D1D165'),
    'kaomojis鍵盤enter键边框宽度': getCascadedEnterBorderSize('kaomojis', 'enterKey', 'dark', 0),
    
    // Kaomojis 鍵盤背景
    'kaomojis键盘背景顏色': getCascadedKeyboardBg('kaomojis', 'dark', '#1C1C1E01'),

    // === Row 數字鍵盤 (獨立 Override) ===
    'Row数字键文字颜色': getCascadedTextColor('numericRow', 'numbers', 'textMain', 'dark', '#FFFFFF'),
    'Row数字键背景颜色-普通': getCascadedColor('numericRow', 'numbers', 'keyNormal', 'dark', '#D1D1D165', 'normal'),
    'Row数字键背景颜色-高亮': getCascadedColor('numericRow', 'numbers', 'keyNormalHighlight', 'dark', '#D1D1D624', 'highlight'),
    'Row数字键底边缘颜色-普通': getCascadedShadow('numericRow', 'numbers', 'dark', 'normal', '#1E1E1E'),
    'Row数字键底边缘颜色-高亮': getCascadedShadow('numericRow', 'numbers', 'dark', 'highlight', '#1E1E1E'),
    'Row数字键边框颜色-普通': getCascadedBorderColor('numericRow', 'numbers', 'dark', '#D1D1D165'),
    'Row数字键边框颜色-高亮': getCascadedBorderColor('numericRow', 'numbers', 'dark', '#D1D1D165'),
    'Row数字键边框宽度': getCascadedBorderSize('numericRow', 'numbers', 'dark', 0),
    'Row数字键盘功能键背景颜色-普通': getCascadedColor('numericRow', 'systemKeys', 'keySystem', 'dark', '#D1D1D624', 'normal'),
    'Row数字键盘功能键背景颜色-高亮': getCascadedColor('numericRow', 'systemKeys', 'keySystemHighlight', 'dark', '#D1D1D659', 'highlight'),
    'Row数字键盘功能键文字颜色': getCascadedTextColor('numericRow', 'systemKeys', 'textSystem', 'dark', '#FFFFFF'),
    'Row数字键盘功能键底边缘颜色-普通': getCascadedSystemShadow('numericRow', 'systemKeys', 'dark', 'normal', '#1E1E1E'),
    'Row数字键盘功能键底边缘颜色-高亮': getCascadedSystemShadow('numericRow', 'systemKeys', 'dark', 'highlight', '#1E1E1E'),
    'Row数字键盘功能键边框颜色-普通': getCascadedSystemBorderColor('numericRow', 'systemKeys', 'dark', '#D1D1D165'),
    'Row数字键盘功能键边框颜色-高亮': getCascadedSystemBorderColor('numericRow', 'systemKeys', 'dark', '#D1D1D165'),
    'Row数字键盘功能键边框宽度': getCascadedSystemBorderSize('numericRow', 'systemKeys', 'dark', 0),
    'Row数字键盘enter键背景颜色-普通': getCascadedColor('numericRow', 'enterKey', 'keyEnter', 'dark', '#D1D1D624', 'normal'),
    'Row数字键盘enter键背景颜色-高亮': getCascadedColor('numericRow', 'enterKey', 'keyEnterHighlight', 'dark', '#D1D1D659', 'highlight'),
    'Row数字键盘enter键文字颜色': getCascadedTextColor('numericRow', 'enterKey', 'textEnter', 'dark', '#FFFFFF'),
    'Row数字键盘enter键底边缘颜色-普通': getCascadedEnterShadow('numericRow', 'enterKey', 'dark', 'normal', '#1E1E1E'),
    'Row数字键盘enter键底边缘颜色-高亮': getCascadedEnterShadow('numericRow', 'enterKey', 'dark', 'highlight', '#1E1E1E'),
    'Row数字键盘enter键边框颜色-普通': getCascadedEnterBorderColor('numericRow', 'enterKey', 'dark', '#D1D1D165'),
    'Row数字键盘enter键边框颜色-高亮': getCascadedEnterBorderColor('numericRow', 'enterKey', 'dark', '#D1D1D165'),
    'Row数字键盘enter键边框宽度': getCascadedEnterBorderSize('numericRow', 'enterKey', 'dark', 0),
    
    // Row 數字鍵盤空白鍵專屬（繼承全局 spaceKey）
    'Row数字键盘空白键背景颜色-普通': getCascadedColor('numericRow', 'spaceKey', 'keySpace', 'dark', '#D1D1D165', 'normal'),
    'Row数字键盘空白键背景颜色-高亮': getCascadedColor('numericRow', 'spaceKey', 'keySpaceHighlight', 'dark', '#D1D1D624', 'highlight'),
    'Row数字键盘空白键阴影颜色-普通': getCascadedShadow('numericRow', 'spaceKey', 'dark', 'normal', '#1E1E1E'),
    'Row数字键盘空白键阴影颜色-高亮': getCascadedShadow('numericRow', 'spaceKey', 'dark', 'highlight', '#1E1E1E'),
    'Row数字键盘空白键边框颜色': getCascadedBorderColor('numericRow', 'spaceKey', 'dark', '#D1D1D165'),
    'Row数字键盘空白键边框宽度': getCascadedBorderSize('numericRow', 'spaceKey', 'dark', 0),
    'Row数字键盘空白键文字颜色': getCascadedTextColor('numericRow', 'spaceKey', 'textSpace', 'dark', '#FFFFFF'),

    'Row数字键盘背景顏色': getCascadedKeyboardBg('numericRow', 'dark', '#1C1C1E01'),
    'Row数字键盘工具列背景顏色': getCascadedToolbarBg('numericRow', 'dark', '#1C1C1E01'),
    'Row数字键盘工具列按鈕顏色': getCascadedToolbarButtonColor('numericRow', 'dark', '#CCCCCC'),

    // === Row 符號鍵盤 (獨立 Override) ===
    'Row符號鍵盤右側collection字體顏色': getCascadedTextColor('symbolicRow', 'symbols', 'textMain', 'dark', '#FFFFFF'),
    'Row符號鍵盤右側collection背景顏色': getCascadedColor('symbolicRow', 'symbols', 'keyNormal', 'dark', '#D1D1D165', 'normal'),
    'Row符號鍵盤右側collection背景顏色-高亮': getCascadedColor('symbolicRow', 'symbols', 'keyNormalHighlight', 'dark', '#D1D1D624', 'highlight'),
    'Row符號鍵盤右側collection背景下邊緣顏色': getCascadedShadow('symbolicRow', 'symbols', 'dark', 'normal', '#1E1E1E'),
    'Row符號鍵盤右側collection邊框顏色': getCascadedBorderColor('symbolicRow', 'symbols', 'dark', '#D1D1D165'),
    'Row符號鍵盤右側collection邊框寬度': getCascadedBorderSize('symbolicRow', 'symbols', 'dark', 0),    'Row符號鍵盤功能键背景颜色-普通': getCascadedColor('symbolicRow', 'systemKeys', 'keySystem', 'dark', '#D1D1D624', 'normal'),
    'Row符號鍵盤功能键背景颜色-高亮': getCascadedColor('symbolicRow', 'systemKeys', 'keySystemHighlight', 'dark', '#D1D1D659', 'highlight'),
    'Row符號鍵盤功能键文字颜色': getCascadedTextColor('symbolicRow', 'systemKeys', 'textSystem', 'dark', '#FFFFFF'),
    'Row符號鍵盤功能键底边缘颜色-普通': getCascadedSystemShadow('symbolicRow', 'systemKeys', 'dark', 'normal', '#1E1E1E'),
    'Row符號鍵盤功能键底边缘颜色-高亮': getCascadedSystemShadow('symbolicRow', 'systemKeys', 'dark', 'highlight', '#1E1E1E'),
    'Row符號鍵盤功能键边框颜色-普通': getCascadedSystemBorderColor('symbolicRow', 'systemKeys', 'dark', '#D1D1D165'),
    'Row符號鍵盤功能键边框颜色-高亮': getCascadedSystemBorderColor('symbolicRow', 'systemKeys', 'dark', '#D1D1D165'),
    'Row符號鍵盤功能键边框宽度': getCascadedSystemBorderSize('symbolicRow', 'systemKeys', 'dark', 0),
    
    // Row 符號鍵盤 Enter 鍵專用（深綠色）
    'Row符號鍵盤enter键背景颜色-普通': getCascadedColor('symbolicRow', 'enterKey', 'keyEnter', 'dark', '#D1D1D624', 'normal'),
    'Row符號鍵盤enter键背景颜色-高亮': getCascadedColor('symbolicRow', 'enterKey', 'keyEnterHighlight', 'dark', '#D1D1D659', 'highlight'),
    'Row符號鍵盤enter键文字颜色': getCascadedTextColor('symbolicRow', 'enterKey', 'textEnter', 'dark', '#FFFFFF'),
    'Row符號鍵盤enter键底边缘颜色-普通': getCascadedEnterShadow('symbolicRow', 'enterKey', 'dark', 'normal', '#1E1E1E'),
    'Row符號鍵盤enter键底边缘颜色-高亮': getCascadedEnterShadow('symbolicRow', 'enterKey', 'dark', 'highlight', '#1E1E1E'),
    'Row符號鍵盤enter键边框颜色-普通': getCascadedEnterBorderColor('symbolicRow', 'enterKey', 'dark', '#1B5E20'),
    'Row符號鍵盤enter键边框颜色-高亮': getCascadedEnterBorderColor('symbolicRow', 'enterKey', 'dark', '#1B5E20'),
    'Row符號鍵盤enter键边框宽度': getCascadedEnterBorderSize('symbolicRow', 'enterKey', 'dark', 0),
    
    // Row 符號鍵盤空白鍵專屬（繼承全局 spaceKey）
    'Row符號键盘空白键背景颜色-普通': getCascadedColor('symbolicRow', 'spaceKey', 'keySpace', 'dark', '#D1D1D165', 'normal'),
    'Row符號键盘空白键背景颜色-高亮': getCascadedColor('symbolicRow', 'spaceKey', 'keySpaceHighlight', 'dark', '#D1D1D624', 'highlight'),
    'Row符號键盘空白键阴影颜色-普通': getCascadedShadow('symbolicRow', 'spaceKey', 'dark', 'normal', '#1E1E1E'),
    'Row符號键盘空白键阴影颜色-高亮': getCascadedShadow('symbolicRow', 'spaceKey', 'dark', 'highlight', '#1E1E1E'),
    'Row符號键盘空白键边框颜色': getCascadedBorderColor('symbolicRow', 'spaceKey', 'dark', '#D1D1D165'),
    'Row符號键盘空白键边框宽度': getCascadedBorderSize('symbolicRow', 'spaceKey', 'dark', 0),
    'Row符號键盘空白键文字颜色': getCascadedTextColor('symbolicRow', 'spaceKey', 'textSpace', 'dark', '#FFFFFF'),

    'Row符號键盘背景顏色': getCascadedKeyboardBg('symbolicRow', 'dark', '#1C1C1E01'),
    'Row符號键盘工具列背景顏色': getCascadedToolbarBg('symbolicRow', 'dark', '#1C1C1E01'),
    'Row符號键盘工具列按鈕顏色': getCascadedToolbarButtonColor('symbolicRow', 'dark', '#CCCCCC'),

    // === 注音鍵盤 (Bopomofo) ===
    // 莫蘭迪紫色配色
    '注音符號键背景颜色-普通': getCascadedColor('bopomofo', 'bpmfKeys', 'keyNormal', 'dark', '#D1D1D165', 'normal'),
    '注音符號键背景颜色-高亮': getCascadedColor('bopomofo', 'bpmfKeys', 'keyNormalHighlight', 'dark', '#D1D1D624', 'highlight'),
    '注音符號键文字颜色': getCascadedTextColor('bopomofo', 'bpmfKeys', 'textMain', 'dark', '#FFFFFF'),
    '注音符號键底边缘颜色-普通': getCascadedShadow('bopomofo', 'bpmfKeys', 'dark', 'normal', '#1E1E1E'),
    '注音符號键底边缘颜色-高亮': getCascadedShadow('bopomofo', 'bpmfKeys', 'dark', 'highlight', '#1E1E1E'),
    '注音符號键边框颜色-普通': getCascadedBorderColor('bopomofo', 'bpmfKeys', 'dark', '#D1D1D165'),
    '注音符號键边框颜色-高亮': getCascadedBorderColor('bopomofo', 'bpmfKeys', 'dark', '#D1D1D165'),
    '注音符號键边框宽度': getCascadedBorderSize('bopomofo', 'bpmfKeys', 'dark', 0),
    
    // 注音鍵盤系統功能鍵 (返回, 直出, 輸入, Backspace)
    '注音功能键背景颜色-普通': getCascadedColor('bopomofo', 'systemKeys', 'keySystem', 'dark', '#D1D1D624', 'normal'),
    '注音功能键背景颜色-高亮': getCascadedColor('bopomofo', 'systemKeys', 'keySystemHighlight', 'dark', '#D1D1D659', 'highlight'),
    '注音功能键文字颜色': getCascadedTextColor('bopomofo', 'systemKeys', 'textSystem', 'dark', '#FFFFFF'),
    '注音功能键底边缘颜色-普通': getCascadedSystemShadow('bopomofo', 'systemKeys', 'dark', 'normal', '#1E1E1E'),
    '注音功能键底边缘颜色-高亮': getCascadedSystemShadow('bopomofo', 'systemKeys', 'dark', 'highlight', '#1E1E1E'),
    '注音功能键边框颜色-普通': getCascadedSystemBorderColor('bopomofo', 'systemKeys', 'dark', '#D1D1D165'),
    '注音功能键边框颜色-高亮': getCascadedSystemBorderColor('bopomofo', 'systemKeys', 'dark', '#D1D1D165'),
    '注音功能键边框宽度': getCascadedSystemBorderSize('bopomofo', 'systemKeys', 'dark', 0),
    
    // 注音鍵盤 Enter 鍵
    '注音enter键背景颜色-普通': getCascadedColor('bopomofo', 'enterKey', 'keyEnter', 'dark', '#D1D1D624', 'normal'),
    '注音enter键背景颜色-高亮': getCascadedColor('bopomofo', 'enterKey', 'keyEnterHighlight', 'dark', '#D1D1D659', 'highlight'),
    '注音enter键文字颜色': getCascadedTextColor('bopomofo', 'enterKey', 'textEnter', 'dark', '#FFFFFF'),
    '注音enter键底边缘颜色-普通': getCascadedEnterShadow('bopomofo', 'enterKey', 'dark', 'normal', '#1E1E1E'),
    '注音enter键底边缘颜色-高亮': getCascadedEnterShadow('bopomofo', 'enterKey', 'dark', 'highlight', '#1E1E1E'),
    '注音enter键边框颜色-普通': getCascadedEnterBorderColor('bopomofo', 'enterKey', 'dark', '#D1D1D165'),
    '注音enter键边框颜色-高亮': getCascadedEnterBorderColor('bopomofo', 'enterKey', 'dark', '#D1D1D165'),
    '注音enter键边框宽度': getCascadedEnterBorderSize('bopomofo', 'enterKey', 'dark', 0),
    
    // 注音鍵盤 Space 鍵
    '注音空白键文字颜色': getCascadedTextColor('bopomofo', 'spaceKey', 'textSpace', 'dark', '#FFFFFF'),
    
    // 注音鍵盤氣泡文字顏色
    '注音按下气泡文字颜色': getCascadedBubbleTextColor('bopomofo', 'unselected', 'dark', 'bubbleTextUnselected', '#FFFFFF'),
    '注音长按选中字体顏色': getCascadedBubbleTextColor('bopomofo', 'selected', 'dark', 'bubbleTextSelected', '#FFFFFF'),
    '注音长按非选中字体顏色': getCascadedBubbleTextColor('bopomofo', 'unselected', 'dark', 'bubbleTextUnselected', '#FFFFFF'),
    
    // 注音鍵盤背景
    '注音键盘背景颜色': getCascadedKeyboardBg('bopomofo', 'dark', '#47474701'),
    '注音键盘工具列背景颜色': getCascadedToolbarBg('bopomofo', 'dark', '#47474701'),
    '注音键盘工具列按钮颜色': getCascadedToolbarButtonColor('bopomofo', 'dark', '#CCCCCC'),
    
    // 注音鍵盤候選字顏色
    '注音候選字體選中字體顏色': getCascadedCandidateColor('bopomofo', 'selectedText', 'dark', 'candidateSelectedText', '#FFFFFF'),
    '注音候選字體未選中字體顏色': getCascadedCandidateColor('bopomofo', 'unselectedText', 'dark', 'candidateUnselectedText', '#FFFFFF'),
    '注音選中候選背景顏色': getCascadedCandidateColor('bopomofo', 'selectedBackground', 'dark', 'candidateSelectedBg', '#D1D1D165'),
    
    // Row 數字鍵盤候選字顏色（九宮格和 Row 數字鍵盤共用，查 numeric override）
    'Row數字候選字體選中字體顏色': getCascadedCandidateColor('numeric', 'selectedText', 'dark', 'candidateSelectedText', '#FFFFFF'),
    'Row數字候選字體未選中字體顏色': getCascadedCandidateColor('numeric', 'unselectedText', 'dark', 'candidateUnselectedText', '#FFFFFF'),
    'Row數字選中候選背景顏色': getCascadedCandidateColor('numeric', 'selectedBackground', 'dark', 'candidateSelectedBg', '#D1D1D165'),
    
    // Row 符號鍵盤候選字顏色
    'Row符號候選字體選中字體顏色': getCascadedCandidateColor('symbolicRow', 'selectedText', 'dark', 'candidateSelectedText', '#FFFFFF'),
    'Row符號候選字體未選中字體顏色': getCascadedCandidateColor('symbolicRow', 'unselectedText', 'dark', 'candidateUnselectedText', '#FFFFFF'),
    'Row符號選中候選背景顏色': getCascadedCandidateColor('symbolicRow', 'selectedBackground', 'dark', 'candidateSelectedBg', '#D1D1D165'),
    
    // 英文鍵盤候選字顏色
    '英文候選字體選中字體顏色': getCascadedCandidateColor('keyboard26Alphabetic', 'selectedText', 'dark', 'candidateSelectedText', '#FFFFFF'),
    '英文候選字體未選中字體顏色': getCascadedCandidateColor('keyboard26Alphabetic', 'unselectedText', 'dark', 'candidateUnselectedText', '#FFFFFF'),
    '英文選中候選背景顏色': getCascadedCandidateColor('keyboard26Alphabetic', 'selectedBackground', 'dark', 'candidateSelectedBg', '#D1D1D165'),
    
    // 各鍵盤候選控制按鈕文字顏色（展開候選字後的四個系統鍵）
    'Row數字候選控制按鈕文字顏色': getCascadedTextColor('numeric', 'systemKeys', 'textSystem', 'dark', '#FFFFFF'),
    'Row符號候選控制按鈕文字顏色': getCascadedTextColor('symbolicRow', 'systemKeys', 'textSystem', 'dark', '#FFFFFF'),
    '英文候選控制按鈕文字顏色': getCascadedTextColor('keyboard26Alphabetic', 'systemKeys', 'textSystem', 'dark', '#FFFFFF'),
    
    // 注音鍵盤候選字控制按鈕文字顏色（展開候選字後的四個系統鍵）
    '注音候選控制按鈕文字顏色': getCascadedTextColor('bopomofo', 'systemKeys', 'textSystem', 'dark', '#FFFFFF'),

    // === 英文鍵盤 (Alphabetic) ===
    // 莫蘭迪靛色配色
    '英文字母键背景颜色-普通': getCascadedColor('keyboard26Alphabetic', 'alphabet', 'keyNormal', 'dark', '#D1D1D165', 'normal'),
    '英文字母键背景颜色-高亮': getCascadedColor('keyboard26Alphabetic', 'alphabet', 'keyNormalHighlight', 'dark', '#D1D1D624', 'highlight'),
    '英文字母键文字颜色': getCascadedTextColor('keyboard26Alphabetic', 'alphabet', 'textMain', 'dark', '#FFFFFF'),
    '英文字母键底边缘颜色-普通': getCascadedShadow('keyboard26Alphabetic', 'alphabet', 'dark', 'normal', '#1E1E1E'),
    '英文字母键底边缘颜色-高亮': getCascadedShadow('keyboard26Alphabetic', 'alphabet', 'dark', 'highlight', '#1E1E1E'),
    '英文字母键边框颜色-普通': getCascadedBorderColor('keyboard26Alphabetic', 'alphabet', 'dark', '#D1D1D165'),
    '英文字母键边框颜色-高亮': getCascadedBorderColor('keyboard26Alphabetic', 'alphabet', 'dark', '#D1D1D165'),
    '英文字母键边框宽度': getCascadedBorderSize('keyboard26Alphabetic', 'alphabet', 'dark', 0),
    
    // 英文鍵盤系統功能鍵 (Shift, 123, Delete)
    '英文功能键背景颜色-普通': getCascadedColor('keyboard26Alphabetic', 'systemKeys', 'keySystem', 'dark', '#D1D1D624', 'normal'),
    '英文功能键背景颜色-高亮': getCascadedColor('keyboard26Alphabetic', 'systemKeys', 'keySystemHighlight', 'dark', '#D1D1D659', 'highlight'),
    '英文功能键文字颜色': getCascadedTextColor('keyboard26Alphabetic', 'systemKeys', 'textSystem', 'dark', '#FFFFFF'),
    '英文功能键底边缘颜色-普通': getCascadedSystemShadow('keyboard26Alphabetic', 'systemKeys', 'dark', 'normal', '#1E1E1E'),
    '英文功能键底边缘颜色-高亮': getCascadedSystemShadow('keyboard26Alphabetic', 'systemKeys', 'dark', 'highlight', '#1E1E1E'),
    '英文功能键边框颜色-普通': getCascadedSystemBorderColor('keyboard26Alphabetic', 'systemKeys', 'dark', '#D1D1D165'),
    '英文功能键边框颜色-高亮': getCascadedSystemBorderColor('keyboard26Alphabetic', 'systemKeys', 'dark', '#D1D1D165'),
    '英文功能键边框宽度': getCascadedSystemBorderSize('keyboard26Alphabetic', 'systemKeys', 'dark', 0),
    
    // 英文鍵盤 Enter 鍵
    '英文enter键背景颜色-普通': getCascadedColor('keyboard26Alphabetic', 'enterKey', 'keyEnter', 'dark', '#D1D1D624', 'normal'),
    '英文enter键背景颜色-高亮': getCascadedColor('keyboard26Alphabetic', 'enterKey', 'keyEnterHighlight', 'dark', '#D1D1D659', 'highlight'),
    '英文enter键文字颜色': getCascadedTextColor('keyboard26Alphabetic', 'enterKey', 'textEnter', 'dark', '#FFFFFF'),
    '英文enter键底边缘颜色-普通': getCascadedEnterShadow('keyboard26Alphabetic', 'enterKey', 'dark', 'normal', '#1E1E1E'),
    '英文enter键底边缘颜色-高亮': getCascadedEnterShadow('keyboard26Alphabetic', 'enterKey', 'dark', 'highlight', '#1E1E1E'),
    '英文enter键边框颜色-普通': getCascadedEnterBorderColor('keyboard26Alphabetic', 'enterKey', 'dark', '#D1D1D165'),
    '英文enter键边框颜色-高亮': getCascadedEnterBorderColor('keyboard26Alphabetic', 'enterKey', 'dark', '#D1D1D165'),
    '英文enter键边框宽度': getCascadedEnterBorderSize('keyboard26Alphabetic', 'enterKey', 'dark', 0),
    
    // 英文鍵盤 Space 鍵
    '英文空白键文字颜色': getCascadedTextColor('keyboard26Alphabetic', 'spaceKey', 'textSpace', 'dark', '#FFFFFF'),
    
    // 英文鍵盤氣泡文字顏色
    '英文按下气泡文字颜色': getCascadedBubbleTextColor('keyboard26Alphabetic', 'unselected', 'dark', 'bubbleTextUnselected', '#FFFFFF'),
    '英文长按选中字体顏色': getCascadedBubbleTextColor('keyboard26Alphabetic', 'selected', 'dark', 'bubbleTextSelected', '#FFFFFF'),
    '英文长按非选中字体顏色': getCascadedBubbleTextColor('keyboard26Alphabetic', 'unselected', 'dark', 'bubbleTextUnselected', '#FFFFFF'),
    
    // 英文鍵盤背景
    '英文键盘背景颜色': getCascadedKeyboardBg('keyboard26Alphabetic', 'dark', '#47474701'),
    '英文键盘工具列背景颜色': getCascadedToolbarBg('keyboard26Alphabetic', 'dark', '#47474701'),
    '英文键盘工具列按钮颜色': getCascadedToolbarButtonColor('keyboard26Alphabetic', 'dark', '#CCCCCC'),

    // === 介面與其他 ===
    '底边缘顏色-普通': getCascadedShadow('keyboard26Chinese', 'alphabet', 'dark', 'normal', '#1E1E1E'),
    '底边缘顏色-高亮': getCascadedShadow('keyboard26Chinese', 'alphabet', 'dark', 'highlight', '#1E1E1E'),
    '边框颜色-普通': getCascadedBorderColor('keyboard26Chinese', 'alphabet', 'dark', '#D1D1D165'),
    '边框颜色-高亮': getCascadedBorderColor('keyboard26Chinese', 'alphabet', 'dark', '#D1D1D165'),
    '边框宽度': getCascadedBorderSize('keyboard26Chinese', 'alphabet', 'dark', 0),
    '键盘背景顏色': paletteColor('dark', 'bg', '#1C1C1E01'),
    '26键键盘背景顏色': getCascadedKeyboardBg('keyboard26Chinese', 'dark', '#1C1C1E01'),
    '26键键盘工具列背景顏色': getCascadedToolbarBg('keyboard26Chinese', 'dark', '#1C1C1E01'),
    '26键键盘工具列按鈕顏色': getCascadedToolbarButtonColor('keyboard26Chinese', 'dark', '#CCCCCC'),
    '候選字體選中字體顏色': getCascadedCandidateColor('keyboard26Chinese', 'selectedText', 'dark', 'candidateSelectedText', '#FFFFFF'),
    '候選字體未選中字體顏色': getCascadedCandidateColor('keyboard26Chinese', 'unselectedText', 'dark', 'candidateUnselectedText', '#FFFFFF'),
    '選中候選背景顏色': getCascadedCandidateColor('keyboard26Chinese', 'selectedBackground', 'dark', 'candidateSelectedBg', '#D1D1D165'),
    'toolbar文字按鍵顏色': paletteColor('dark', 'toolbarColor', '#CCCCCC'),
    'toolbar符號按鍵顏色': paletteColor('dark', 'toolbarColor', '#CCCCCC'),
    '工具列文字顏色': paletteColor('dark', 'toolbarColor', '#CCCCCC'),
    '工具列符號顏色': paletteColor('dark', 'toolbarColor', '#CCCCCC'),
    '上滑提示文字顏色': getCascadedNestedProperty('keyboard26Chinese', 'alphabet', 'swipeHint', 'color', 'dark', 'textSub', '#FFFFFF55'),
    '下滑提示文字顏色': getCascadedNestedProperty('keyboard26Chinese', 'alphabet', 'swipeHint', 'color', 'dark', 'textSub', '#FFFFFF55'),
    '英文上滑提示文字顏色': getCascadedNestedProperty('keyboard26Alphabetic', 'alphabet', 'swipeHint', 'color', 'dark', 'textSub', '#FFFFFF55'),
    '英文下滑提示文字顏色': getCascadedNestedProperty('keyboard26Alphabetic', 'alphabet', 'swipeHint', 'color', 'dark', 'textSub', '#FFFFFF55'),
    '九宮格上滑提示文字顏色': getCascadedNestedProperty('numeric', 'numbers', 'swipeHint', 'color', 'dark', 'textSub', '#FFFFFF55'),

    // 固定值
    '气泡背景顏色': '#6B6B6B',
    '气泡边缘顏色': '#606060',
    '气泡高亮顏色': '#007AFF',
    '长按选中字体顏色': getCascadedBubbleTextColor('keyboard26Chinese', 'selected', 'dark', 'bubbleTextSelected', '#FFFFFF'),
    '长按非选中字体顏色': getCascadedBubbleTextColor('keyboard26Chinese', 'unselected', 'dark', 'bubbleTextUnselected', '#FFFFFF'),
    '长按选中背景顏色': '#007AFF',
    '长按背景阴影顏色': '#00000050',
    '长按背景顏色': '#6B6B6B',
    '按键边缘顏色': '#C7C7CC',
    '面板按键前景顏色': '#FFFFFF',
    '按下气泡文字顏色': getCascadedBubbleTextColor('keyboard26Chinese', 'unselected', 'dark', 'bubbleTextUnselected', '#FFFFFF'),
    '划动气泡文字顏色': getCascadedBubbleTextColor('keyboard26Chinese', 'unselected', 'dark', 'bubbleTextUnselected', '#FFFFFF'),
    
    // Row 數字鍵盤專用氣泡文字顏色
    'Row数字键盘按下气泡文字顏色': getCascadedBubbleTextColor('numericRow', 'unselected', 'dark', 'bubbleTextUnselected', '#FFFFFF'),
    'Row数字键盘划动气泡文字顏色': getCascadedBubbleTextColor('numericRow', 'unselected', 'dark', 'bubbleTextUnselected', '#FFFFFF'),
    'Row数字键盘长按选中字体顏色': getCascadedBubbleTextColor('numericRow', 'selected', 'dark', 'bubbleTextSelected', '#FFFFFF'),
    'Row数字键盘长按非选中字体顏色': getCascadedBubbleTextColor('numericRow', 'unselected', 'dark', 'bubbleTextUnselected', '#FFFFFF'),
    
    // Row 符號鍵盤專用氣泡文字顏色
    'Row符號键盘按下气泡文字顏色': getCascadedBubbleTextColor('symbolicRow', 'unselected', 'dark', 'bubbleTextUnselected', '#FFFFFF'),
    'Row符號键盘划动气泡文字顏色': getCascadedBubbleTextColor('symbolicRow', 'unselected', 'dark', 'bubbleTextUnselected', '#FFFFFF'),
    'Row符號键盘长按选中字体顏色': getCascadedBubbleTextColor('symbolicRow', 'selected', 'dark', 'bubbleTextSelected', '#FFFFFF'),
    'Row符號键盘长按非选中字体顏色': getCascadedBubbleTextColor('symbolicRow', 'unselected', 'dark', 'bubbleTextUnselected', '#FFFFFF'),
  }
}
