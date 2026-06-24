// easy_en 鍵盤專用 toolbar
// 覆蓋中英切換按鈕：顯示「中」，按下 combine 切回 pinyin 鍵盤並切換 Rime 方案回 liur
local toolbar = import 'toolbar.libsonnet';
local color = import 'color.libsonnet';
local fontSize = import 'fontSize.libsonnet';

local custom(theme, keyboardType) = 
  local toolbarButtonColorKey = 
    if keyboardType == 'keyboard26Alphabetic' then '英文键盘工具列按钮颜色'
    else '26键键盘工具列按鈕顏色';
  
  local toolbarButtonSizeKey = '26键键盘工具列按鈕大小';
  
  {
  // 中文切換按鈕 - easy_en 鍵盤版本
  // 顯示「中」，按下同時切換回 pinyin 鍵盤並切換 Rime 方案回 liur
  toolbarChEnButton: {
    size: { width: '1/10' },
    backgroundStyle: 'toolbarButtonBackgroundStyle',
    foregroundStyle: 'toolbarChEnButtonForegroundStyle',
    action: {
      combine: [
        { keyboardType: 'pinyin' },
        { switchRimeSchema: 'liur' },
      ],
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
  getToolBar(theme, orientation='portrait', keyboardType='keyboard26Alphabetic', skinName='蝦米輸入法'): toolbar.getToolBar(theme, orientation, keyboardType, skinName) + custom(theme, keyboardType),
}
