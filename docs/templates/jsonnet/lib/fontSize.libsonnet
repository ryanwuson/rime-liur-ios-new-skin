// 字號定義 - 支援 3 層繼承架構 (Size Templates & Overrides)
local settings = import '../Settings.libsonnet';

// 基礎工具：安全獲取物件屬性，帶預設值
local safeGet(obj, key, default) = if obj != null && std.objectHas(obj, key) then obj[key] else default;

// 核心查找邏輯：通用泛型路徑解析（與 color.libsonnet 一致）
local resolveOverride(obj, path) =
  std.foldl(
    function(acc, key) if acc != null && std.isObject(acc) && std.objectHas(acc, key) then acc[key] else null,
    path,
    obj
  );

// 泛型字號解析：從 overrides 路徑查找，fallback 到 groups templateKey，再 fallback 到 defaultSize
local getGenericSize(overridePath, groupKey, defaultSize) =
  if settings.customColors.enableCustomColors then
    local overrides = settings.customColors.overrides;
    local groups = settings.customColors.groups;
    local overrideValue = resolveOverride(overrides, overridePath);
    if overrideValue != null && std.isNumber(overrideValue) then overrideValue
    else if groupKey != null then safeGet(groups, groupKey, defaultSize)
    else defaultSize
  else
    defaultSize;

// 封裝原有函數介面，避免修改外層邏輯
local getCascadedSize(keyboardType, groupName, templateKey, theme, defaultSize) =
  getGenericSize([keyboardType, groupName, theme, 'fontSize'], templateKey, defaultSize);

local getCascadedLowercaseSize(keyboardType, groupName, theme) =
  getGenericSize([keyboardType, groupName, theme, 'fontSize', 'lowercase'], 'lowercaseSize', 23);

local getCascadedUppercaseSize(keyboardType, groupName, theme) =
  getGenericSize([keyboardType, groupName, theme, 'fontSize', 'uppercase'], 'alphabetSize', 21);

local getCascadedSimpleProperty(keyboardType, groupName, propertyName, theme, subKey, defaultValue, groupKey=null) =
  getGenericSize([keyboardType, groupName, theme, propertyName, subKey], groupKey, defaultValue);

local getCascadedToolbarButtonSize(keyboardType, theme, defaultSize) =
  getGenericSize([keyboardType, 'toolbarButtons', theme, 'fontSize'], 'toolbarSize', defaultSize);

local groupSize(templateKey, defaultSize) =
  if settings.customColors.enableCustomColors then
    safeGet(settings.customColors.groups, templateKey, defaultSize)
  else
    defaultSize;

{
  // 候選字字號（固定值，不可調整）
  '未展开候选字体选中字体大小': 16,
  '未展开comment字体大小': 14,
  '展开候选字体选中字体大小': 16,
  '展开comment字体大小': 13,
  'preedit区字体大小': 17,

  // 滑動提示文字大小 (支援 Layer 3 的 swipeHint.fontSize)
  '上划文字大小': getCascadedSimpleProperty('keyboard26Chinese', 'alphabet', 'swipeHint', 'light', 'fontSize', 10, 'swipeSize'),
  '下划文字大小': getCascadedSimpleProperty('keyboard26Chinese', 'alphabet', 'swipeHint', 'light', 'fontSize', 10, 'swipeSize'),
  '英文上划文字大小': getCascadedSimpleProperty('keyboard26Alphabetic', 'alphabet', 'swipeHint', 'light', 'fontSize', 10, 'swipeSize'),
  '英文下划文字大小': getCascadedSimpleProperty('keyboard26Alphabetic', 'alphabet', 'swipeHint', 'light', 'fontSize', 10, 'swipeSize'),
  '九宮格上划文字大小': getCascadedSimpleProperty('numeric', 'numbers', 'swipeHint', 'light', 'fontSize', 10, 'swipeSize'),

  // 氣泡字號 (固定值)
  '划动气泡前景文字大小': 18,
  '长按气泡文字大小': 20,
  '长按气泡sf符号大小': 12,
  '长按符号选单动作文字大小': 13,
  '长按符号选单日期文字大小': 14,

  // 按鍵文字大小 (Cascaded)
  '按键前景文字大小': getCascadedUppercaseSize('keyboard26Chinese', 'alphabet', 'light'),
  '按键前景文字大小-小写': getCascadedLowercaseSize('keyboard26Chinese', 'alphabet', 'light'),
  '按键前景文字大小-大写': getCascadedUppercaseSize('keyboard26Chinese', 'alphabet', 'light'),
  '按键前景文字大小-提示': 26,
  '按键前景sf符号大小': getCascadedSize('keyboard26Chinese', 'systemKeys', 'systemSize', 'light', 16),  // 功能鍵符號 (Shift, 123, Delete, Enter)
  '英文按键前景文字大小-小写': getCascadedLowercaseSize('keyboard26Alphabetic', 'alphabet', 'light'),
  '英文按键前景文字大小-大写': getCascadedUppercaseSize('keyboard26Alphabetic', 'alphabet', 'light'),
  '英文按键前景sf符号大小': getCascadedSize('keyboard26Alphabetic', 'systemKeys', 'systemSize', 'light', 16),

  // 工具列字號 (Layer 2)
  'toolbar按键前景sf符号大小': groupSize('toolbarSize', 20),
  'toolbar按键前景文字大小': groupSize('toolbarSize', 20),
  
  // 26 鍵鍵盤工具列按鈕大小 (支援 Layer 3 覆蓋)
  '26键键盘工具列按鈕大小': getCascadedToolbarButtonSize('keyboard26Chinese', 'light', 20),
  
  // 數字鍵盤工具列按鈕大小 (支援 Layer 3 覆蓋)
  '数字键盘工具列按鈕大小': getCascadedToolbarButtonSize('numeric', 'light', 20),
  
  // Row 數字鍵盤工具列按鈕大小 (支援 Layer 3 覆蓋)
  'Row数字键盘工具列按鈕大小': getCascadedToolbarButtonSize('numericRow', 'light', 20),
  
  // Row 符號鍵盤工具列按鈕大小 (支援 Layer 3 覆蓋)
  'Row符號键盘工具列按鈕大小': getCascadedToolbarButtonSize('symbolicRow', 'light', 20),

  // 數字鍵盤
  'collection前景字体大小': getCascadedSize('numeric', 'numericSide', 'panelSmallSize', 'light', 18), // 左側符號區
  '数字键盘数字前景字体大小': getCascadedSize('numeric', 'numbers', 'numberSize', 'light', 24),  // 數字 0~9（九宮格專用）
  '数字键盘功能键字体大小': getCascadedSize('numeric', 'systemKeys', 'systemSize', 'light', 16),  // 系統功能鍵

  // Enter 鍵字號（獨立於 systemSize，對應 groups.enterSize）
  '26键enter键字体大小': getCascadedSize('keyboard26Chinese', 'enterKey', 'enterSize', 'light', 16),
  '英文enter键字体大小': getCascadedSize('keyboard26Alphabetic', 'enterKey', 'enterSize', 'light', 16),
  '注音enter键字体大小': getCascadedSize('bopomofo', 'enterKey', 'enterSize', 'light', 16),
  '数字键盘enter键字体大小': getCascadedSize('numeric', 'enterKey', 'enterSize', 'light', 16),
  'Row数字键盘enter键字体大小': getCascadedSize('numericRow', 'enterKey', 'enterSize', 'light', 16),
  'Row符號键盘enter键字体大小': getCascadedSize('symbolicRow', 'enterKey', 'enterSize', 'light', 16),
  '符號鍵盤enter键字体大小': getCascadedSize('symbolic', 'enterKey', 'enterSize', 'light', 16),
  'emoji鍵盤enter键字体大小': getCascadedSize('emoji', 'enterKey', 'enterSize', 'light', 16),
  'kaomojis鍵盤enter键字体大小': getCascadedSize('kaomojis', 'enterKey', 'enterSize', 'light', 16),

  // Row 鍵盤按鍵字號（繼承 alphabetSize，不用 numberSize）
  'Row数字键盘按键字体大小': getCascadedSize('numericRow', 'numbers', 'rowKeySize', 'light', 21),   // 數字/符號鍵
  'Row符號键盘按键字体大小': getCascadedSize('symbolicRow', 'symbols', 'rowKeySize', 'light', 21),  // 符號鍵

  // 中文九鍵 (暫保持固定)
  '中文九键字符键前景文字大小': 15,
  '中文九键字根前景文字大小': 10,
  '中文九键划动文字大小': 10,

  // 符號鍵盤 (Cascaded)
  '符號鍵盤左側collection前景字體大小': getCascadedSize('symbolic', 'leftPanel', 'panelSmallSize', 'light', 18),
  '符號鍵盤右側collection前景字體大小': getCascadedSize('symbolic', 'rightPanel', 'panelLargeSymbolSize', 'light', 26),
  '符號鍵盤功能键字体大小': getCascadedSize('symbolic', 'systemKeys', 'systemSize', 'light', 16),  // 系統功能鍵

  // Emoji 鍵盤 (Cascaded)
  'emoji鍵盤左側collection前景字體大小': getCascadedSize('emoji', 'leftPanel', 'panelSmallSize', 'light', 18),
  'emoji鍵盤右側collection前景字體大小': getCascadedSize('emoji', 'rightPanel', 'panelLargeEmojiSize', 'light', 30),
  'emoji鍵盤功能键字体大小': getCascadedSize('emoji', 'systemKeys', 'systemSize', 'light', 16),  // 系統功能鍵

  // Kaomojis 鍵盤 (Cascaded)
  'kaomojis鍵盤左側collection前景字體大小': getCascadedSize('kaomojis', 'leftPanel', 'panelSmallSize', 'light', 18),
  'kaomojis鍵盤右側collection前景字體大小': getCascadedSize('kaomojis', 'rightPanel', 'panelLargeKaomojiSize', 'light', 20),
  'kaomojis鍵盤功能键字体大小': getCascadedSize('kaomojis', 'systemKeys', 'systemSize', 'light', 16),  // 系統功能鍵

  // 其他介面
  'panel按键前景文字大小': 12,
  'panel按键前景sf符号大小': 16,
  '英文空白键文字大小': getCascadedSize('keyboard26Alphabetic', 'spaceKey', 'spaceSize', 'light', 14),
  'Row数字键盘空白键文字大小': getCascadedSize('numericRow', 'spaceKey', 'spaceSize', 'light', 14),
  'Row符號键盘空白键文字大小': getCascadedSize('symbolicRow', 'spaceKey', 'spaceSize', 'light', 14),
  '水平候选字索引字体大小': 12,
  '垂直候选字索引字体大小': 12,

  // 系統功能鍵字號（包含 Shift, 123, Delete, Enter, 返回, 上捲, 下捲）
  '垂直候选控制按钮字体大小': groupSize('systemSize', 16),
  '垂直候选返回按钮字体大小': groupSize('systemSize', 16),
}
