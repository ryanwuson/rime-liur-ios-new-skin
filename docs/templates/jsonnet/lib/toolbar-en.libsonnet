// 英文鍵盤專用 toolbar
// 覆蓋中英切換按鈕：顯示「英」，按下切換回 pinyin 鍵盤
local toolbar = import 'toolbar.libsonnet';
local color = import 'color.libsonnet';
local fontSize = import 'fontSize.libsonnet';

local custom(theme, keyboardType) = 
  // 從 keyboardType 決定工具列按鈕顏色和大小鍵
  local toolbarButtonColorKey = 
    if keyboardType == 'keyboard26Chinese' then '26键键盘工具列按鈕顏色'
    else if keyboardType == 'numeric' then '数字键盘工具列按鈕顏色'
    else if keyboardType == 'numericRow' then 'Row数字键盘工具列按鈕顏色'
    else if keyboardType == 'symbolicRow' then 'Row符號键盘工具列按鈕顏色'
    else if keyboardType == 'bopomofo' then '注音键盘工具列按钮颜色'
    else if keyboardType == 'keyboard26Alphabetic' then '英文键盘工具列按钮颜色'
    else '26键键盘工具列按鈕顏色';
  
  local toolbarButtonSizeKey = 
    if keyboardType == 'keyboard26Chinese' then '26键键盘工具列按鈕大小'
    else if keyboardType == 'numeric' then '数字键盘工具列按鈕大小'
    else if keyboardType == 'numericRow' then 'Row数字键盘工具列按鈕大小'
    else if keyboardType == 'symbolicRow' then 'Row符號键盘工具列按鈕大小'
    else '26键键盘工具列按鈕大小';
  
  {
  // 中英切換按鈕 - 英文鍵盤版本
  // 顯示「中」，按下切換回 pinyin 鍵盤
  toolbarChEnButton: {
    size: { width: '1/10' },
    backgroundStyle: 'toolbarButtonBackgroundStyle',
    foregroundStyle: 'toolbarChEnButtonForegroundStyle',
    action: {
      keyboardType: 'pinyin',
    },
  },
  // 中英切換按鈕樣式（顯示「中」）
  toolbarChEnButtonForegroundStyle: {
    buttonStyleType: 'text',
    text: '中',
    normalColor: color[theme][toolbarButtonColorKey],
    highlightColor: color[theme][toolbarButtonColorKey],
    fontSize: fontSize[toolbarButtonSizeKey],
    fontWeight: 'light',
  },
};

{
  getToolBar(theme, orientation='portrait', keyboardType='keyboard26Chinese', skinName='蝦米輸入法'): toolbar.getToolBar(theme, orientation, keyboardType, skinName) + custom(theme, keyboardType),
}
