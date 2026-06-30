// Row 符號鍵盤長按符號樣式生成 - 使用 Row 符號鍵盤專用的氣泡文字顏色
local color = import "color.libsonnet";
local fontSize = import "fontSize.libsonnet";
local center = import "center.libsonnet";

// 文字前景样式（使用 Row 符號鍵盤專用顏色）
local textStyle(text, fs, theme) = {
    buttonStyleType: "text",
    'text': text,
    'fontSize': fs,
    'normalColor': color[theme]["Row符號键盘长按非选中字体顏色"],
    'highlightColor': color[theme]["Row符號键盘长按选中字体顏色"],
    'center': center["长按气泡文字偏移"],
};

// sf符号前景样式（使用 Row 符號鍵盤專用顏色）
local systemImageStyle(systemImageName, fs, theme) = {
    buttonStyleType: "systemImage",
    'systemImageName': systemImageName,
    'fontSize': fs,
    'normalColor': color[theme]["Row符號键盘长按非选中字体顏色"],
    'highlightColor': color[theme]["Row符號键盘长按选中字体顏色"],
    'center': center["长按气泡sf符号偏移"],
};

// 长按符号样式生成
local holdSymbolsStyle(key, selectedIndex, size, symbol_list, theme) = {
  [key + 'ButtonHintSymbolsStyle']: {
    checkIfOverflowsParentHeight: false,
    insets: { top: 3, bottom: 3, left: 8, right: 8 },
    backgroundStyle: 'alphabeticHintSymbolsBackgroundStyle',
    // 參考指尖生花：使用固定的 size，加寬避免切到字
    size: {
      width: 38,
      height: 25,
    },
    symbolStyles: [
      key + 'ButtonHintSymbolsStyleOf' + std.toString(index)
      for index in std.range(0, std.length(symbol_list) - 1)
    ],
    selectedBackgroundStyle: 'alphabeticHintSymbolsSelectedStyle',
    selectedIndex: selectedIndex,
  },
} + {
    [key + "ButtonHintSymbolsForegroundStyleOf" + std.toString(index)]: 
      if std.objectHas(symbol_list[index].label, "text") then
        textStyle(
            symbol_list[index].label.text,
            if std.objectHas(symbol_list[index], "fontSize") then symbol_list[index].fontSize else fontSize["长按气泡文字大小"],
            theme
            )
      else
        systemImageStyle(
            symbol_list[index].label.systemImageName,
            if std.objectHas(symbol_list[index], "fontSize") then symbol_list[index].fontSize else fontSize["长按气泡sf符号大小"],
            theme
            )
      for index in std.range(0, std.length(symbol_list) - 1)
} + {
  [key + 'ButtonHintSymbolsStyleOf' + std.toString(index)]: {
    action: symbol_list[index].action,
    foregroundStyle: key + 'ButtonHintSymbolsForegroundStyleOf' + std.toString(index)
  }
  for index in std.range(0, std.length(symbol_list) - 1)
};

// 直接生成最终对象，避免 `mergePatch` 和 `objectValuesAll`
local finalStyles(theme, hintSymbolsData) = {
  style: std.foldl(
    function(acc, key) acc + holdSymbolsStyle(
      key,
      hintSymbolsData[key].selectedIndex,
      if std.objectHas(hintSymbolsData[key], 'size') then hintSymbolsData[key].size else {},
      hintSymbolsData[key].list,
      theme
    ),
    std.objectFields(hintSymbolsData),
    {}
  ),
};

{
    getStyle(theme, hintSymbolsData) :
    finalStyles(theme, hintSymbolsData).style,
    "长按背景样式": {
        buttonStyleType: "fileImage",
        insets: { bottom: -10, left: 3, right: 3, top: -10 },
        normalImage: {
            file: "hint",
            image: "IMG1"
        },
        highlightImage: {
            file: "hint",
            image: "IMG1"
        },
    },
    "长按选中背景样式": {
        buttonStyleType: "fileImage",
        insets: { left: 10, right: 10, top: -3, bottom: -3 },
        normalImage: {
            file: "hint",
            image: "IMG2"
        },
        highlightImage: {
            file: "hint",
            image: "IMG2"
        },
    }
}
