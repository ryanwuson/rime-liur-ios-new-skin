// Toolbar 定義 - Xiami 精簡版
// 支援 Settings.libsonnet 自訂設定
local color = import 'color.libsonnet';
local fontSize = import 'fontSize.libsonnet';
local settings = import '../Settings.libsonnet';

// 皮膚配置 - 從 main.jsonnet 中的 config.name 動態設置
// 注意：此值在 main.jsonnet 中會被覆蓋
local skinConfig = {
  name: '蝦米輸入法',
};

// 按鈕編號對應表（按照新的序號分類）
local buttonMap = {
  '0': null,  // 空白佔位符
  // 常用功能
  '1': 'toolbarPanelButton',         // 元書設定面板
  '2': 'toolbarCloseButton',         // 收折按鈕
  '3': 'toolbarChEnButton',          // 中英切換
  '4': 'toolbarSimp2TradButton',     // 簡繁切換
  '5': 'toolbarHeartButton',         // 常用語面版
  '6': 'toolbarClipboardButton',     // 剪貼本面版
  '7': 'toolbarSymbolButton',        // 符號鍵盤
  '8': 'toolbarEmojiButton',         // Emoji鍵盤
  '9': 'toolbarNumericButton',       // 數字鍵盤
  // 編輯功能
  '10': 'toolbarSelectAllButton',    // 全選
  '11': 'toolbarCopyButton',         // 複製
  '12': 'toolbarCutButton',          // 剪下
  '13': 'toolbarPasteButton',        // 貼上
  '14': 'toolbarUndoButton',         // 復原
  '15': 'toolbarRedoButton',         // 重做
  '16': 'toolbarMoveLeftButton',     // 游標左移
  '17': 'toolbarMoveRightButton',    // 游標右移
  '18': 'toolbarLeftHandButton',     // 左手模式
  '19': 'toolbarRightHandButton',    // 右手模式
  // 其他設定
  '20': 'toolbarPerformanceButton',  // 效能監控
  '21': 'toolbarRimeDeployButton',   // Rime部署
  '22': 'toolbarScriptButton',       // 腳本面版
  '23': 'toolbarFinderButton',       // 文件管理捷徑
  '24': 'toolbarSkinButton',         // 皮膚設定捷徑
  '25': 'toolbarSkinPreferenceButton', // 皮膚微調捷徑
  '26': 'toolbarKaomojiButton',      // Kaomojis鍵盤
  '27': 'toolbarBopomofoButton',     // 注音鍵盤
  '28': 'toolbarPinyinButton',       // 拼音鍵盤
  '29': 'toolbarNumericPanelButton', // 九宮格數字鍵盤（固定）
  '30': 'toolbarSymbolPanelButton',  // 符號面板（固定）
  '31': 'toolbarTestButton',         // 【測試用】easy_en 獨立英文鍵盤
};

// 獲取按鈕標籤（包含面板和收折）
local getButtonLabel = function(buttonName)
  if buttonName == 'toolbarPanelButton' then '面'
  else if buttonName == 'toolbarCloseButton' then '收'
  else if buttonName == 'toolbarChEnButton' then '英'
  else if buttonName == 'toolbarSimp2TradButton' then '简'
  else if buttonName == 'toolbarHeartButton' then '♥'
  else if buttonName == 'toolbarClipboardButton' then '剪'
  else if buttonName == 'toolbarSymbolButton' then '符'
  else if buttonName == 'toolbarEmojiButton' then '😊'
  else if buttonName == 'toolbarSelectAllButton' then '全'
  else if buttonName == 'toolbarCopyButton' then '複'
  else if buttonName == 'toolbarCutButton' then '剪'
  else if buttonName == 'toolbarPasteButton' then '貼'
  else if buttonName == 'toolbarUndoButton' then '復'
  else if buttonName == 'toolbarRedoButton' then '重'
  else if buttonName == 'toolbarMoveLeftButton' then '←'
  else if buttonName == 'toolbarMoveRightButton' then '→'
  else if buttonName == 'toolbarLeftHandButton' then '左'
  else if buttonName == 'toolbarRightHandButton' then '右'
  else if buttonName == 'toolbarNumericButton' then '#'
  else if buttonName == 'toolbarPerformanceButton' then '效'
  else if buttonName == 'toolbarRimeDeployButton' then '部'
  else if buttonName == 'toolbarScriptButton' then '腳'
  else if buttonName == 'toolbarFinderButton' then '檔'
  else if buttonName == 'toolbarSkinButton' then '皮'
  else if buttonName == 'toolbarSkinPreferenceButton' then '調'
  else if buttonName == 'toolbarKaomojiButton' then '顏'
  else if buttonName == 'toolbarBopomofoButton' then 'ㄅ'
  else if buttonName == 'toolbarPinyinButton' then '拼'
  else if buttonName == 'toolbarNumericPanelButton' then '九'
  else if buttonName == 'toolbarSymbolPanelButton' then '符'
  else '';

// 獲取按鈕動作（按照新的序號分類）
// 注意：此函數目前未被使用，按鈕動作直接在按鈕定義中設置
// local getButtonAction = function(buttonName, skinName='蝦米輸入法')
//   // 常用功能
//   if buttonName == 'toolbarPanelButton' then { floatKeyboardType: 'panel' }
//   else if buttonName == 'toolbarCloseButton' then 'dismissKeyboard'
//   else if buttonName == 'toolbarChEnButton' then { keyboardType: 'alphabetic' }
//   else if buttonName == 'toolbarSimp2TradButton' then { shortcutCommand: '#简繁切换' }
//   else if buttonName == 'toolbarHeartButton' then { shortcut: '#showPhraseView' }
//   else if buttonName == 'toolbarClipboardButton' then { shortcut: '#showPasteboardView' }
//   else if buttonName == 'toolbarSymbolButton' then { keyboardType: 'symbolic' }
//   else if buttonName == 'toolbarEmojiButton' then { keyboardType: 'emoji' }
//   else if buttonName == 'toolbarNumericButton' then { keyboardType: 'numeric' }
//   // 編輯功能
//   else if buttonName == 'toolbarSelectAllButton' then { shortcut: '#selectText' }
//   else if buttonName == 'toolbarCopyButton' then { shortcut: '#copy' }
//   else if buttonName == 'toolbarCutButton' then { shortcut: '#cut' }
//   else if buttonName == 'toolbarPasteButton' then { shortcut: '#paste' }
//   else if buttonName == 'toolbarUndoButton' then { shortcut: '#undo' }
//   else if buttonName == 'toolbarRedoButton' then { shortcut: '#redo' }
//   else if buttonName == 'toolbarMoveLeftButton' then 'moveCursorBackward'
//   else if buttonName == 'toolbarMoveRightButton' then 'moveCursorForward'
//   else if buttonName == 'toolbarLeftHandButton' then { shortcut: '#左手模式' }
//   else if buttonName == 'toolbarRightHandButton' then { shortcut: '#右手模式' }
//   // 其他設定
//   else if buttonName == 'toolbarPerformanceButton' then { shortcut: '#keyboardPerformance' }
//   else if buttonName == 'toolbarRimeDeployButton' then { openURL: 'hamster3://com.ihsiao.apps.hamster3/rime?action=deploy' }
//   else if buttonName == 'toolbarScriptButton' then { shortcut: '#toggleScriptView' }
//   else if buttonName == 'toolbarFinderButton' then { openURL: 'hamster3://com.ihsiao.apps.hamster3/finder' }
//   else if buttonName == 'toolbarSkinButton' then { openURL: 'hamster3://com.ihsiao.apps.hamster3/keyboardSkins' }
//   else if buttonName == 'toolbarSkinPreferenceButton' then { openURL: 'hamster3://com.ihsiao.apps.hamster3/finder?action=openAppFile&fileURL=Skins/'+skinName+'/jsonnet/Settings.libsonnet' }
//   else null;

// 根據設定生成工具列按鈕單元格（HStack 版本）
local generateToolbarButtons = function()
  local buttons = settings.toolbarButtons;
  local spacerCount = 0;
  local result = std.foldl(
    function(acc, buttonCode)
      local buttonCodeStr = std.toString(buttonCode);
      if buttonCode == 0 then
        local spacerName = 'toolbarSpacer' + (acc.spacerCount + 1) + 'Button';
        {
          cells: acc.cells + [{ Cell: spacerName }],
          spacerCount: acc.spacerCount + 1,
        }
      else if std.objectHas(buttonMap, buttonCodeStr) && buttonMap[buttonCodeStr] != null then
        {
          cells: acc.cells + [{ Cell: buttonMap[buttonCodeStr] }],
          spacerCount: acc.spacerCount,
        }
      else
        local spacerName = 'toolbarSpacer' + (acc.spacerCount + 1) + 'Button';
        {
          cells: acc.cells + [{ Cell: spacerName }],
          spacerCount: acc.spacerCount + 1,
        },
    buttons,
    { cells: [], spacerCount: 0 }
  );
  result.cells;


local getToolBar(theme, orientation='portrait', keyboardType='keyboard26Chinese', skinName='蝦米輸入法') = {
  // 輔助變數：根據 keyboardType 獲取工具列按鈕顏色鍵和大小鍵
  local toolbarButtonColorKey = 
    if keyboardType == 'numeric' then '数字键盘工具列按鈕顏色'
    else if keyboardType == 'numericRow' then 'Row数字键盘工具列按鈕顏色'
    else if keyboardType == 'symbolicRow' then 'Row符號键盘工具列按鈕顏色'
    else if keyboardType == 'bopomofo' then '注音键盘工具列按钮颜色'
    else if keyboardType == 'keyboard26Alphabetic' then '英文键盘工具列按钮颜色'
    else '26键键盘工具列按鈕顏色',
  local toolbarButtonSizeKey = 
    if keyboardType == 'numeric' then '数字键盘工具列按鈕大小'
    else if keyboardType == 'numericRow' then 'Row数字键盘工具列按鈕大小'
    else if keyboardType == 'symbolicRow' then 'Row符號键盘工具列按鈕大小'
    else '26键键盘工具列按鈕大小',
  
  // 輔助變數：根據 keyboardType 獲取候選字顏色鍵
  local candidateSelectedTextKey = 
    if keyboardType == 'bopomofo' then '注音候選字體選中字體顏色'
    else if keyboardType == 'numericRow' || keyboardType == 'numeric' then 'Row數字候選字體選中字體顏色'
    else if keyboardType == 'symbolicRow' then 'Row符號候選字體選中字體顏色'
    else if keyboardType == 'keyboard26Alphabetic' then '英文候選字體選中字體顏色'
    else '候選字體選中字體顏色',
  local candidateUnselectedTextKey = 
    if keyboardType == 'bopomofo' then '注音候選字體未選中字體顏色'
    else if keyboardType == 'numericRow' || keyboardType == 'numeric' then 'Row數字候選字體未選中字體顏色'
    else if keyboardType == 'symbolicRow' then 'Row符號候選字體未選中字體顏色'
    else if keyboardType == 'keyboard26Alphabetic' then '英文候選字體未選中字體顏色'
    else '候選字體未選中字體顏色',
  local candidateSelectedBgKey = 
    if keyboardType == 'bopomofo' then '注音選中候選背景顏色'
    else if keyboardType == 'numericRow' || keyboardType == 'numeric' then 'Row數字選中候選背景顏色'
    else if keyboardType == 'symbolicRow' then 'Row符號選中候選背景顏色'
    else if keyboardType == 'keyboard26Alphabetic' then '英文選中候選背景顏色'
    else '選中候選背景顏色',
  
  // 輔助變數：根據 keyboardType 獲取候選字控制按鈕文字顏色（展開候選字後的四個系統鍵）
  local candidateControlButtonTextKey = 
    if keyboardType == 'bopomofo' then '注音候選控制按鈕文字顏色'
    else if keyboardType == 'numericRow' || keyboardType == 'numeric' then 'Row數字候選控制按鈕文字顏色'
    else if keyboardType == 'symbolicRow' then 'Row符號候選控制按鈕文字顏色'
    else if keyboardType == 'keyboard26Alphabetic' then '英文候選控制按鈕文字顏色'
    else '系统功能键文字顏色',

  // preedit 樣式（固定：背景透明、字色隨 Light/Dark，不受 palette 自訂）
  preeditStyle: {
    insets: { left: 8, top: 2 },
    backgroundStyle: 'preeditBackgroundStyle',
    foregroundStyle: 'preeditForegroundStyle',
  },
  preeditBackgroundStyle: {
    buttonStyleType: 'geometry',
    normalColor: '#00000000',
  },
  preeditForegroundStyle: {
    textColor: if theme == 'light' then '#000000' else '#FFFFFF',
    fontSize: fontSize['preedit区字体大小'],
    fontWeight: 0,
  },

  // 工具栏樣式
  toolbarStyle: {
    backgroundStyle: 'toolbarBackgroundStyle',
  },

  // 完全自訂工具栏佈局（10個按鈕位置）
  toolbarLayout: [
    {
      HStack: {
        subviews: generateToolbarButtons(),
      },
    },
  ],



  // 工具栏背景樣式（支援 Layer 3 獨立背景色）
  toolbarBackgroundStyle: {
    buttonStyleType: 'geometry',
    normalColor: color[theme][
      if keyboardType == 'numeric' then '数字键盘工具列背景顏色'
      else if keyboardType == 'numericRow' then 'Row数字键盘工具列背景顏色'
      else if keyboardType == 'symbolicRow' then 'Row符號键盘工具列背景顏色'
      else if keyboardType == 'bopomofo' then '注音键盘工具列背景颜色'
      else if keyboardType == 'keyboard26Alphabetic' then '英文键盘工具列背景颜色'
      else '26键键盘工具列背景顏色'
    ],
  },

  // 工具栏按鍵背景樣式（透明）
  toolbarButtonBackgroundStyle: {
    buttonStyleType: 'geometry',
    normalColor: '#00000001',
    highlightColor: '#00000001',
  },

  // Emoji 按鈕（對齊O鍵中間）
  toolbarEmojiButton: {
    size: { width: '1/10' },
    backgroundStyle: 'toolbarButtonBackgroundStyle',
    foregroundStyle: 'toolbarEmojiButtonForegroundStyle',
    action: {
      keyboardType: 'emoji',
    },
  },
  toolbarEmojiButtonForegroundStyle: {
    buttonStyleType: 'systemImage',
    systemImageName: 'face.smiling',
    normalColor: color[theme][toolbarButtonColorKey],
    highlightColor: color[theme][toolbarButtonColorKey],
    fontSize: fontSize[toolbarButtonSizeKey],
    fontWeight: 'regular',
  },

  // 簡繁切換按鈕（對齊U鍵中間）
  // 使用 rime$simplification：false=繁體（顯示「简」），true=簡體（顯示「繁」）
  toolbarSimp2TradButton: {
    size: { width: '1/10' },
    backgroundStyle: 'toolbarButtonBackgroundStyle',
    foregroundStyle: [
      {
        styleName: 'toolbarShowTradStyle',
        conditionKey: 'rime$simplification',
        conditionValue: true,
      },
      {
        styleName: 'toolbarShowSimpStyle',
        conditionKey: 'rime$simplification',
        conditionValue: false,
      },
    ],
    action: {
      shortcutCommand: '#简繁切换',
    },
  },
  // 當前簡體時顯示「繁」（表示按下會切換到繁體）
  toolbarShowTradStyle: {
    buttonStyleType: 'text',
    text: '繁',
    normalColor: color[theme][toolbarButtonColorKey],
    highlightColor: color[theme][toolbarButtonColorKey],
    fontSize: fontSize[toolbarButtonSizeKey],
    fontWeight: 'light',
  },
  // 當前繁體時顯示「简」（表示按下會切換到簡體）
  toolbarShowSimpStyle: {
    buttonStyleType: 'text',
    text: '简',
    normalColor: color[theme][toolbarButtonColorKey],
    highlightColor: color[theme][toolbarButtonColorKey],
    fontSize: fontSize[toolbarButtonSizeKey],
    fontWeight: 'light',
  },

  // 愛心按鈕（對齊U鍵中間）
  // 亮色採用 ♡，暗色採用 ♥
  // 按下時叫出短語功能（與空山素影相同）
  toolbarHeartButton: {
    size: { width: '1/10' },
    backgroundStyle: 'toolbarButtonBackgroundStyle',
    foregroundStyle: 'toolbarHeartButtonForegroundStyle',
    action: {
      shortcut: '#showPhraseView',
    },
  },
  toolbarHeartButtonForegroundStyle: {
    buttonStyleType: 'systemImage',
    systemImageName: if theme == 'dark' then 'heart.square.fill' else 'heart.square',
    normalColor: color[theme][toolbarButtonColorKey],
    highlightColor: color[theme][toolbarButtonColorKey],
    fontSize: fontSize[toolbarButtonSizeKey],
    fontWeight: 'regular',
  },

  // 剪貼本按鈕（對齊U鍵中間）
  toolbarClipboardButton: {
    size: { width: '1/10' },
    backgroundStyle: 'toolbarButtonBackgroundStyle',
    foregroundStyle: 'toolbarClipboardButtonForegroundStyle',
    action: {
      shortcut: '#showPasteboardView',
    },
  },
  toolbarClipboardButtonForegroundStyle: {
    buttonStyleType: 'systemImage',
    systemImageName: if theme == 'dark' then 'tag.square.fill' else 'tag.square',
    normalColor: color[theme][toolbarButtonColorKey],
    highlightColor: color[theme][toolbarButtonColorKey],
    fontSize: fontSize[toolbarButtonSizeKey],
    fontWeight: 'regular',
  },

  // 符號按鈕（對齊I鍵中間）
  toolbarSymbolButton: {
    size: { width: '1/10' },
    backgroundStyle: 'toolbarButtonBackgroundStyle',
    foregroundStyle: 'toolbarSymbolButtonForegroundStyle',
    action: {
      keyboardType: 'symbolic',
    },
  },
  toolbarSymbolButtonForegroundStyle: {
    buttonStyleType: 'systemImage',
    systemImageName: if theme == 'dark' then 'number.square.fill' else 'number.square',
    normalColor: color[theme][toolbarButtonColorKey],
    highlightColor: color[theme][toolbarButtonColorKey],
    fontSize: fontSize[toolbarButtonSizeKey],
    fontWeight: 'regular',
  },

  // 中英切換按鈕（中文鍵盤版本）
  // 顯示「英」，按下切換到英文鍵盤
  // 模式 1：切換至純英文鍵盤（alphabetic_26，不走 Rime）
  // 模式 2：切換至詞庫英文鍵盤（alphabetic_easy，走 easy_en 方案）
  toolbarChEnButton: {
    size: { width: '1/10' },
    backgroundStyle: 'toolbarButtonBackgroundStyle',
    foregroundStyle: 'toolbarChEnButtonForegroundStyle',
    action: if settings.englishKeyboardMode == '2' then {
      combine: [
        { keyboardType: 'easy_en' },
        { switchRimeSchema: 'easy_en' },
      ],
    } else { keyboardType: 'alphabetic' },
  },

  // 面板按鈕（對齊Q鍵中間）
  toolbarPanelButton: {
    size: { width: '1/10' },
    backgroundStyle: 'toolbarButtonBackgroundStyle',
    foregroundStyle: 'toolbarPanelButtonForegroundStyle',
    action: {
      floatKeyboardType: 'panel',
    },
  },
  toolbarPanelButtonForegroundStyle: {
    buttonStyleType: 'systemImage',
    systemImageName: 'swirl.circle.righthalf.filled',
    normalColor: color[theme][toolbarButtonColorKey],
    highlightColor: color[theme][toolbarButtonColorKey],
    fontSize: fontSize[toolbarButtonSizeKey],
    fontWeight: 'regular',
  },

  // 收起鍵盤按鈕（對齊P鍵中間）
  toolbarCloseButton: {
    size: { width: '1/10' },
    backgroundStyle: 'toolbarButtonBackgroundStyle',
    foregroundStyle: 'toolbarCloseButtonForegroundStyle',
    action: 'dismissKeyboard',
  },
  toolbarCloseButtonForegroundStyle: {
    buttonStyleType: 'systemImage',
    systemImageName: if theme == 'dark' then 'chevron.down.circle.fill' else 'chevron.down.circle',
    normalColor: color[theme][toolbarButtonColorKey],
    highlightColor: color[theme][toolbarButtonColorKey],
    fontSize: fontSize[toolbarButtonSizeKey],
    fontWeight: 'regular',
  },

  // 中英切換按鈕前景樣式（中文鍵盤顯示「英」）
  toolbarChEnButtonForegroundStyle: {
    buttonStyleType: 'text',
    text: '英',
    normalColor: color[theme][toolbarButtonColorKey],
    highlightColor: color[theme][toolbarButtonColorKey],
    fontSize: fontSize[toolbarButtonSizeKey],
    fontWeight: 'light',
  },

  // 數字鍵盤按鈕 (9)
  toolbarNumericButton: {
    size: { width: '1/10' },
    backgroundStyle: 'toolbarButtonBackgroundStyle',
    foregroundStyle: 'toolbarNumericButtonForegroundStyle',
    action: { keyboardType: 'numeric' },
  },
  toolbarNumericButtonForegroundStyle: {
    buttonStyleType: 'systemImage',
    systemImageName: if theme == 'dark' then 'numbers.rectangle.fill' else 'numbers.rectangle',
    normalColor: color[theme][toolbarButtonColorKey],
    highlightColor: color[theme][toolbarButtonColorKey],
    fontSize: fontSize[toolbarButtonSizeKey],
    fontWeight: 'regular',
  },

  // ===== 新增按鈕定義 (10-25) =====
  
  // 10. 全選按鈕
  toolbarSelectAllButton: {
    size: { width: '1/10' },
    backgroundStyle: 'toolbarButtonBackgroundStyle',
    foregroundStyle: 'toolbarSelectAllButtonForegroundStyle',
    action: { shortcut: '#selectText' },
  },
  toolbarSelectAllButtonForegroundStyle: {
    buttonStyleType: 'systemImage',
    systemImageName: if theme == 'dark' then 'viewfinder.circle.fill' else 'viewfinder.circle',
    normalColor: color[theme][toolbarButtonColorKey],
    highlightColor: color[theme][toolbarButtonColorKey],
    fontSize: fontSize[toolbarButtonSizeKey],
    fontWeight: 'regular',
  },

  // 11. 複製按鈕
  toolbarCopyButton: {
    size: { width: '1/10' },
    backgroundStyle: 'toolbarButtonBackgroundStyle',
    foregroundStyle: 'toolbarCopyButtonForegroundStyle',
    action: { shortcut: '#copy' },
  },
  toolbarCopyButtonForegroundStyle: {
    buttonStyleType: 'systemImage',
    systemImageName: if theme == 'dark' then 'rectangle.on.rectangle.circle.fill' else 'rectangle.on.rectangle.circle',
    normalColor: color[theme][toolbarButtonColorKey],
    highlightColor: color[theme][toolbarButtonColorKey],
    fontSize: fontSize[toolbarButtonSizeKey],
    fontWeight: 'regular',
  },

  // 12. 剪下按鈕
  toolbarCutButton: {
    size: { width: '1/10' },
    backgroundStyle: 'toolbarButtonBackgroundStyle',
    foregroundStyle: 'toolbarCutButtonForegroundStyle',
    action: { shortcut: '#cut' },
  },
  toolbarCutButtonForegroundStyle: {
    buttonStyleType: 'systemImage',
    systemImageName: if theme == 'dark' then 'scissors.circle.fill' else 'scissors.circle',
    normalColor: color[theme][toolbarButtonColorKey],
    highlightColor: color[theme][toolbarButtonColorKey],
    fontSize: fontSize[toolbarButtonSizeKey],
    fontWeight: 'regular',
  },

  // 13. 貼上按鈕
  toolbarPasteButton: {
    size: { width: '1/10' },
    backgroundStyle: 'toolbarButtonBackgroundStyle',
    foregroundStyle: 'toolbarPasteButtonForegroundStyle',
    action: { shortcut: '#paste' },
  },
  toolbarPasteButtonForegroundStyle: {
    buttonStyleType: 'systemImage',
    systemImageName: if theme == 'dark' then 'bag.circle.fill' else 'bag.circle',
    normalColor: color[theme][toolbarButtonColorKey],
    highlightColor: color[theme][toolbarButtonColorKey],
    fontSize: fontSize[toolbarButtonSizeKey],
    fontWeight: 'regular',
  },

  // 14. 復原按鈕
  toolbarUndoButton: {
    size: { width: '1/10' },
    backgroundStyle: 'toolbarButtonBackgroundStyle',
    foregroundStyle: 'toolbarUndoButtonForegroundStyle',
    action: { shortcut: '#undo' },
  },
  toolbarUndoButtonForegroundStyle: {
    buttonStyleType: 'systemImage',
    systemImageName: if theme == 'dark' then 'arrow.counterclockwise.circle.fill' else 'arrow.counterclockwise.circle',
    normalColor: color[theme][toolbarButtonColorKey],
    highlightColor: color[theme][toolbarButtonColorKey],
    fontSize: fontSize[toolbarButtonSizeKey],
    fontWeight: 'regular',
  },

  // 15. 重做按鈕
  toolbarRedoButton: {
    size: { width: '1/10' },
    backgroundStyle: 'toolbarButtonBackgroundStyle',
    foregroundStyle: 'toolbarRedoButtonForegroundStyle',
    action: { shortcut: '#redo' },
  },
  toolbarRedoButtonForegroundStyle: {
    buttonStyleType: 'systemImage',
    systemImageName: if theme == 'dark' then 'arrow.clockwise.circle.fill' else 'arrow.clockwise.circle',
    normalColor: color[theme][toolbarButtonColorKey],
    highlightColor: color[theme][toolbarButtonColorKey],
    fontSize: fontSize[toolbarButtonSizeKey],
    fontWeight: 'regular',
  },

  // 16. 左移按鈕 (游標左移)
  toolbarMoveLeftButton: {
    size: { width: '1/10' },
    backgroundStyle: 'toolbarButtonBackgroundStyle',
    foregroundStyle: 'toolbarMoveLeftButtonForegroundStyle',
    action: 'moveCursorBackward',
  },
  toolbarMoveLeftButtonForegroundStyle: {
    buttonStyleType: 'systemImage',
    systemImageName: if theme == 'dark' then 'arrow.left.to.line.circle.fill' else 'arrow.left.to.line.circle',
    normalColor: color[theme][toolbarButtonColorKey],
    highlightColor: color[theme][toolbarButtonColorKey],
    fontSize: fontSize[toolbarButtonSizeKey],
    fontWeight: 'regular',
  },

  // 17. 右移按鈕 (游標右移)
  toolbarMoveRightButton: {
    size: { width: '1/10' },
    backgroundStyle: 'toolbarButtonBackgroundStyle',
    foregroundStyle: 'toolbarMoveRightButtonForegroundStyle',
    action: 'moveCursorForward',
  },
  toolbarMoveRightButtonForegroundStyle: {
    buttonStyleType: 'systemImage',
    systemImageName: if theme == 'dark' then 'arrow.right.to.line.circle.fill' else 'arrow.right.to.line.circle',
    normalColor: color[theme][toolbarButtonColorKey],
    highlightColor: color[theme][toolbarButtonColorKey],
    fontSize: fontSize[toolbarButtonSizeKey],
    fontWeight: 'regular',
  },

  // 18. 左手模式按鈕
  toolbarLeftHandButton: {
    size: { width: '1/10' },
    backgroundStyle: 'toolbarButtonBackgroundStyle',
    foregroundStyle: 'toolbarLeftHandButtonForegroundStyle',
    action: { shortcut: '#左手模式' },
  },
  toolbarLeftHandButtonForegroundStyle: {
    buttonStyleType: 'systemImage',
    systemImageName: if theme == 'dark' then 'keyboard.onehanded.left.fill' else 'keyboard.onehanded.left',
    normalColor: color[theme][toolbarButtonColorKey],
    highlightColor: color[theme][toolbarButtonColorKey],
    fontSize: fontSize[toolbarButtonSizeKey],
    fontWeight: 'regular',
  },

  // 19. 右手模式按鈕
  toolbarRightHandButton: {
    size: { width: '1/10' },
    backgroundStyle: 'toolbarButtonBackgroundStyle',
    foregroundStyle: 'toolbarRightHandButtonForegroundStyle',
    action: { shortcut: '#右手模式' },
  },
  toolbarRightHandButtonForegroundStyle: {
    buttonStyleType: 'systemImage',
    systemImageName: if theme == 'dark' then 'keyboard.onehanded.right.fill' else 'keyboard.onehanded.right',
    normalColor: color[theme][toolbarButtonColorKey],
    highlightColor: color[theme][toolbarButtonColorKey],
    fontSize: fontSize[toolbarButtonSizeKey],
    fontWeight: 'regular',
  },

  // 20. 檢視效能按鈕
  toolbarPerformanceButton: {
    size: { width: '1/10' },
    backgroundStyle: 'toolbarButtonBackgroundStyle',
    foregroundStyle: 'toolbarPerformanceButtonForegroundStyle',
    action: { shortcut: '#keyboardPerformance' },
  },
  toolbarPerformanceButtonForegroundStyle: {
    buttonStyleType: 'systemImage',
    systemImageName: if theme == 'dark' then 'gauge.with.needle.fill' else 'gauge.with.needle',
    normalColor: color[theme][toolbarButtonColorKey],
    highlightColor: color[theme][toolbarButtonColorKey],
    fontSize: fontSize[toolbarButtonSizeKey],
    fontWeight: 'regular',
  },

  // 21. Rime部署按鈕
  toolbarRimeDeployButton: {
    size: { width: '1/10' },
    backgroundStyle: 'toolbarButtonBackgroundStyle',
    foregroundStyle: 'toolbarRimeDeployButtonForegroundStyle',
    action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/rime?action=deploy' },
  },
  toolbarRimeDeployButtonForegroundStyle: {
    buttonStyleType: 'systemImage',
    systemImageName: if theme == 'dark' then 'arrow.trianglehead.2.clockwise.rotate.90.circle.fill' else 'arrow.trianglehead.2.clockwise.rotate.90.circle',
    normalColor: color[theme][toolbarButtonColorKey],
    highlightColor: color[theme][toolbarButtonColorKey],
    fontSize: fontSize[toolbarButtonSizeKey],
    fontWeight: 'regular',
  },

  // 23. 腳本按鈕
  toolbarScriptButton: {
    size: { width: '1/10' },
    backgroundStyle: 'toolbarButtonBackgroundStyle',
    foregroundStyle: 'toolbarScriptButtonForegroundStyle',
    action: { shortcut: '#toggleScriptView' },
  },
  toolbarScriptButtonForegroundStyle: {
    buttonStyleType: 'systemImage',
    systemImageName: if theme == 'dark' then 'command.square.fill' else 'command.square',
    normalColor: color[theme][toolbarButtonColorKey],
    highlightColor: color[theme][toolbarButtonColorKey],
    fontSize: fontSize[toolbarButtonSizeKey],
    fontWeight: 'regular',
  },

  // 24. 檔案管理按鈕
  toolbarFinderButton: {
    size: { width: '1/10' },
    backgroundStyle: 'toolbarButtonBackgroundStyle',
    foregroundStyle: 'toolbarFinderButtonForegroundStyle',
    action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/finder' },
  },
  toolbarFinderButtonForegroundStyle: {
    buttonStyleType: 'systemImage',
    systemImageName: if theme == 'dark' then 'folder.circle.fill' else 'folder.circle',
    normalColor: color[theme][toolbarButtonColorKey],
    highlightColor: color[theme][toolbarButtonColorKey],
    fontSize: fontSize[toolbarButtonSizeKey],
    fontWeight: 'regular',
  },

  // 25. 皮膚設定按鈕
  toolbarSkinButton: {
    size: { width: '1/10' },
    backgroundStyle: 'toolbarButtonBackgroundStyle',
    foregroundStyle: 'toolbarSkinButtonForegroundStyle',
    action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/keyboardSkins' },
  },
  toolbarSkinButtonForegroundStyle: {
    buttonStyleType: 'systemImage',
    systemImageName: if theme == 'dark' then 'pencil.tip.crop.circle.fill' else 'pencil.tip.crop.circle',
    normalColor: color[theme][toolbarButtonColorKey],
    highlightColor: color[theme][toolbarButtonColorKey],
    fontSize: fontSize[toolbarButtonSizeKey],
    fontWeight: 'regular',
  },

  // 26. 皮膚微調按鈕
  toolbarSkinPreferenceButton: {
    size: { width: '1/10' },
    backgroundStyle: 'toolbarButtonBackgroundStyle',
    foregroundStyle: 'toolbarSkinPreferenceButtonForegroundStyle',
    action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/finder?action=openAppFile&fileURL=Skins/'+skinName+'/jsonnet/Settings.libsonnet' },
  },
  toolbarSkinPreferenceButtonForegroundStyle: {
    buttonStyleType: 'systemImage',
    systemImageName: if theme == 'dark' then 'square.and.pencil.circle.fill' else 'square.and.pencil.circle',
    normalColor: color[theme][toolbarButtonColorKey],
    highlightColor: color[theme][toolbarButtonColorKey],
    fontSize: fontSize[toolbarButtonSizeKey],
    fontWeight: 'regular',
  },

  // 27. Kaomojis 鍵盤按鈕
  toolbarKaomojiButton: {
    size: { width: '1/10' },
    backgroundStyle: 'toolbarButtonBackgroundStyle',
    foregroundStyle: 'toolbarKaomojiButtonForegroundStyle',
    action: { keyboardType: 'kaomojis' },
  },
  toolbarKaomojiButtonForegroundStyle: {
    buttonStyleType: 'systemImage',
    systemImageName: if theme == 'dark' then 'face.dashed.fill' else 'face.dashed',
    normalColor: color[theme][toolbarButtonColorKey],
    highlightColor: color[theme][toolbarButtonColorKey],
    fontSize: fontSize[toolbarButtonSizeKey],
    fontWeight: 'regular',
  },

  // 28. 注音鍵盤按鈕
  toolbarBopomofoButton: {
    size: { width: '1/10' },
    backgroundStyle: 'toolbarButtonBackgroundStyle',
    foregroundStyle: 'toolbarBopomofoButtonForegroundStyle',
    action: {
      combine: [
        { keyboardType: 'bopomofo' },
        { sendKeys: "';" },
      ],
    },
  },
  toolbarBopomofoButtonForegroundStyle: {
    buttonStyleType: 'text',
    text: 'ㄅ',
    normalColor: color[theme][toolbarButtonColorKey],
    highlightColor: color[theme][toolbarButtonColorKey],
    fontSize: fontSize[toolbarButtonSizeKey],
    fontWeight: 'light',
  },

  // 29. 拼音按鈕
  toolbarPinyinButton: {
    size: { width: '1/10' },
    backgroundStyle: 'toolbarButtonBackgroundStyle',
    foregroundStyle: 'toolbarPinyinButtonForegroundStyle',
    action: { sendKeys: ";'" },
  },
  toolbarPinyinButtonForegroundStyle: {
    buttonStyleType: 'text',
    text: '拼',
    normalColor: color[theme][toolbarButtonColorKey],
    highlightColor: color[theme][toolbarButtonColorKey],
    fontSize: fontSize[toolbarButtonSizeKey],
    fontWeight: 'light',
  },

  // 30. 九宮格數字鍵盤按鈕（固定，不受 keyboardLayout 影響）
  toolbarNumericPanelButton: {
    size: { width: '1/10' },
    backgroundStyle: 'toolbarButtonBackgroundStyle',
    foregroundStyle: 'toolbarNumericPanelButtonForegroundStyle',
    action: { keyboardType: 'numeric_panel' },
  },
  toolbarNumericPanelButtonForegroundStyle: {
    buttonStyleType: 'systemImage',
    systemImageName: 'square.grid.3x3.square',
    normalColor: color[theme][toolbarButtonColorKey],
    highlightColor: color[theme][toolbarButtonColorKey],
    fontSize: fontSize[toolbarButtonSizeKey],
    fontWeight: 'regular',
  },
  
  // 31. 符號面板按鈕（固定，不受 keyboardLayout 影響）
  toolbarSymbolPanelButton: {
    size: { width: '1/10' },
    backgroundStyle: 'toolbarButtonBackgroundStyle',
    foregroundStyle: 'toolbarSymbolPanelButtonForegroundStyle',
    action: { keyboardType: 'symbolic_panel' },
  },
  toolbarSymbolPanelButtonForegroundStyle: {
    buttonStyleType: 'systemImage',
    systemImageName: if theme == 'dark' then 'curlybraces.square.fill' else 'curlybraces.square',
    normalColor: color[theme][toolbarButtonColorKey],
    highlightColor: color[theme][toolbarButtonColorKey],
    fontSize: fontSize[toolbarButtonSizeKey],
    fontWeight: 'regular',
  },

  // 32.【測試用】easy_en 獨立英文鍵盤按鈕
  // 測試目標：combine 同時切換到 easy_en 獨立鍵盤 + 切換 Rime 方案到 easy_en
  toolbarTestButton: {
    size: { width: '1/10' },
    backgroundStyle: 'toolbarButtonBackgroundStyle',
    foregroundStyle: 'toolbarTestButtonForegroundStyle',
    action: {
      combine: [
        { keyboardType: 'easy_en' },
        { switchRimeSchema: 'easy_en' },
      ],
    },
  },
  toolbarTestButtonForegroundStyle: {
    buttonStyleType: 'text',
    text: '測',
    normalColor: color[theme][toolbarButtonColorKey],
    highlightColor: color[theme][toolbarButtonColorKey],
    fontSize: fontSize[toolbarButtonSizeKey],
    fontWeight: 'light',
  },

  // 動態生成空白佔位按鈕（最多支援10個）
  toolbarSpacer1Button: {
    size: { width: '1/10' },
    backgroundStyle: 'toolbarButtonBackgroundStyle',
  },
  toolbarSpacer2Button: {
    size: { width: '1/10' },
    backgroundStyle: 'toolbarButtonBackgroundStyle',
  },
  toolbarSpacer3Button: {
    size: { width: '1/10' },
    backgroundStyle: 'toolbarButtonBackgroundStyle',
  },
  toolbarSpacer4Button: {
    size: { width: '1/10' },
    backgroundStyle: 'toolbarButtonBackgroundStyle',
  },
  toolbarSpacer5Button: {
    size: { width: '1/10' },
    backgroundStyle: 'toolbarButtonBackgroundStyle',
  },
  toolbarSpacer6Button: {
    size: { width: '1/10' },
    backgroundStyle: 'toolbarButtonBackgroundStyle',
  },
  toolbarSpacer7Button: {
    size: { width: '1/10' },
    backgroundStyle: 'toolbarButtonBackgroundStyle',
  },
  toolbarSpacer8Button: {
    size: { width: '1/10' },
    backgroundStyle: 'toolbarButtonBackgroundStyle',
  },
  toolbarSpacer9Button: {
    size: { width: '1/10' },
    backgroundStyle: 'toolbarButtonBackgroundStyle',
  },
  toolbarSpacer10Button: {
    size: { width: '1/10' },
    backgroundStyle: 'toolbarButtonBackgroundStyle',
  },

  // 橫向候選樣式
  horizontalCandidatesStyle: {
    insets: { top: 8, bottom: 3, left: 5 },
    backgroundStyle: 'toolbarBackgroundStyle',
  },
  horizontalCandidatesLayout: [
    {
      HStack: {
        subviews: [
          { Cell: 'horizontalCandidates' },
          { Cell: 'expandButton' },
        ],
      },
    },
  ],
  horizontalCandidates: {
    type: 'horizontalCandidates',
    size: { width: '7/8' },
    insets: { left: 3 },
    maxColumns: 6,
    maxRows: 4,
    candidateStyle: 'candidateStyle',
  },
  candidateStyle: {
    highlightBackgroundColor: 0,
    preferredBackgroundColor: color[theme][candidateSelectedBgKey],
    preferredIndexColor: color[theme][candidateSelectedTextKey],
    preferredTextColor: color[theme][candidateSelectedTextKey],
    preferredCommentColor: color[theme][candidateSelectedTextKey],
    indexColor: color[theme][candidateUnselectedTextKey],
    textColor: color[theme][candidateUnselectedTextKey],
    commentColor: color[theme][candidateUnselectedTextKey],
    indexFontSize: fontSize['未展开候选字体选中字体大小'],
    textFontSize: fontSize['未展开候选字体选中字体大小'],
    commentFontSize: fontSize['未展开comment字体大小'],
  },
  expandButton: {
    backgroundStyle: 'toolbarButtonBackgroundStyle',
    foregroundStyle: 'expandButtonForegroundStyle',
    action: { shortcut: '#candidatesBarStateToggle' },
  },
  expandButtonForegroundStyle: {
    buttonStyleType: 'systemImage',
    systemImageName: 'chevron.down',
    normalColor: color[theme][toolbarButtonColorKey],
    highlightColor: color[theme][toolbarButtonColorKey],
    fontSize: fontSize[toolbarButtonSizeKey] - 4,
  },

  // 縱向候選樣式（展開候選框）
  verticalCandidatesStyle: {
    backgroundStyle: 'toolbarBackgroundStyle',
  },
  // 使用 HStack 水平排列（與備份一致）
  verticalCandidatesLayout: [
    {
      HStack: {
        subviews: [
          { Cell: 'verticalCandidates' },
        ],
      },
    },
    {
      HStack: {
        style: 'verticalLastRowStyle',
        subviews: [
          { Cell: 'verticalReturnButtonStyle' },
          { Cell: 'verticalPageUpButtonStyle' },
          { Cell: 'verticalPageDownButtonStyle' },
          { Cell: 'verticalBackspaceButtonStyle' },
        ],
      },
    },
  ],
  verticalLastRowStyle: {
    size: { height: if orientation == 'portrait' then 54 else 40 },
  },
  verticalCandidates: {
    type: 'verticalCandidates',
    insets: { top: 8, bottom: 8, left: 8, right: 8 },
    maxColumns: 6,
    maxRows: 4,
    separatorColor: '#00000000',  // 透明，隱藏分隔線
    candidateStyle: 'verticalCandidateCellStyle',
  },
  verticalCandidateCellStyle: {
    highlightBackgroundColor: 0,
    preferredBackgroundColor: color[theme][candidateSelectedBgKey],
    preferredIndexColor: color[theme][candidateSelectedTextKey],
    preferredTextColor: color[theme][candidateSelectedTextKey],
    preferredCommentColor: color[theme][candidateSelectedTextKey],
    indexColor: color[theme][candidateUnselectedTextKey],
    textColor: color[theme][candidateUnselectedTextKey],
    commentColor: color[theme][candidateUnselectedTextKey],
    indexFontSize: fontSize['展开候选字体选中字体大小'],
    textFontSize: fontSize['展开候选字体选中字体大小'],
    commentFontSize: fontSize['未展开候选字体选中字体大小'],
  },

  // 縱向候選上翻頁按鈕
  verticalPageUpButtonStyle: {
    backgroundStyle: 'systemButtonBackgroundStyle',
    foregroundStyle: 'verticalPageUpButtonStyleForegroundStyle',
    action: { shortcut: '#verticalCandidatesPageUp' },
  },
  verticalPageUpButtonStyleForegroundStyle: {
    buttonStyleType: 'systemImage',
    systemImageName: 'chevron.up',
    normalColor: color[theme][candidateControlButtonTextKey],
    highlightColor: color[theme][candidateControlButtonTextKey],
    fontSize: fontSize['垂直候选控制按钮字体大小'],
  },

  // 縱向候選下翻頁按鈕
  verticalPageDownButtonStyle: {
    backgroundStyle: 'systemButtonBackgroundStyle',
    foregroundStyle: 'verticalPageDownButtonStyleForegroundStyle',
    action: { shortcut: '#verticalCandidatesPageDown' },
  },
  verticalPageDownButtonStyleForegroundStyle: {
    buttonStyleType: 'systemImage',
    systemImageName: 'chevron.down',
    normalColor: color[theme][candidateControlButtonTextKey],
    highlightColor: color[theme][candidateControlButtonTextKey],
    fontSize: fontSize['垂直候选控制按钮字体大小'],
  },

  // 縱向候選返回按鈕
  verticalReturnButtonStyle: {
    backgroundStyle: 'systemButtonBackgroundStyle',
    foregroundStyle: 'verticalReturnButtonStyleForegroundStyle',
    action: { shortcut: '#candidatesBarStateToggle' },
  },
  verticalReturnButtonStyleForegroundStyle: {
    buttonStyleType: 'text',
    text: '返回',
    normalColor: color[theme][candidateControlButtonTextKey],
    highlightColor: color[theme][candidateControlButtonTextKey],
    fontSize: fontSize['垂直候选返回按钮字体大小'],
  },

  // 縱向候選退格按鈕
  verticalBackspaceButtonStyle: {
    backgroundStyle: 'systemButtonBackgroundStyle',
    foregroundStyle: 'verticalBackspaceButtonStyleForegroundStyle',
    action: 'backspace',
  },
  verticalBackspaceButtonStyleForegroundStyle: {
    buttonStyleType: 'systemImage',
    systemImageName: 'delete.left',
    normalColor: color[theme][candidateControlButtonTextKey],
    highlightColor: color[theme][candidateControlButtonTextKey],
    fontSize: fontSize['垂直候选控制按钮字体大小'],
  },
} + (if std.length(settings.toolbarButtons) > 10 then 
    // 如果按鈕超過10個，顯示警告但不生成額外樣式
    {} 
  else 
    // 正常情況，不需要額外樣式
    {});

{
  getToolBar: getToolBar,
}
