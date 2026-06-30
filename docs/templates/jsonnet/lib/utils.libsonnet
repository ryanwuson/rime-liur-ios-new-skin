// 工具函數
local center = import 'center.libsonnet';
local color = import 'color.libsonnet';
local fontSize = import 'fontSize.libsonnet';

local isPrintableAsciiChar(c) =
  assert std.type(c) == 'string' && std.length(c) == 1 : 'isPrintableAsciiChar requires a single character string, input is ' + c;
  local cp = std.codepoint(c);
  cp >= 32 && cp <= 126;

local isPrintableAsciiString(s) =
  assert std.type(s) == 'string' : 'isPrintableAsciiString requires a string, input is ' + s;
  std.all(std.map(isPrintableAsciiChar, std.stringChars(s)));

local calcDiffFontSizeForNonAsciiText(text, fontSize) =
  if std.type(text) != 'string' || fontSize == null then
    fontSize
  else if isPrintableAsciiString(text) && !std.startsWith(text, '$') then // 以 $ 開頭的字串通常是變數，極可能有中文，要調整大小
    fontSize
  else
    std.round(fontSize * 0.9);  // 非 ASCII 字元縮小顯示

local makeTextStyle(params={}) =
  local text = std.get(params, 'text');
  local rawFontSize = std.get(params, 'fontSize');
  local autoShrink = std.get(params, 'autoShrinkNonAscii', false);
  local adjustedFontSize = if autoShrink && text != null && rawFontSize != null then calcDiffFontSizeForNonAsciiText(text, rawFontSize) else rawFontSize;
  std.prune({
    buttonStyleType: 'text',
    text: text,
    fontSize: adjustedFontSize,
    normalColor: std.get(params, 'normalColor'),
    highlightColor: std.get(params, 'highlightColor'),
    center: std.get(params, 'center'),
    fontWeight: std.get(params, 'fontWeight'),
    badgeNormalColor: std.get(params, 'badgeNormalColor'),
    badgeHighlightColor: std.get(params, 'badgeHighlightColor'),
  });

local makeSystemImageStyle(params={}) =
  std.prune({
    buttonStyleType: 'systemImage',
    insets: std.get(params, 'insets'),
    center: std.get(params, 'center'),
    systemImageName: std.get(params, 'systemImageName'),
    contentMode: std.get(params, 'contentMode'),
    fontSize: std.get(params, 'fontSize'),
    fontWeight: std.get(params, 'fontWeight'),
    normalColor: std.get(params, 'normalColor'),
    highlightColor: std.get(params, 'highlightColor'),
  });

local makeGeometryStyle(params={}) =
  std.prune({
    buttonStyleType: 'geometry',
    insets: std.get(params, 'insets'),
    normalColor: std.get(params, 'normalColor'),
    highlightColor: std.get(params, 'highlightColor'),
    colorLocation: std.get(params, 'colorLocation'),
    colorStartPoint: std.get(params, 'colorStartPoint'),
    colorEndPoint: std.get(params, 'colorEndPoint'),
    colorGradientType: std.get(params, 'colorGradientType'),
    cornerRadius: std.get(params, 'cornerRadius'),
    borderSize: std.get(params, 'borderSize'),
    normalBorderColor: std.get(params, 'normalBorderColor'),
    highlightBorderColor: std.get(params, 'highlightBorderColor'),
    normalLowerEdgeColor: std.get(params, 'normalLowerEdgeColor'),
    highlightLowerEdgeColor: std.get(params, 'highlightLowerEdgeColor'),
    normalShadowColor: std.get(params, 'normalShadowColor'),
    highlightShadowColor: std.get(params, 'highlightShadowColor'),
    shadowOpacity: std.get(params, 'shadowOpacity'),
    shadowRadius: std.get(params, 'shadowRadius'),
    shadowOffset: std.get(params, 'shadowOffset'),
    shadowColor: std.get(params, 'shadowColor'),
  });

local makeAssetImageStyle(params={}) =
  std.prune({
    buttonStyleType: 'assetImage',
    insets: std.get(params, 'insets'),
    assetImageName: std.get(params, 'assetImageName'),
    contentMode: std.get(params, 'contentMode'),
    normalColor: std.get(params, 'normalColor'),
    highlightColor: std.get(params, 'highlightColor'),
  });

// 按键字母映射
local keyMap = {
  q: 'Q', w: 'W', e: 'E', r: 'R', t: 'T',
  y: 'Y', u: 'U', i: 'I', o: 'O', p: 'P',
  a: 'A', s: 'S', d: 'D', f: 'F', g: 'G',
  h: 'H', j: 'J', k: 'K', l: 'L',
  z: 'Z', x: 'X', c: 'C', v: 'V', b: 'B', n: 'N', m: 'M',
};

// 生成中文26键前景（大寫）
local genPinyinStyles(theme) =
  {
    [keyName + 'ButtonForegroundStyle']: makeTextStyle(
      params={
        text: keyMap[keyName],
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        center: center['26键中文前景偏移'],
        autoShrinkNonAscii: true,
      },
    )
    for keyName in std.objectFields(keyMap)
  } + {
    [keyName + 'ButtonUppercasedStateForegroundStyle']: makeTextStyle(
      params={
        text: keyMap[keyName],
        fontSize: fontSize['按键前景文字大小'],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        center: center['26键中文前景偏移'],
        autoShrinkNonAscii: true,
      },
    )
    for keyName in std.objectFields(keyMap)
  };

// 生成英文26键前景（小寫/大寫）
local genAlphabeticStyles(theme) =
  {
    [keyName + 'ButtonForegroundStyle']: makeTextStyle(
      params={
        text: std.asciiLower(keyMap[keyName]),
        fontSize: fontSize['英文按键前景文字大小-小写'],
        normalColor: color[theme]['英文字母键文字颜色'],
        highlightColor: color[theme]['英文字母键文字颜色'],
        center: center['26键英文小写前景偏移'],
        autoShrinkNonAscii: true,
      },
    )
    for keyName in std.objectFields(keyMap)
  } + {
    [keyName + 'ButtonUppercasedStateForegroundStyle']: makeTextStyle(
      params={
        text: keyMap[keyName],
        fontSize: fontSize['英文按键前景文字大小-大写'],
        normalColor: color[theme]['英文字母键文字颜色'],
        highlightColor: color[theme]['英文字母键文字颜色'],
        center: center['26键中文前景偏移'],
        autoShrinkNonAscii: true,
      },
    )
    for keyName in std.objectFields(keyMap)
  };

// 生成數字按鈕樣式
local genNumberStyles(theme) = {
  ['number' + num + 'ButtonForegroundStyle']: makeTextStyle(
    params={
      text: std.toString(num),
      fontSize: fontSize['数字键盘数字前景字体大小'],
      normalColor: color[theme]['数字键文字颜色'],
      highlightColor: color[theme]['数字键文字颜色'],
      center: center['数字键盘数字前景偏移'],
    },
  )
  for num in std.range(0, 9)
};

// 元書 TF≥397／商店≥1.6.23：關閉氣泡溢出鍵盤高度自動下移（hint.png 上半透明區視覺上不遮擋）
local hintBubbleLayout = {
  checkIfOverflowsParentHeight: false,
};

// 生成按下气泡前景
local genHintStyles(theme) =
  {
    [key + 'ButtonHintForegroundStyle']: makeTextStyle({
      center: center['按下气泡文字偏移'],
      text: keyMap[key],
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['按下气泡文字顏色'],
      autoShrinkNonAscii: true,
    })
    for key in std.objectFields(keyMap)
  };

{
  calcDiffFontSizeForNonAsciiText: calcDiffFontSizeForNonAsciiText,
  makeTextStyle: makeTextStyle,
  makeSystemImageStyle: makeSystemImageStyle,
  makeGeometryStyle: makeGeometryStyle,
  makeAssetImageStyle: makeAssetImageStyle,

  genPinyinStyles: genPinyinStyles,
  genAlphabeticStyles: genAlphabeticStyles,
  genNumberStyles: genNumberStyles,
  genHintStyles: genHintStyles,

  hintBubbleLayout: hintBubbleLayout,
}
