// 符號鍵盤 Row 版本（豎屏）- 符號排成行，類似 numeric_row
local animation = import '../lib/animation.libsonnet';
local color = import '../lib/color.libsonnet';
local fontSize = import '../lib/fontSize.libsonnet';
local hintSymbolsData_symbolic = import '../lib/hintSymbolsData_symbolic.libsonnet';
local hintSymbolsStyles_symbolicRow = import '../lib/hintSymbolsStyles_symbolicRow.libsonnet';
local others = import '../lib/others.libsonnet';
local settings = import '../Settings.libsonnet';
local toolbar = import '../lib/toolbar.libsonnet';
local utils = import '../lib/utils.libsonnet';

local normalSize = { size: { width: '112.5/1125' } };

// 建立符號按鈕（使用字母鍵背景）
local createAlphaButton(params={}) =
  local hasHintSymbols = std.objectHas(hintSymbolsData_symbolic, params.key + 'Row');
  std.prune({
    size: std.get(params, 'size'),
    bounds: std.get(params, 'bounds'),
    backgroundStyle: 'symbolicRowButtonBackgroundStyle',
    foregroundStyle: params.key + 'RowButtonForegroundStyle',
    hintStyle: params.key + 'RowButtonHintStyle',
    action: std.get(params, 'action', { character: params.key }),
    animation: ['ButtonScaleAnimation'],
  }) + (if hasHintSymbols then {
    hintSymbolsStyle: params.key + 'RowButtonHintSymbolsStyle',
  } else {});


// 建立功能按鈕（使用系統鍵背景）
local createSystemButton(params={}) =
  std.prune({
    size: std.get(params, 'size'),
    bounds: std.get(params, 'bounds'),
    backgroundStyle: 'systemButtonBackgroundStyle',
    foregroundStyle: params.key + 'RowButtonForegroundStyle',
    action: std.get(params, 'action'),
    repeatAction: std.get(params, 'repeatAction'),
    animation: ['ButtonScaleAnimation'],
  });

local keyboard(theme) =
  {
    preeditHeight: others['竖屏']['preedit高度'],
    toolbarHeight: others['竖屏']['toolbar高度'],
    keyboardHeight: others['竖屏']['keyboard高度'],

    keyboardLayout: [
      // 第一行：[ ] { } # % ^ ⋯ 《 》
      {
        HStack: {
          subviews: [
            { Cell: 'lbracketRowButton' },
            { Cell: 'rbracketRowButton' },
            { Cell: 'lbraceRowButton' },
            { Cell: 'rbraceRowButton' },
            { Cell: 'hashRowButton' },
            { Cell: 'percentRowButton' },
            { Cell: 'caretRowButton' },
            { Cell: 'asteriskSRowButton' },
            { Cell: 'plusSRowButton' },
            { Cell: 'equalSRowButton' },
          ],
        },
      },
      // 第二行：_ / | ~ < > € £ ¥ ·
      {
        HStack: {
          subviews: [
            { Cell: 'underscoreRowButton' },
            { Cell: 'backslashRowButton' },
            { Cell: 'pipeRowButton' },
            { Cell: 'tildeRowButton' },
            { Cell: 'ltRowButton' },
            { Cell: 'gtRowButton' },
            { Cell: 'euroRowButton' },
            { Cell: 'poundRowButton' },
            { Cell: 'yenRowButton' },
            { Cell: 'middleDotRowButton' },
          ],
        },
      },
      // 第三行：123, 「, 」, ., ,, ?, !, ', backspace
      {
        HStack: {
          subviews: [
            { Cell: 'numericSRowButton' },
            { Cell: 'ellipsisRowButton' },
            { Cell: 'commaSRowButton' },
            { Cell: 'periodSRowButton' },
            { Cell: 'questionSRowButton' },
            { Cell: 'exclamSRowButton' },
            { Cell: 'lsquoteRowButton' },
            { Cell: 'rsquoteRowButton' },
            { Cell: 'backspaceSRowButton' },
          ],
        },
      },
      // 第四行：返回, 🔒lock, 空格, ", enter
      {
        HStack: {
          subviews: [
            { Cell: 'returnSRowButton' },
            { Cell: 'lockSRowButton' },
            { Cell: 'spaceSRowButton' },
            { Cell: 'dquoteSRowButton' },
            { Cell: 'enterSRowButton' },
          ],
        },
      },
    ],

    keyboardStyle: {
      backgroundStyle: 'keyboardBackgroundStyle',
    },
    keyboardBackgroundStyle: {
      buttonStyleType: 'geometry',
      normalColor: color[theme]['Row符號键盘背景顏色'],
    },

    // ===== 第一行 =====
    lbracketRowButton: createAlphaButton({ key: 'lbracket', action: { symbol: '[' } }) + normalSize + { swipeUpAction: { character: '［' } },
    lbracketRowButtonForegroundStyle: utils.makeTextStyle({
      text: '[', normalColor: color[theme]['Row符號鍵盤右側collection字體顏色'], highlightColor: color[theme]['Row符號鍵盤右側collection字體顏色'],
      fontSize: fontSize['Row符號键盘按键字体大小'],
    }),
    rbracketRowButton: createAlphaButton({ key: 'rbracket', action: { symbol: ']' } }) + normalSize + { swipeUpAction: { character: '］' } },
    rbracketRowButtonForegroundStyle: utils.makeTextStyle({
      text: ']', normalColor: color[theme]['Row符號鍵盤右側collection字體顏色'], highlightColor: color[theme]['Row符號鍵盤右側collection字體顏色'],
      fontSize: fontSize['Row符號键盘按键字体大小'],
    }),
    lbraceRowButton: createAlphaButton({ key: 'lbrace', action: { character: '{' } }) + normalSize + { swipeUpAction: { character: '｛' } },
    lbraceRowButtonForegroundStyle: utils.makeTextStyle({
      text: '{', normalColor: color[theme]['Row符號鍵盤右側collection字體顏色'], highlightColor: color[theme]['Row符號鍵盤右側collection字體顏色'],
      fontSize: fontSize['Row符號键盘按键字体大小'],
    }),
    rbraceRowButton: createAlphaButton({ key: 'rbrace', action: { character: '}' } }) + normalSize + { swipeUpAction: { character: '｝' } },
    rbraceRowButtonForegroundStyle: utils.makeTextStyle({
      text: '}', normalColor: color[theme]['Row符號鍵盤右側collection字體顏色'], highlightColor: color[theme]['Row符號鍵盤右側collection字體顏色'],
      fontSize: fontSize['Row符號键盘按键字体大小'],
    }),
    hashRowButton: createAlphaButton({ key: 'hash', action: { character: '#' } }) + normalSize + { swipeUpAction: { character: '＃' } },
    hashRowButtonForegroundStyle: utils.makeTextStyle({
      text: '#', normalColor: color[theme]['Row符號鍵盤右側collection字體顏色'], highlightColor: color[theme]['Row符號鍵盤右側collection字體顏色'],
      fontSize: fontSize['Row符號键盘按键字体大小'],
    }),
    percentRowButton: createAlphaButton({ key: 'percent', action: { character: '%' } }) + normalSize + { swipeUpAction: { character: '％' } },
    percentRowButtonForegroundStyle: utils.makeTextStyle({
      text: '%', normalColor: color[theme]['Row符號鍵盤右側collection字體顏色'], highlightColor: color[theme]['Row符號鍵盤右側collection字體顏色'],
      fontSize: fontSize['Row符號键盘按键字体大小'],
    }),
    caretRowButton: createAlphaButton({ key: 'caret', action: { character: '^' } }) + normalSize + { swipeUpAction: { character: '＾' } },
    caretRowButtonForegroundStyle: utils.makeTextStyle({
      text: '^', normalColor: color[theme]['Row符號鍵盤右側collection字體顏色'], highlightColor: color[theme]['Row符號鍵盤右側collection字體顏色'],
      fontSize: fontSize['Row符號键盘按键字体大小'],
    }),
    // asteriskS → ⋯（U+22EF）
    asteriskSRowButton: createAlphaButton({ key: 'asteriskS', action: { character: '⋯' } }) + normalSize,
    asteriskSRowButtonForegroundStyle: utils.makeTextStyle({
      text: '⋯', normalColor: color[theme]['Row符號鍵盤右側collection字體顏色'], highlightColor: color[theme]['Row符號鍵盤右側collection字體顏色'],
      fontSize: fontSize['Row符號键盘按键字体大小'],
    }),
    plusSRowButton: createAlphaButton({ key: 'plusS', action: { character: '《' } }) + normalSize + { swipeUpAction: { character: '〈' } },
    plusSRowButtonForegroundStyle: utils.makeTextStyle({
      text: '《', normalColor: color[theme]['Row符號鍵盤右側collection字體顏色'], highlightColor: color[theme]['Row符號鍵盤右側collection字體顏色'],
      fontSize: fontSize['Row符號键盘按键字体大小'],
    }),
    equalSRowButton: createAlphaButton({ key: 'equalS', action: { character: '》' } }) + normalSize + { swipeUpAction: { character: '〉' } },
    equalSRowButtonForegroundStyle: utils.makeTextStyle({
      text: '》', normalColor: color[theme]['Row符號鍵盤右側collection字體顏色'], highlightColor: color[theme]['Row符號鍵盤右側collection字體顏色'],
      fontSize: fontSize['Row符號键盘按键字体大小'],
    }),

    // ===== 第二行 =====
    underscoreRowButton: createAlphaButton({ key: 'underscore', action: { character: '_' } }) + normalSize + { swipeUpAction: { character: '＿' } },
    underscoreRowButtonForegroundStyle: utils.makeTextStyle({
      text: '_', normalColor: color[theme]['Row符號鍵盤右側collection字體顏色'], highlightColor: color[theme]['Row符號鍵盤右側collection字體顏色'],
      fontSize: fontSize['Row符號键盘按键字体大小'],
    }),
    // 第二行：row 2 - backslash key now outputs /
    backslashRowButton: createAlphaButton({ key: 'backslash', action: { character: '\\' } }) + normalSize + { swipeUpAction: { character: '＼' } },
    backslashRowButtonForegroundStyle: utils.makeTextStyle({
      text: '\\', normalColor: color[theme]['Row符號鍵盤右側collection字體顏色'], highlightColor: color[theme]['Row符號鍵盤右側collection字體顏色'],
      fontSize: fontSize['Row符號键盘按键字体大小'],
    }),
    pipeRowButton: createAlphaButton({ key: 'pipe', action: { character: '|' } }) + normalSize + { swipeUpAction: { character: '｜' } },
    pipeRowButtonForegroundStyle: utils.makeTextStyle({
      text: '|', normalColor: color[theme]['Row符號鍵盤右側collection字體顏色'], highlightColor: color[theme]['Row符號鍵盤右側collection字體顏色'],
      fontSize: fontSize['Row符號键盘按键字体大小'],
    }),
    tildeRowButton: createAlphaButton({ key: 'tilde', action: { character: '~' } }) + normalSize + { swipeUpAction: { character: '～' } },
    tildeRowButtonForegroundStyle: utils.makeTextStyle({
      text: '~', normalColor: color[theme]['Row符號鍵盤右側collection字體顏色'], highlightColor: color[theme]['Row符號鍵盤右側collection字體顏色'],
      fontSize: fontSize['Row符號键盘按键字体大小'],
    }),
    ltRowButton: createAlphaButton({ key: 'lt', action: { character: '<' } }) + normalSize + { swipeUpAction: { character: '＜' } },
    ltRowButtonForegroundStyle: utils.makeTextStyle({
      text: '<', normalColor: color[theme]['Row符號鍵盤右側collection字體顏色'], highlightColor: color[theme]['Row符號鍵盤右側collection字體顏色'],
      fontSize: fontSize['Row符號键盘按键字体大小'],
    }),
    gtRowButton: createAlphaButton({ key: 'gt', action: { character: '>' } }) + normalSize + { swipeUpAction: { character: '＞' } },
    gtRowButtonForegroundStyle: utils.makeTextStyle({
      text: '>', normalColor: color[theme]['Row符號鍵盤右側collection字體顏色'], highlightColor: color[theme]['Row符號鍵盤右側collection字體顏色'],
      fontSize: fontSize['Row符號键盘按键字体大小'],
    }),
    euroRowButton: createAlphaButton({ key: 'euro', action: { character: '€' } }) + normalSize,
    euroRowButtonForegroundStyle: utils.makeTextStyle({
      text: '€', normalColor: color[theme]['Row符號鍵盤右側collection字體顏色'], highlightColor: color[theme]['Row符號鍵盤右側collection字體顏色'],
      fontSize: fontSize['Row符號键盘按键字体大小'],
    }),
    poundRowButton: createAlphaButton({ key: 'pound', action: { character: '£' } }) + normalSize,
    poundRowButtonForegroundStyle: utils.makeTextStyle({
      text: '£', normalColor: color[theme]['Row符號鍵盤右側collection字體顏色'], highlightColor: color[theme]['Row符號鍵盤右側collection字體顏色'],
      fontSize: fontSize['Row符號键盘按键字体大小'],
    }),
    yenRowButton: createAlphaButton({ key: 'yen', action: { character: '¥' } }) + normalSize,
    yenRowButtonForegroundStyle: utils.makeTextStyle({
      text: '¥', normalColor: color[theme]['Row符號鍵盤右側collection字體顏色'], highlightColor: color[theme]['Row符號鍵盤右側collection字體顏色'],
      fontSize: fontSize['Row符號键盘按键字体大小'],
    }),
    middleDotRowButton: createAlphaButton({ key: 'middleDot', action: { character: '·' } }) + normalSize + { swipeUpAction: { character: '．' } },
    middleDotRowButtonForegroundStyle: utils.makeTextStyle({
      text: '·', normalColor: color[theme]['Row符號鍵盤右側collection字體顏色'], highlightColor: color[theme]['Row符號鍵盤右側collection字體顏色'],
      fontSize: fontSize['Row符號键盘按键字体大小'],
    }),

    // ===== 第三行 =====
    numericSRowButton: createSystemButton({
      key: 'numericS',
      action: { keyboardType: 'numeric' },
      size: { width: '168.75/1125' },
      bounds: { width: '151/168.75', alignment: 'left' },
    }),
    numericSRowButtonForegroundStyle: utils.makeTextStyle({
      text: '123', normalColor: color[theme]['Row符號鍵盤功能键文字颜色'], highlightColor: color[theme]['Row符號鍵盤功能键文字颜色'],
      fontSize: fontSize['数字键盘功能键字体大小'],
    }),
    // 第三行：「 」 . , ? ! '
    // ellipsisRowButton → 「
    ellipsisRowButton: createAlphaButton({ key: 'ellipsis', action: { character: '「' } }) + normalSize + { swipeUpAction: { character: '『' } },
    ellipsisRowButtonForegroundStyle: utils.makeTextStyle({
      text: '「', normalColor: color[theme]['Row符號鍵盤右側collection字體顏色'], highlightColor: color[theme]['Row符號鍵盤右側collection字體顏色'],
      fontSize: fontSize['Row符號键盘按键字体大小'],
    }),
    // commaSRowButton → 」
    commaSRowButton: createAlphaButton({ key: 'commaS', action: { character: '」' } }) + normalSize + { swipeUpAction: { character: '』' } },
    commaSRowButtonForegroundStyle: utils.makeTextStyle({
      text: '」', normalColor: color[theme]['Row符號鍵盤右側collection字體顏色'], highlightColor: color[theme]['Row符號鍵盤右側collection字體顏色'],
      fontSize: fontSize['Row符號键盘按键字体大小'],
    }),
    // periodSRowButton → .
    periodSRowButton: createAlphaButton({ key: 'periodS', action: { symbol: '.' } }) + normalSize + { swipeUpAction: { character: '。' } },
    periodSRowButtonForegroundStyle: utils.makeTextStyle({
      text: '.', normalColor: color[theme]['Row符號鍵盤右側collection字體顏色'], highlightColor: color[theme]['Row符號鍵盤右側collection字體顏色'],
      fontSize: fontSize['Row符號键盘按键字体大小'],
    }),
    // questionSRowButton → ,
    questionSRowButton: createAlphaButton({ key: 'questionS', action: { symbol: ',' } }) + normalSize + { swipeUpAction: { character: '，' } },
    questionSRowButtonForegroundStyle: utils.makeTextStyle({
      text: ',', normalColor: color[theme]['Row符號鍵盤右側collection字體顏色'], highlightColor: color[theme]['Row符號鍵盤右側collection字體顏色'],
      fontSize: fontSize['Row符號键盘按键字体大小'],
    }),
    // exclamSRowButton → ?
    exclamSRowButton: createAlphaButton({ key: 'exclamS', action: { symbol: '?' } }) + normalSize + { swipeUpAction: { character: '？' } },
    exclamSRowButtonForegroundStyle: utils.makeTextStyle({
      text: '?', normalColor: color[theme]['Row符號鍵盤右側collection字體顏色'], highlightColor: color[theme]['Row符號鍵盤右側collection字體顏色'],
      fontSize: fontSize['Row符號键盘按键字体大小'],
    }),
    // lsquoteRowButton → !
    lsquoteRowButton: createAlphaButton({ key: 'lsquote', action: { character: '!' } }) + normalSize + { swipeUpAction: { character: '！' } },
    lsquoteRowButtonForegroundStyle: utils.makeTextStyle({
      text: '!', normalColor: color[theme]['Row符號鍵盤右側collection字體顏色'], highlightColor: color[theme]['Row符號鍵盤右側collection字體顏色'],
      fontSize: fontSize['Row符號键盘按键字体大小'],
    }),
    // rsquoteRowButton → ‘ (U+2018)
    rsquoteRowButton: createAlphaButton({ key: 'rsquote', action: { symbol: '‘' } }) + normalSize,
    rsquoteRowButtonForegroundStyle: utils.makeTextStyle({
      text: '‘', normalColor: color[theme]['Row符號鍵盤右側collection字體顏色'], highlightColor: color[theme]['Row符號鍵盤右側collection字體顏色'],
      fontSize: fontSize['Row符號键盘按键字体大小'],
    }),
    backspaceSRowButton: createSystemButton({
      key: 'backspaceS',
      action: 'backspace',
      repeatAction: 'backspace',
      size: { width: '168.75/1125' },
      bounds: { width: '151/168.75', alignment: 'right' },
    }) + {
      foregroundStyle: ['backspaceSRowButtonForegroundStyle', 'backspaceSRowButtonDownForegroundStyle'],
      swipeUpAction: { shortcut: '#deleteText' },
      swipeDownAction: { shortcut: '#undo' },
    },
    backspaceSRowButtonForegroundStyle: utils.makeSystemImageStyle({
      systemImageName: 'delete.left',
      normalColor: color[theme]['Row符號鍵盤功能键文字颜色'],
      highlightColor: color[theme]['Row符號鍵盤功能键文字颜色'],
      fontSize: fontSize['数字键盘功能键字体大小'],
      center: { y: 0.5 },
    }),
    backspaceSRowButtonDownForegroundStyle: {
      buttonStyleType: 'text',
      text: 'undo',
      fontSize: fontSize['下划文字大小'],
      normalColor: color[theme]['Row符號鍵盤功能键文字颜色'],
      center: { x: 0.5, y: 0.8 },
    },

    // ===== 第四行 =====
    returnSRowButton: createSystemButton({
      key: 'returnS',
      action: 'returnLastKeyboard',
      size: { width: { percentage: if settings.spaceKeyLayout == '1' then 0.16 else if settings.spaceKeyLayout == '2' then 0.16 else 0.1342 } },
    }) + {
      swipeUpAction: { keyboardType: 'pinyin' },
    },
    returnSRowButtonForegroundStyle: utils.makeTextStyle({
      text: '返回', normalColor: color[theme]['Row符號鍵盤功能键文字颜色'], highlightColor: color[theme]['Row符號鍵盤功能键文字颜色'],
      fontSize: fontSize['数字键盘功能键字体大小'],
    }),
    // 第四行：lock（空格左），space，" dquote（空格右）
    spaceSRowButton: {
      backgroundStyle: 'spaceSRowButtonBackgroundStyle',
      foregroundStyle: 'spaceSRowButtonForegroundStyle',
      action: 'space',
      animation: ['ButtonScaleAnimation'],
    },
    spaceSRowButtonForegroundStyle: utils.makeTextStyle({
      text: '空格', normalColor: color[theme]['Row符號键盘空白键文字颜色'], highlightColor: color[theme]['Row符號键盘空白键文字颜色'],
      fontSize: fontSize['Row符號键盘空白键文字大小'],
    }),
    lockSRowButton: {
      backgroundStyle: 'symbolicRowButtonBackgroundStyle',
      foregroundStyle: [
        {
          styleName: 'unlockSRowButtonForegroundStyle',
          conditionKey: '$symbolicKeyboardLockState',
          conditionValue: false,
        },
        {
          styleName: 'lockSRowButtonForegroundStyle',
          conditionKey: '$symbolicKeyboardLockState',
          conditionValue: true,
        },
      ],
      action: 'symbolicKeyboardLockStateToggle',
      animation: ['ButtonScaleAnimation'],
      size: { width: { percentage: if settings.spaceKeyLayout == '1' then 0.14 else 0.10 } },
    },
    lockSRowButtonForegroundStyle: utils.makeSystemImageStyle({
      systemImageName: 'lock',
      normalColor: color[theme]['Row符號鍵盤功能键文字颜色'],
      highlightColor: color[theme]['Row符號鍵盤功能键文字颜色'],
      fontSize: fontSize['数字键盘功能键字体大小'],
      center: { y: 0.5 },
    }),
    unlockSRowButtonForegroundStyle: utils.makeSystemImageStyle({
      systemImageName: 'lock.open',
      normalColor: color[theme]['Row符號鍵盤功能键文字颜色'],
      highlightColor: color[theme]['Row符號鍵盤功能键文字颜色'],
      fontSize: fontSize['数字键盘功能键字体大小'],
      center: { y: 0.5 },
    }),
    // “ dquote 鍵（空格右）
    dquoteSRowButton: createAlphaButton({ key: 'dquoteS', action: { character: '“' } }) + { size: { width: { percentage: if settings.spaceKeyLayout == '1' then 0.14 else 0.10 } } },
    dquoteSRowButtonForegroundStyle: utils.makeTextStyle({
      text: '“', normalColor: color[theme]['Row数字键文字颜色'], highlightColor: color[theme]['Row数字键文字颜色'],
      fontSize: fontSize['Row数字键盘按键字体大小'],
    }),
    enterSRowButton: createSystemButton({
      key: 'enterS',
      action: 'enter',
      size: { width: { percentage: if settings.spaceKeyLayout == '1' then 0.16 else if settings.spaceKeyLayout == '2' then 0.16 else 0.1342 } },
    }) + {
      backgroundStyle: 'enterButtonBackgroundStyle',
      notification: ['returnKeyTypeChangedNotification'],
      swipeDownAction: { shortcut: '#换行' },
    },
    enterSRowButtonForegroundStyle: utils.makeTextStyle({
      text: '$returnKeyType',
      normalColor: color[theme]['Row符號鍵盤enter键文字颜色'],
      highlightColor: color[theme]['Row符號鍵盤enter键文字颜色'],
      fontSize: fontSize['数字键盘功能键字体大小'],
    }),

    // returnKeyType notification
    returnKeyTypeChangedNotification: {
      notificationType: 'returnKeyType',
      returnKeyType: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
      backgroundStyle: 'enterButtonBackgroundStyle',
      foregroundStyle: 'returnKeyTypeForegroundStyle',
    },
    returnKeyTypeForegroundStyle: utils.makeTextStyle({
      text: '$returnKeyType',
      normalColor: color[theme]['Row符號鍵盤enter键文字颜色'],
      highlightColor: color[theme]['Row符號鍵盤enter键文字颜色'],
      fontSize: fontSize['数字键盘功能键字体大小'],
    }),

    // ===== 背景樣式 =====
    numberButtonBackgroundStyle: utils.makeGeometryStyle({
      insets: { top: 2, left: 2, bottom: 2, right: 2 },
      normalColor: color[theme]['数字键背景颜色-普通'],
      highlightColor: color[theme]['数字键背景颜色-高亮'],
      cornerRadius: 7,
      normalLowerEdgeColor: color[theme]['数字键底边缘颜色-普通'],
      highlightLowerEdgeColor: color[theme]['数字键底边缘颜色-高亮'],
      borderSize: color[theme]['数字键边框宽度'],
      normalBorderColor: color[theme]['数字键边框颜色-普通'],
      highlightBorderColor: color[theme]['数字键边框颜色-高亮'],
    }),
    symbolicRowButtonBackgroundStyle: utils.makeGeometryStyle({
      insets: { top: 2, left: 2, bottom: 2, right: 2 },
      normalColor: color[theme]['Row符號鍵盤右側collection背景顏色'],
      highlightColor: color[theme]['Row符號鍵盤右側collection背景顏色-高亮'],
      cornerRadius: 7,
      normalLowerEdgeColor: color[theme]['Row符號鍵盤右側collection背景下邊緣顏色'],
      highlightLowerEdgeColor: color[theme]['Row符號鍵盤右側collection背景下邊緣顏色'],
      borderSize: color[theme]['Row符號鍵盤右側collection邊框寬度'],
      normalBorderColor: color[theme]['Row符號鍵盤右側collection邊框顏色'],
      highlightBorderColor: color[theme]['Row符號鍵盤右側collection邊框顏色'],
    }),
    spaceSRowButtonBackgroundStyle: utils.makeGeometryStyle({
      insets: { top: 2, left: 2, bottom: 2, right: 2 },
      normalColor: color[theme]['Row符號键盘空白键背景颜色-普通'],
      highlightColor: color[theme]['Row符號键盘空白键背景颜色-高亮'],
      cornerRadius: 7,
      normalLowerEdgeColor: color[theme]['Row符號键盘空白键阴影颜色-普通'],
      highlightLowerEdgeColor: color[theme]['Row符號键盘空白键阴影颜色-高亮'],
      borderSize: color[theme]['Row符號键盘空白键边框宽度'],
      normalBorderColor: color[theme]['Row符號键盘空白键边框颜色'],
      highlightBorderColor: color[theme]['Row符號键盘空白键边框颜色'],
    }),
    systemButtonBackgroundStyle: utils.makeGeometryStyle({
      insets: { top: 2, left: 2, bottom: 2, right: 2 },
      normalColor: color[theme]['Row符號鍵盤功能键背景颜色-普通'],
      highlightColor: color[theme]['Row符號鍵盤功能键背景颜色-高亮'],
      cornerRadius: 7,
      normalLowerEdgeColor: color[theme]['Row符號鍵盤功能键底边缘颜色-普通'],
      highlightLowerEdgeColor: color[theme]['Row符號鍵盤功能键底边缘颜色-高亮'],
      borderSize: color[theme]['Row符號鍵盤功能键边框宽度'],
      normalBorderColor: color[theme]['Row符號鍵盤功能键边框颜色-普通'],
      highlightBorderColor: color[theme]['Row符號鍵盤功能键边框颜色-高亮'],
    }),
    enterButtonBackgroundStyle: utils.makeGeometryStyle({
      insets: { top: 2, left: 2, bottom: 2, right: 2 },
      normalColor: color[theme]['Row符號鍵盤enter键背景颜色-普通'],
      highlightColor: color[theme]['Row符號鍵盤enter键背景颜色-高亮'],
      cornerRadius: 7,
      normalLowerEdgeColor: color[theme]['Row符號鍵盤enter键底边缘颜色-普通'],
      highlightLowerEdgeColor: color[theme]['Row符號鍵盤enter键底边缘颜色-高亮'],
      borderSize: color[theme]['Row符號鍵盤enter键边框宽度'],
      normalBorderColor: color[theme]['Row符號鍵盤enter键边框颜色-普通'],
      highlightBorderColor: color[theme]['Row符號鍵盤enter键边框颜色-高亮'],
    }),

    ButtonScaleAnimation: animation['26键按键动画'],
  } + 
  hintSymbolsStyles_symbolicRow.getStyle(theme, hintSymbolsData_symbolic) + 
  {
    // 批量生成所有 alpha 按鍵的點按氣泡 style（含正確的文字偏移）
    'lbracketRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'lbracketRowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'lbracketRowButtonSwipeUpHintForegroundStyle',
    },
    'lbracketRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '[',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
    },
    'rbracketRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'rbracketRowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'rbracketRowButtonSwipeUpHintForegroundStyle',
    },
    'rbracketRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: ']',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
    },
    'lbraceRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'lbraceRowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'lbraceRowButtonSwipeUpHintForegroundStyle',
    },
    'lbraceRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '{',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
    },
    'rbraceRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'rbraceRowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'rbraceRowButtonSwipeUpHintForegroundStyle',
    },
    'rbraceRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '}',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
    },
    'hashRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'hashRowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'hashRowButtonSwipeUpHintForegroundStyle',
    },
    'hashRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '#',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
    },
    'percentRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'percentRowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'percentRowButtonSwipeUpHintForegroundStyle',
    },
    'percentRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '%',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
    },
    'caretRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'caretRowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'caretRowButtonSwipeUpHintForegroundStyle',
    },
    'caretRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '^',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
    },
    'asteriskSRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'asteriskSRowButtonHintForegroundStyle',
    },
    'asteriskSRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '⋯',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
    },
    'plusSRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'plusSRowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'plusSRowButtonSwipeUpHintForegroundStyle',
    },
    'plusSRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '《',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
    },
    'equalSRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'equalSRowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'equalSRowButtonSwipeUpHintForegroundStyle',
    },
    'equalSRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '》',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
    },
    'underscoreRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'underscoreRowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'underscoreRowButtonSwipeUpHintForegroundStyle',
    },
    'underscoreRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '_',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
    },
    'backslashRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'backslashRowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'backslashRowButtonSwipeUpHintForegroundStyle',
    },
    'backslashRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '\\',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
    },
    'pipeRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'pipeRowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'pipeRowButtonSwipeUpHintForegroundStyle',
    },
    'pipeRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '|',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
    },
    'tildeRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'tildeRowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'tildeRowButtonSwipeUpHintForegroundStyle',
    },
    'tildeRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '~',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
    },
    'ltRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'ltRowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'ltRowButtonSwipeUpHintForegroundStyle',
    },
    'ltRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '<',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
    },
    'gtRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'gtRowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'gtRowButtonSwipeUpHintForegroundStyle',
    },
    'gtRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '>',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
    },
    'euroRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'euroRowButtonHintForegroundStyle',
    },
    'euroRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '€',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
    },
    'poundRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'poundRowButtonHintForegroundStyle',
    },
    'poundRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '£',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
    },
    'yenRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'yenRowButtonHintForegroundStyle',
    },
    'yenRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '¥',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
    },
    'middleDotRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'middleDotRowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'middleDotRowButtonSwipeUpHintForegroundStyle',
    },
    'middleDotRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '·',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
    },
    'ellipsisRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'ellipsisRowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'ellipsisRowButtonSwipeUpHintForegroundStyle',
    },
    'ellipsisRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '「',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
    },
    'commaSRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'commaSRowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'commaSRowButtonSwipeUpHintForegroundStyle',
    },
    'commaSRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '」',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
    },
    'periodSRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'periodSRowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'periodSRowButtonSwipeUpHintForegroundStyle',
    },
    'periodSRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '.',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
    },
    'questionSRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'questionSRowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'questionSRowButtonSwipeUpHintForegroundStyle',
    },
    'questionSRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: ',',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
    },
    'exclamSRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'exclamSRowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'exclamSRowButtonSwipeUpHintForegroundStyle',
    },
    'exclamSRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '?',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
    },
    'lsquoteRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'lsquoteRowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'lsquoteRowButtonSwipeUpHintForegroundStyle',
    },
    'lsquoteRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '!',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
    },
    'rsquoteRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'rsquoteRowButtonHintForegroundStyle',
    },
    'rsquoteRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '‘',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
    },
    'dquoteSRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'dquoteSRowButtonHintForegroundStyle',
    },
    'dquoteSRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '“',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
    },

  } + {
    'lbracketRowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '［',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    'rbracketRowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '］',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    'lbraceRowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '｛',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    'rbraceRowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '｝',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    'hashRowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '＃',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    'percentRowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '％',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    'caretRowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '＾',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    'plusSRowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '〈',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    'equalSRowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '〉',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    'underscoreRowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '＿',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    'backslashRowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '＼',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    'pipeRowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '｜',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    'tildeRowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '～',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    'ltRowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '＜',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    'gtRowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '＞',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    'middleDotRowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '．',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    'periodSRowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '。',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    'questionSRowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '，',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    'exclamSRowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '？',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    'lsquoteRowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '！',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    'ellipsisRowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '『',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    'commaSRowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '』',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row符號键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    // 點按氣泡背景（與拼音26鍵一致）
    alphabeticHintBackgroundStyle: {
      buttonStyleType: 'fileImage',
      contentMode: 'scaleAspectFit',
      insets: { left: -3, right: -3, top: -3, bottom: -3 },
      center: { y: 0.68 },
      normalImage: { file: 'hint', image: 'IMG3' },
      highlightImage: { file: 'hint', image: 'IMG3' },
    },
    // 長按氣泡背景（與拼音26鍵一致）
    alphabeticHintSymbolsBackgroundStyle: {
      buttonStyleType: 'fileImage',
      insets: { bottom: -10, left: 3, right: 3, top: -10 },
      normalImage: { file: 'hint', image: 'IMG1' },
      highlightImage: { file: 'hint', image: 'IMG1' },
    },
    // 長按選中背景（與拼音26鍵一致）
    alphabeticHintSymbolsSelectedStyle: {
      buttonStyleType: 'fileImage',
      insets: { bottom: -3, left: 6, right: 6, top: -3 },
      normalImage: { file: 'hint', image: 'IMG2' },
      highlightImage: { file: 'hint', image: 'IMG2' },
    },
  };

{
  new(theme, skinName='蝦米輸入法'):
    keyboard(theme) +
    toolbar.getToolBar(theme, 'portrait', 'symbolicRow', skinName) +
    utils.genNumberStyles(theme),
}
