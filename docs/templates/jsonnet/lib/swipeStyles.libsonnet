// 滑動樣式生成
local center = import 'center.libsonnet';
local color = import 'color.libsonnet';
local fontSize = import 'fontSize.libsonnet';
local settings = import '../Settings.libsonnet';
local utils = import 'utils.libsonnet';

// 獲取按鍵所屬的行
local getKeyRow = function(key)
  if std.member(['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'], key) then 'row1'
  else if std.member(['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l'], key) then 'row2'
  else if std.member(['z', 'x', 'c', 'v', 'b', 'n', 'm'], key) then 'row3'
  else if std.member([',', '.'], key) then 'row4'
  else if key == 'space' then 'space'
  else null;

// 獲取有效設定值（核心邏輯：全域陣列檢查 -> 分排陣列檢查）
local getEffectiveSetting = function(key, settingName)
  // 將舊設定名稱映射到新的功能名稱
  local featureName = 
    if settingName == 'enableSwipeUpActions' then 'swipeUp'
    else if settingName == 'enableSwipeDownActions' then 'swipeDown'
    else if settingName == 'enableLongPressActions' then 'longPress'
    else if settingName == 'showSwipeUpText' then 'showSwipeUpText'
    else if settingName == 'showSwipeDownText' then 'showSwipeDownText'
    else settingName;
  
  // 1. 檢查全域主開關 (如果全域陣列沒有此功能，直接回傳 false)
  if !std.member(settings.globalEnabledFeatures, featureName) then
    false
  else
    // 2. 檢查分排細部設定
    local rowName = getKeyRow(key);
    if rowName == null then
      true // 如果不屬於以上任何行（例如某些獨立功能鍵），預設開啟
    else
      local rowArrayName = featureName + 'Rows';
      std.member(settings.advancedRowControl[rowArrayName], rowName);

// 解析颜色
local pickColors = function(overridesColor, theme)
  if overridesColor == {} then {}
  else {
    normalColor: overridesColor[theme].normalColor,
    highlightColor: overridesColor[theme].highlightColor,
  };

local colorsOrDefault = function(overrides, theme, direction, type)
  local overridesColor = std.get(overrides, 'color', {});
  local picked = pickColors(overridesColor, theme);
  if picked != {} then picked else { 
    normalColor: if type == 'alphabetic_en' then (if direction == 'up' then color[theme]['英文上滑提示文字顏色'] else color[theme]['英文下滑提示文字顏色']) else (if direction == 'up' then color[theme]['上滑提示文字顏色'] else color[theme]['下滑提示文字顏色']), 
    highlightColor: if type == 'alphabetic_en' then (if direction == 'up' then color[theme]['英文上滑提示文字顏色'] else color[theme]['英文下滑提示文字顏色']) else (if direction == 'up' then color[theme]['上滑提示文字顏色'] else color[theme]['下滑提示文字顏色']) 
  };

local defaultCenter = function(direction, type)
  local map = {
    up: {
      pinyin: center['上划文字偏移'],
      alphabetic: center['上划文字偏移'],
      alphabetic_en: center['上划文字偏移'],
      number: center['数字键盘上划文字偏移'],
    },
    down: {
      pinyin: center['下划文字偏移'],
      alphabetic: center['下划文字偏移'],
      alphabetic_en: center['下划文字偏移'],
      number: center['数字键盘下划文字偏移'],
    },
  };
  map[direction][type];

local defaultFontSize = function(direction, type)
  if type == 'alphabetic_en' then
    if direction == 'up' then fontSize['英文上划文字大小'] else fontSize['英文下划文字大小']
  else
    if direction == 'up' then fontSize['上划文字大小'] else fontSize['下划文字大小'];

local makeTextStyle = function(theme, label, direction, type, enableNonAsciiShrink, overrides={})
  local c = colorsOrDefault(overrides, theme, direction, type);
  local baseFontSize = std.get(overrides, 'fontSize', defaultFontSize(direction, type));
  local adjustedFontSize = if enableNonAsciiShrink then utils.calcDiffFontSizeForNonAsciiText(label.text, baseFontSize) else baseFontSize;
  {
    buttonStyleType: 'text',
    text: label.text,
    fontSize: adjustedFontSize,
    normalColor: c.normalColor,
    highlightColor: c.highlightColor,
    center: std.get(overrides, 'center', defaultCenter(direction, type)),
  };

local makeSystemImageStyle = function(theme, label, direction, type, overrides={})
  local c = colorsOrDefault(overrides, theme, direction, type);
  {
    buttonStyleType: 'systemImage',
    systemImageName: label.systemImageName,
    fontSize: std.get(overrides, 'fontSize', defaultFontSize(direction, type)),
    normalColor: c.normalColor,
    highlightColor: c.highlightColor,
    center: std.get(overrides, 'center', defaultCenter(direction, type)),
  };

// 根据 key 生成样式名称
local styleName = function(type, key, direction)
  if type == 'number' && std.length(key) == 1
  then 'number' + key + 'Button' + (if direction == 'up' then 'Up' else 'Down') + 'ForegroundStyle'
  else key + 'Button' + (if direction == 'up' then 'Up' else 'Down') + 'ForegroundStyle';

local makeForegroundStyle = function(key, direction, theme, type, enableNonAsciiShrink, data)
  // 使用新的設定檢查邏輯
  local shouldShow = if direction == 'up' then getEffectiveSetting(key, 'showSwipeUpText') else getEffectiveSetting(key, 'showSwipeDownText');
  if !shouldShow then {} else
  local label = std.get(data, 'label', {});
  if std.objectHas(label, 'text') then
    { [styleName(type, key, direction)]: makeTextStyle(theme, label, direction, type, enableNonAsciiShrink, data) }
  else if std.objectHas(label, 'systemImageName') then
    { [styleName(type, key, direction)]: makeSystemImageStyle(theme, label, direction, type, data) }
  else {};

local makeSwipeUpHintForegroundStyle = function(key, direction, theme, type, data)
  // 滑動氣泡樣式只有在啟用上滑功能時才生成
  if !getEffectiveSetting(key, 'enableSwipeUpActions') then {} else
  local label = std.get(data, 'label', {});
  if std.length(key) == 1 && std.objectHas(data, 'label') then
    if std.objectHas(label, 'text') then
    {
      [key + 'ButtonSwipeUpHintForegroundStyle']: {
        buttonStyleType: 'text',
        text: label.text,
        fontSize: utils.calcDiffFontSizeForNonAsciiText(label.text, fontSize['划动气泡前景文字大小']),
        fontWeight: 'medium',
        normalColor: color[theme]['划动气泡文字顏色'],
        center: center['划动气泡文字偏移'],
      },
    }
    else if std.objectHas(label, 'systemImageName') then
    {
      [key + 'ButtonSwipeUpHintForegroundStyle']: {
        buttonStyleType: 'systemImage',
        systemImageName: label.systemImageName,
        fontSize: fontSize['划动气泡前景文字大小'],
        normalColor: color[theme]['划动气泡文字顏色'],
        center: center['划动气泡文字偏移'],
      },
    }
    else {}
  else {};

local makeSwipeDownHintForegroundStyle = function(key, direction, theme, type, data)
  // 滑動氣泡樣式只有在啟用下滑功能時才生成
  if !getEffectiveSetting(key, 'enableSwipeDownActions') then {} else
  // 優先使用 hintLabel，否則使用 label
  local hintLabel = std.get(data, 'hintLabel', std.get(data, 'label', {}));
  // 支援獨立的氣泡字號設定（hintFontSize），否則使用預設值
  local hintFontSize = std.get(data, 'hintFontSize', fontSize['划动气泡前景文字大小']);
  if std.length(key) == 1 && std.objectHas(hintLabel, 'text') then
  {
    [key + 'ButtonSwipeDownHintForegroundStyle']: {
      buttonStyleType: 'text',
      text: hintLabel.text,
      fontSize: utils.calcDiffFontSizeForNonAsciiText(hintLabel.text, hintFontSize),
      fontWeight: 'medium',
      normalColor: color[theme]['划动气泡文字顏色'],
      center: center['划动气泡文字偏移'],
    },
  } else {};

local processDirection = function(dirData, direction, theme, type, enableSwipeHint)
  std.foldl(
    function(acc, k) acc + makeForegroundStyle(k, direction, theme, type, enableSwipeHint, dirData[k]),
    std.objectFields(dirData),
    {}
  ) +
  if direction == 'up' && enableSwipeHint then
    std.foldl(
      function(acc, k) acc + makeSwipeUpHintForegroundStyle(k, direction, theme, type, dirData[k]),
      std.objectFields(dirData),
      {}
    )
  else if direction == 'down' && enableSwipeHint then
    std.foldl(
      function(acc, k) acc + makeSwipeDownHintForegroundStyle(k, direction, theme, type, dirData[k]),
      std.objectFields(dirData),
      {}
    )
  else {};

// params 结构: { swipe_up: {...}, swipe_down: {...}, type: 'pinyin'|'alphabetic'|'number', enableSwipeHint: true|false }
local makeSwipeStyles = function(theme, params)
  local swipe_up = std.get(params, 'swipe_up', {});
  local swipe_down = std.get(params, 'swipe_down', {});
  local type = std.get(params, 'type', '');
  local enableSwipeHint = std.get(params, 'enableSwipeHint', false);
  processDirection(swipe_up, 'up', theme, type, enableSwipeHint) +
  processDirection(swipe_down, 'down', theme, type, enableSwipeHint);

{
  makeSwipeStyles: makeSwipeStyles,
  getEffectiveSetting: getEffectiveSetting,  // 導出供其他模組使用
}
