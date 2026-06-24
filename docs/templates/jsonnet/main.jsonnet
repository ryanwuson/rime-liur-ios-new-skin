// Xiami 蝦米輸入法皮膚 - 慣用右手版本
local settings = import 'Settings.libsonnet';

// 定義所有鍵盤元件及其建構方式
local keyboards = {
  pinyin: {
    baseName: 'pinyin_26',
    type: 'unified',
    comp: import 'keyboard/pinyin_26.jsonnet',
    new: function(comp, theme, ori, skinName) comp.new(theme, ori, skinName),
  },
  alphabetic: {
    baseName: 'alphabetic_26',
    type: 'unified',
    comp: import 'keyboard/alphabetic_26.jsonnet',
    new: function(comp, theme, ori, skinName) comp.new(theme, ori, skinName),
  },
  numeric: {
    baseName: if settings.keyboardLayout == 'row' then 'numeric_row' else 'numeric_9',
    type: 'split',
    compPortrait: if settings.keyboardLayout == 'row' then import 'keyboard/numeric_row_portrait.jsonnet' else import 'keyboard/numeric_9_portrait.jsonnet',
    compLandscape: if settings.keyboardLayout == 'row' then import 'keyboard/numeric_row_landscape.jsonnet' else import 'keyboard/numeric_9_landscape.jsonnet',
    new: function(comp, theme, ori, skinName) comp.new(theme, skinName),
  },
  // 固定九宮格數字鍵盤（不受 keyboardLayout 影響）
  numeric_panel: {
    baseName: 'numeric_9',
    type: 'split',
    compPortrait: import 'keyboard/numeric_9_portrait.jsonnet',
    compLandscape: import 'keyboard/numeric_9_landscape.jsonnet',
    new: function(comp, theme, ori, skinName) comp.new(theme, skinName),
  },
  symbolic: {
    baseName: if settings.keyboardLayout == 'row' then 'symbolic_row' else 'symbolic',
    type: 'split',
    compPortrait: if settings.keyboardLayout == 'row' then import 'keyboard/symbolic_row_portrait.jsonnet' else import 'keyboard/symbolic_portrait.jsonnet',
    compLandscape: if settings.keyboardLayout == 'row' then import 'keyboard/symbolic_row_landscape.jsonnet' else import 'keyboard/symbolic_landscape.jsonnet',
    new: function(comp, theme, ori, skinName) if settings.keyboardLayout == 'row' then comp.new(theme, skinName) else comp.new(theme),
  },
  // 固定符號面板（面板式符號鍵盤，不受 keyboardLayout 影響，ID 30）
  symbolic_panel: {
    baseName: 'symbolic',
    type: 'split',
    compPortrait: import 'keyboard/symbolic_portrait.jsonnet',
    compLandscape: import 'keyboard/symbolic_landscape.jsonnet',
    new: function(comp, theme, ori, skinName) comp.new(theme),
  },
  emoji: {
    baseName: 'emoji',
    type: 'split',
    compPortrait: import 'keyboard/emoji_portrait.jsonnet',
    compLandscape: import 'keyboard/emoji_landscape.jsonnet',
    new: function(comp, theme, ori, skinName) comp.new(theme),
  },
  kaomojis: {
    baseName: 'kaomojis',
    type: 'split',
    compPortrait: import 'keyboard/kaomojis_portrait.jsonnet',
    compLandscape: import 'keyboard/kaomojis_landscape.jsonnet',
    new: function(comp, theme, ori, skinName) comp.new(theme),
  },
  bopomofo: {
    baseName: 'bopomofo',
    type: 'split',
    compPortrait: import 'keyboard/bopomofo_portrait.jsonnet',
    compLandscape: import 'keyboard/bopomofo_landscape.jsonnet',
    new: function(comp, theme, ori, skinName) comp.new(theme, skinName),
  },
  panel: {
    baseName: 'panel',
    type: 'unified',
    comp: import 'keyboard/panel.jsonnet',
    new: function(comp, theme, ori, skinName) comp.new(theme, ori),
  },
  // easy_en 方案專用英文鍵盤（獨立鍵盤，供 toolbar「測」按鈕切換）
  easy_en: {
    baseName: 'alphabetic_easy',
    type: 'unified',
    comp: import 'keyboard/alphabetic_easy.jsonnet',
    new: function(comp, theme, ori, skinName) comp.new(theme, ori, skinName),
  },
};

local getFileName(baseName, isPortrait) = baseName + (if isPortrait then '_portrait' else '_landscape');

local config = {
  author: 'Ryan',
  name: '蝦米輸入法',
} + {
  [kId]: {
    iPhone: {
      portrait: getFileName(keyboards[kId].baseName, true),
      landscape: getFileName(keyboards[kId].baseName, false),
    },
    iPad: {
      portrait: getFileName(keyboards[kId].baseName, !std.get(keyboards[kId], 'iPadPortraitIsLandscape', false)),
      landscape: getFileName(keyboards[kId].baseName, false),
      floating: getFileName(keyboards[kId].baseName, true),
    },
  }
  for kId in std.objectFields(keyboards)
};

local generateYaml(kDef, theme, isPortrait) =
  local ori = if isPortrait then 'portrait' else 'landscape';
  local comp = if kDef.type == 'unified' then kDef.comp else (if isPortrait then kDef.compPortrait else kDef.compLandscape);
  std.toString(kDef.new(comp, theme, ori, config.name));

// 產出所有檔案的字典結構
{
  'config.yaml': std.manifestYamlDoc(config, indent_array_in_object=true, quote_keys=false),
  'SkinConfig.libsonnet': '// 皮膚配置 - 用於動態獲取皮膚名稱\n// 此文件由 main.jsonnet 自動生成\n\n{\n  name: \'' + config.name + '\',\n}\n',
} + std.foldl(
  function(acc, kId) acc + {
    [theme + '/' + getFileName(keyboards[kId].baseName, isPortrait) + '.yaml']: generateYaml(keyboards[kId], theme, isPortrait)
    for theme in ['light', 'dark']
    for isPortrait in [true, false]
  },
  std.objectFields(keyboards),
  {}
)
