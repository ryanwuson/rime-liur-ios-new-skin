// 數字鍵盤 Row 版本（豎屏）- 數字排成一行，類似 26 鍵的數字行
// 內容參考 default/iPhoneNumeric.libsonnet
local animation = import '../lib/animation.libsonnet';
local color = import '../lib/color.libsonnet';
local fontSize = import '../lib/fontSize.libsonnet';
local hintSymbolsData_numeric = import '../lib/hintSymbolsData_numeric.libsonnet';
local hintSymbolsStyles = import '../lib/hintSymbolsStyles_numericRow.libsonnet';
local others = import '../lib/others.libsonnet';
local settings = import '../Settings.libsonnet';
local swipeStyles = import '../lib/swipeStyles.libsonnet';
local toolbar = import '../lib/toolbar.libsonnet';
local utils = import '../lib/utils.libsonnet';

// 建立數字/字母按鈕（使用字母鍵背景）
local createAlphaButton(params={}) =
  local key = std.get(params, 'key');
  local buttonKey = key + 'Row';
  local hasLongPress = std.objectHas(hintSymbolsData_numeric, buttonKey);
  std.prune({
    size: std.get(params, 'size'),
    bounds: std.get(params, 'bounds'),
    backgroundStyle: 'numberButtonBackgroundStyle',
    foregroundStyle: params.key + 'RowButtonForegroundStyle',
    hintStyle: params.key + 'RowButtonHintStyle',
    [if hasLongPress then 'hintSymbolsStyle']: params.key + 'RowButtonHintSymbolsStyle',
    action: std.get(params, 'action', { character: params.key }),
    repeatAction: std.get(params, 'repeatAction'),
    animation: ['ButtonScaleAnimation'],
  });


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

local normalSize = { size: { width: '112.5/1125' } };

local keyboard(theme) =
  {
    preeditHeight: others['竖屏']['preedit高度'],
    toolbarHeight: others['竖屏']['toolbar高度'],
    keyboardHeight: others['竖屏']['keyboard高度'],

    keyboardLayout: [
      // 第一行：1 2 3 4 5 6 7 8 9 0
      {
        HStack: {
          subviews: [
            { Cell: 'number1RowButton' },
            { Cell: 'number2RowButton' },
            { Cell: 'number3RowButton' },
            { Cell: 'number4RowButton' },
            { Cell: 'number5RowButton' },
            { Cell: 'number6RowButton' },
            { Cell: 'number7RowButton' },
            { Cell: 'number8RowButton' },
            { Cell: 'number9RowButton' },
            { Cell: 'number0RowButton' },
          ],
        },
      },
      // 第二行：- / : ; ( ) $ & 「 」
      {
        HStack: {
          subviews: [
            { Cell: 'hyphenRowButton' },
            { Cell: 'slashRowButton' },
            { Cell: 'colonRowButton' },
            { Cell: 'semicolonRowButton' },
            { Cell: 'lparenRowButton' },
            { Cell: 'rparenRowButton' },
            { Cell: 'dollarRowButton' },
            { Cell: 'ampersandRowButton' },
            { Cell: 'lquoteRowButton' },
            { Cell: 'rquoteRowButton' },
          ],
        },
      },
      // 第三行：#+=, +, *, ，, 。, 、, ？, ！, backspace
      {
        HStack: {
          subviews: [
            { Cell: 'symbolicRowButton' },
            { Cell: 'plusRowButton' },
            { Cell: 'asteriskRowButton' },
            { Cell: 'chineseCommaRowButton' },
            { Cell: 'chinesePeriodRowButton' },
            { Cell: 'ideographicCommaRowButton' },
            { Cell: 'questionFullRowButton' },
            { Cell: 'exclamFullRowButton' },
            { Cell: 'backspaceRowButton' },
          ],
        },
      },
      // 第四行：返回, =, 空格, ., enter
      {
        HStack: {
          subviews: [
            { Cell: 'returnRowButton' },
            { Cell: 'equalRowButton' },
            { Cell: 'spaceRowButton' },
            { Cell: 'dotRowButton' },
            { Cell: 'enterRowButton' },
          ],
        },
      },
    ],

    keyboardStyle: {
      backgroundStyle: 'keyboardBackgroundStyle',
    },
    keyboardBackgroundStyle: {
      buttonStyleType: 'geometry',
      normalColor: color[theme]['数字键盘背景顏色'],
    },

    // ===== 第一行：數字鍵 =====
    number1RowButton: createAlphaButton({ key: 'number1', action: { character: '1' } }) + normalSize + { swipeUpAction: { character: '１' } },
    number1RowButtonForegroundStyle: utils.makeTextStyle({
      text: '1', normalColor: color[theme]['数字键文字颜色'], highlightColor: color[theme]['数字键文字颜色'],
      fontSize: fontSize['Row数字键盘按键字体大小'],
    }),
    number2RowButton: createAlphaButton({ key: 'number2', action: { character: '2' } }) + normalSize + { swipeUpAction: { character: '２' } },
    number2RowButtonForegroundStyle: utils.makeTextStyle({
      text: '2', normalColor: color[theme]['数字键文字颜色'], highlightColor: color[theme]['数字键文字颜色'],
      fontSize: fontSize['Row数字键盘按键字体大小'],
    }),
    number3RowButton: createAlphaButton({ key: 'number3', action: { character: '3' } }) + normalSize + { swipeUpAction: { character: '３' } },
    number3RowButtonForegroundStyle: utils.makeTextStyle({
      text: '3', normalColor: color[theme]['数字键文字颜色'], highlightColor: color[theme]['数字键文字颜色'],
      fontSize: fontSize['Row数字键盘按键字体大小'],
    }),
    number4RowButton: createAlphaButton({ key: 'number4', action: { character: '4' } }) + normalSize + { swipeUpAction: { character: '４' } },
    number4RowButtonForegroundStyle: utils.makeTextStyle({
      text: '4', normalColor: color[theme]['数字键文字颜色'], highlightColor: color[theme]['数字键文字颜色'],
      fontSize: fontSize['Row数字键盘按键字体大小'],
    }),
    number5RowButton: createAlphaButton({ key: 'number5', action: { character: '5' } }) + normalSize + { swipeUpAction: { character: '５' } },
    number5RowButtonForegroundStyle: utils.makeTextStyle({
      text: '5', normalColor: color[theme]['数字键文字颜色'], highlightColor: color[theme]['数字键文字颜色'],
      fontSize: fontSize['Row数字键盘按键字体大小'],
    }),
    number6RowButton: createAlphaButton({ key: 'number6', action: { character: '6' } }) + normalSize + { swipeUpAction: { character: '６' } },
    number6RowButtonForegroundStyle: utils.makeTextStyle({
      text: '6', normalColor: color[theme]['数字键文字颜色'], highlightColor: color[theme]['数字键文字颜色'],
      fontSize: fontSize['Row数字键盘按键字体大小'],
    }),
    number7RowButton: createAlphaButton({ key: 'number7', action: { character: '7' } }) + normalSize + { swipeUpAction: { character: '７' } },
    number7RowButtonForegroundStyle: utils.makeTextStyle({
      text: '7', normalColor: color[theme]['数字键文字颜色'], highlightColor: color[theme]['数字键文字颜色'],
      fontSize: fontSize['Row数字键盘按键字体大小'],
    }),
    number8RowButton: createAlphaButton({ key: 'number8', action: { character: '8' } }) + normalSize + { swipeUpAction: { character: '８' } },
    number8RowButtonForegroundStyle: utils.makeTextStyle({
      text: '8', normalColor: color[theme]['数字键文字颜色'], highlightColor: color[theme]['数字键文字颜色'],
      fontSize: fontSize['Row数字键盘按键字体大小'],
    }),
    number9RowButton: createAlphaButton({ key: 'number9', action: { character: '9' } }) + normalSize + { swipeUpAction: { character: '９' } },
    number9RowButtonForegroundStyle: utils.makeTextStyle({
      text: '9', normalColor: color[theme]['数字键文字颜色'], highlightColor: color[theme]['数字键文字颜色'],
      fontSize: fontSize['Row数字键盘按键字体大小'],
    }),
    number0RowButton: createAlphaButton({ key: 'number0', action: { character: '0' } }) + normalSize + { swipeUpAction: { character: '０' } },
    number0RowButtonForegroundStyle: utils.makeTextStyle({
      text: '0', normalColor: color[theme]['数字键文字颜色'], highlightColor: color[theme]['数字键文字颜色'],
      fontSize: fontSize['Row数字键盘按键字体大小'],
    }),

    // ===== 第二行：符號鍵 =====
    hyphenRowButton: createAlphaButton({ key: 'hyphen', action: { character: '-' } }) + normalSize + { swipeUpAction: { character: '－' } },
    hyphenRowButtonForegroundStyle: utils.makeTextStyle({
      text: '-', normalColor: color[theme]['Row数字键文字颜色'], highlightColor: color[theme]['Row数字键文字颜色'],
      fontSize: fontSize['Row数字键盘按键字体大小'],
    }),
    slashRowButton: createAlphaButton({ key: 'slash', action: { character: '/' } }) + normalSize + { swipeUpAction: { character: '／' } },
    slashRowButtonForegroundStyle: utils.makeTextStyle({
      text: '/', normalColor: color[theme]['Row数字键文字颜色'], highlightColor: color[theme]['Row数字键文字颜色'],
      fontSize: fontSize['Row数字键盘按键字体大小'],
    }),
    colonRowButton: createAlphaButton({ key: 'colon', action: { character: ':' } }) + normalSize + { swipeUpAction: { character: '：' } },
    colonRowButtonForegroundStyle: utils.makeTextStyle({
      text: ':', normalColor: color[theme]['Row数字键文字颜色'], highlightColor: color[theme]['Row数字键文字颜色'],
      fontSize: fontSize['Row数字键盘按键字体大小'],
    }),
    semicolonRowButton: createAlphaButton({ key: 'semicolon', action: { symbol: ';' } }) + normalSize + { swipeUpAction: { character: '；' } },
    semicolonRowButtonForegroundStyle: utils.makeTextStyle({
      text: ';', normalColor: color[theme]['Row数字键文字颜色'], highlightColor: color[theme]['Row数字键文字颜色'],
      fontSize: fontSize['Row数字键盘按键字体大小'],
    }),
    lparenRowButton: createAlphaButton({ key: 'lparen', action: { character: '(' } }) + normalSize + { swipeUpAction: { character: '（' } },
    lparenRowButtonForegroundStyle: utils.makeTextStyle({
      text: '(', normalColor: color[theme]['Row数字键文字颜色'], highlightColor: color[theme]['Row数字键文字颜色'],
      fontSize: fontSize['Row数字键盘按键字体大小'],
    }),
    rparenRowButton: createAlphaButton({ key: 'rparen', action: { character: ')' } }) + normalSize + { swipeUpAction: { character: '）' } },
    rparenRowButtonForegroundStyle: utils.makeTextStyle({
      text: ')', normalColor: color[theme]['Row数字键文字颜色'], highlightColor: color[theme]['Row数字键文字颜色'],
      fontSize: fontSize['Row数字键盘按键字体大小'],
    }),
    dollarRowButton: createAlphaButton({ key: 'dollar', action: { character: '$' } }) + normalSize + { swipeUpAction: { character: '＄' } },
    dollarRowButtonForegroundStyle: utils.makeTextStyle({
      text: '$', normalColor: color[theme]['Row数字键文字颜色'], highlightColor: color[theme]['Row数字键文字颜色'],
      fontSize: fontSize['Row数字键盘按键字体大小'],
    }),
    ampersandRowButton: createAlphaButton({ key: 'ampersand', action: { character: '&' } }) + normalSize + { swipeUpAction: { character: '＆' } },
    ampersandRowButtonForegroundStyle: utils.makeTextStyle({
      text: '&', normalColor: color[theme]['Row数字键文字颜色'], highlightColor: color[theme]['Row数字键文字颜色'],
      fontSize: fontSize['Row数字键盘按键字体大小'],
    }),
    lquoteRowButton: createAlphaButton({ key: 'lquote', action: { character: '@' } }) + normalSize + { swipeUpAction: { character: '＠' } },
    lquoteRowButtonForegroundStyle: utils.makeTextStyle({
      text: '@', normalColor: color[theme]['Row数字键文字颜色'], highlightColor: color[theme]['Row数字键文字颜色'],
      fontSize: fontSize['Row数字键盘按键字体大小'],
    }),
    rquoteRowButton: createAlphaButton({ key: 'rquote', action: { character: '※' } }) + normalSize,
    rquoteRowButtonForegroundStyle: utils.makeTextStyle({
      text: '※', normalColor: color[theme]['Row数字键文字颜色'], highlightColor: color[theme]['Row数字键文字颜色'],
      fontSize: fontSize['Row数字键盘按键字体大小'],
    }),

    // ===== 第三行 =====
    // #+=（切換到符號鍵盤）
    symbolicRowButton: createSystemButton({
      key: 'symbolic',
      action: { keyboardType: 'symbolic' },
      size: { width: '168.75/1125' },
      bounds: { width: '151/168.75', alignment: 'left' },
    }),
    symbolicRowButtonForegroundStyle: utils.makeTextStyle({
      text: '#+=', normalColor: color[theme]['Row数字键盘功能键文字颜色'], highlightColor: color[theme]['Row数字键盘功能键文字颜色'],
      fontSize: fontSize['数字键盘功能键字体大小'],
    }),
    plusRowButton: createAlphaButton({ key: 'plus', action: { character: '+' } }) + normalSize + { swipeUpAction: { character: '＋' } },
    plusRowButtonForegroundStyle: utils.makeTextStyle({
      text: '+', normalColor: color[theme]['Row数字键文字颜色'], highlightColor: color[theme]['Row数字键文字颜色'],
      fontSize: fontSize['Row数字键盘按键字体大小'],
    }),
    asteriskRowButton: createAlphaButton({ key: 'asterisk', action: { character: '*' } }) + normalSize + { swipeUpAction: { character: '＊' } },
    asteriskRowButtonForegroundStyle: utils.makeTextStyle({
      text: '*', normalColor: color[theme]['Row数字键文字颜色'], highlightColor: color[theme]['Row数字键文字颜色'],
      fontSize: fontSize['Row数字键盘按键字体大小'],
    }),
    chineseCommaRowButton: createAlphaButton({ key: 'chineseComma', action: { symbol: '.' } }) + normalSize + { swipeUpAction: { character: '。' } },
    chineseCommaRowButtonForegroundStyle: utils.makeTextStyle({
      text: '.', normalColor: color[theme]['Row数字键文字颜色'], highlightColor: color[theme]['Row数字键文字颜色'],
      fontSize: fontSize['Row数字键盘按键字体大小'],
    }),
    chinesePeriodRowButton: createAlphaButton({ key: 'chinesePeriod', action: { symbol: ',' } }) + normalSize + { swipeUpAction: { character: '，' } },
    chinesePeriodRowButtonForegroundStyle: utils.makeTextStyle({
      text: ',', normalColor: color[theme]['Row数字键文字颜色'], highlightColor: color[theme]['Row数字键文字颜色'],
      fontSize: fontSize['Row数字键盘按键字体大小'],
    }),
    ideographicCommaRowButton: createAlphaButton({ key: 'ideographicComma', action: { symbol: '?' } }) + normalSize + { swipeUpAction: { character: '？' } },
    ideographicCommaRowButtonForegroundStyle: utils.makeTextStyle({
      text: '?', normalColor: color[theme]['Row数字键文字颜色'], highlightColor: color[theme]['Row数字键文字颜色'],
      fontSize: fontSize['Row数字键盘按键字体大小'],
    }),
    questionFullRowButton: createAlphaButton({ key: 'questionFull', action: { character: '!' } }) + normalSize + { swipeUpAction: { character: '！' } },
    questionFullRowButtonForegroundStyle: utils.makeTextStyle({
      text: '!', normalColor: color[theme]['Row数字键文字颜色'], highlightColor: color[theme]['Row数字键文字颜色'],
      fontSize: fontSize['Row数字键盘按键字体大小'],
    }),
    exclamFullRowButton: createAlphaButton({ key: 'exclamFull', action: { symbol: '‘' } }) + normalSize,
    exclamFullRowButtonForegroundStyle: utils.makeTextStyle({
      text: '‘', normalColor: color[theme]['Row数字键文字颜色'], highlightColor: color[theme]['Row数字键文字颜色'],
      fontSize: fontSize['Row数字键盘按键字体大小'],
    }),
    // backspace
    backspaceRowButton: createSystemButton({
      key: 'backspace',
      action: 'backspace',
      repeatAction: 'backspace',
      size: { width: '168.75/1125' },
      bounds: { width: '151/168.75', alignment: 'right' },
    }) + {
      foregroundStyle: ['backspaceRowButtonForegroundStyle', 'backspaceRowButtonDownForegroundStyle'],
      swipeUpAction: { shortcut: '#deleteText' },
      swipeDownAction: { shortcut: '#undo' },
    },
    backspaceRowButtonForegroundStyle: utils.makeSystemImageStyle({
      systemImageName: 'delete.left',
      normalColor: color[theme]['Row数字键盘功能键文字颜色'],
      highlightColor: color[theme]['Row数字键盘功能键文字颜色'],
      fontSize: fontSize['数字键盘功能键字体大小'],
      center: { y: 0.5 },
    }),
    backspaceRowButtonDownForegroundStyle: {
      buttonStyleType: 'text',
      text: 'undo',
      fontSize: fontSize['下划文字大小'],
      normalColor: color[theme]['Row数字键盘功能键文字颜色'],
      center: { x: 0.5, y: 0.8 },
    },

    // ===== 第四行 =====
    // 返回（回到上一個鍵盤）
    returnRowButton: createSystemButton({
      key: 'return',
      action: 'returnLastKeyboard',
      size: { width: { percentage: if settings.spaceKeyLayout == '1' then 0.16 else if settings.spaceKeyLayout == '2' then 0.16 else 0.1342 } },
    }) + {
      swipeUpAction: { keyboardType: 'pinyin' },
    },
    returnRowButtonForegroundStyle: utils.makeTextStyle({
      text: '返回', normalColor: color[theme]['Row数字键盘功能键文字颜色'], highlightColor: color[theme]['Row数字键盘功能键文字颜色'],
      fontSize: fontSize['数字键盘功能键字体大小'],
    }),
    // = 鍵（空格左方）
    equalRowButton: createAlphaButton({ key: 'equal', action: { character: '=' } }) + { size: { width: { percentage: if settings.spaceKeyLayout == '1' then 0.14 else 0.10 } } } + { swipeUpAction: { character: '＝' } },
    equalRowButtonForegroundStyle: utils.makeTextStyle({
      text: '=', normalColor: color[theme]['Row数字键文字颜色'], highlightColor: color[theme]['Row数字键文字颜色'],
      fontSize: fontSize['Row数字键盘按键字体大小'],
    }),
    // 空格
    spaceRowButton: {
      backgroundStyle: 'spaceRowButtonBackgroundStyle',
      foregroundStyle: 'spaceRowButtonForegroundStyle',
      action: 'space',
      animation: ['ButtonScaleAnimation'],
    },
    spaceRowButtonForegroundStyle: utils.makeTextStyle({
      text: '空格', normalColor: color[theme]['Row数字键盘空白键文字颜色'], highlightColor: color[theme]['Row数字键盘空白键文字颜色'],
      fontSize: fontSize['Row数字键盘空白键文字大小'],
    }),
    // “ 鍵（空格右方）
    dotRowButton: createAlphaButton({ key: 'dot', action: { character: '“' } }) + {
      size: { width: { percentage: if settings.spaceKeyLayout == '1' then 0.14 else 0.10 } },
    },
    dotRowButtonForegroundStyle: utils.makeTextStyle({
      text: '“', normalColor: color[theme]['Row数字键文字颜色'], highlightColor: color[theme]['Row数字键文字颜色'],
      fontSize: fontSize['Row数字键盘按键字体大小'],
    }),
    // Enter
    enterRowButton: createSystemButton({
      key: 'enter',
      action: 'enter',
      size: { width: { percentage: if settings.spaceKeyLayout == '1' then 0.16 else if settings.spaceKeyLayout == '2' then 0.16 else 0.1342 } },
    }) + {
      backgroundStyle: 'enterButtonBackgroundStyle',
      notification: ['returnKeyTypeChangedNotification'],
      swipeDownAction: { shortcut: '#换行' },
    },
    enterRowButtonForegroundStyle: utils.makeTextStyle({
      text: '$returnKeyType',
      normalColor: color[theme]['Row数字键盘enter键文字颜色'],
      highlightColor: color[theme]['Row数字键盘enter键文字颜色'],
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
      normalColor: color[theme]['Row数字键盘enter键文字颜色'],
      highlightColor: color[theme]['Row数字键盘enter键文字颜色'],
      fontSize: fontSize['数字键盘功能键字体大小'],
    }),

    // ===== 背景樣式 =====
    numberButtonBackgroundStyle: utils.makeGeometryStyle({
      insets: { top: 2, left: 2, bottom: 2, right: 2 },
      normalColor: color[theme]['Row数字键背景颜色-普通'],
      highlightColor: color[theme]['Row数字键背景颜色-高亮'],
      cornerRadius: 7,
      normalLowerEdgeColor: color[theme]['Row数字键底边缘颜色-普通'],
      highlightLowerEdgeColor: color[theme]['Row数字键底边缘颜色-高亮'],
      borderSize: color[theme]['Row数字键边框宽度'],
      normalBorderColor: color[theme]['Row数字键边框颜色-普通'],
      highlightBorderColor: color[theme]['Row数字键边框颜色-高亮'],
    }),
    spaceRowButtonBackgroundStyle: utils.makeGeometryStyle({
      insets: { top: 2, left: 2, bottom: 2, right: 2 },
      normalColor: color[theme]['Row数字键盘空白键背景颜色-普通'],
      highlightColor: color[theme]['Row数字键盘空白键背景颜色-高亮'],
      cornerRadius: 7,
      normalLowerEdgeColor: color[theme]['Row数字键盘空白键阴影颜色-普通'],
      highlightLowerEdgeColor: color[theme]['Row数字键盘空白键阴影颜色-高亮'],
      borderSize: color[theme]['Row数字键盘空白键边框宽度'],
      normalBorderColor: color[theme]['Row数字键盘空白键边框颜色'],
      highlightBorderColor: color[theme]['Row数字键盘空白键边框颜色'],
    }),
    systemButtonBackgroundStyle: utils.makeGeometryStyle({
      insets: { top: 2, left: 2, bottom: 2, right: 2 },
      normalColor: color[theme]['Row数字键盘功能键背景颜色-普通'],
      highlightColor: color[theme]['Row数字键盘功能键背景颜色-高亮'],
      cornerRadius: 7,
      normalLowerEdgeColor: color[theme]['Row数字键盘功能键底边缘颜色-普通'],
      highlightLowerEdgeColor: color[theme]['Row数字键盘功能键底边缘颜色-高亮'],
      borderSize: color[theme]['Row数字键盘功能键边框宽度'],
      normalBorderColor: color[theme]['Row数字键盘功能键边框颜色-普通'],
      highlightBorderColor: color[theme]['Row数字键盘功能键边框颜色-高亮'],
    }),
    enterButtonBackgroundStyle: utils.makeGeometryStyle({
      insets: { top: 2, left: 2, bottom: 2, right: 2 },
      normalColor: color[theme]['Row数字键盘enter键背景颜色-普通'],
      highlightColor: color[theme]['Row数字键盘enter键背景颜色-高亮'],
      cornerRadius: 7,
      normalLowerEdgeColor: color[theme]['Row数字键盘enter键底边缘颜色-普通'],
      highlightLowerEdgeColor: color[theme]['Row数字键盘enter键底边缘颜色-高亮'],
      borderSize: color[theme]['Row数字键盘enter键边框宽度'],
      normalBorderColor: color[theme]['Row数字键盘enter键边框颜色-普通'],
      highlightBorderColor: color[theme]['Row数字键盘enter键边框颜色-高亮'],
    }),

    ButtonScaleAnimation: animation['26键按键动画'],
  } + {
    // 批量生成所有 alpha 按鍵的點按氣泡 style（含正確的文字偏移）
    'number1RowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'number1RowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'number1RowButtonSwipeUpHintForegroundStyle',
    },
    'number1RowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '1',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
    },
    'number2RowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'number2RowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'number2RowButtonSwipeUpHintForegroundStyle',
    },
    'number2RowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '2',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
    },
    'number3RowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'number3RowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'number3RowButtonSwipeUpHintForegroundStyle',
    },
    'number3RowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '3',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
    },
    'number4RowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'number4RowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'number4RowButtonSwipeUpHintForegroundStyle',
    },
    'number4RowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '4',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
    },
    'number5RowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'number5RowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'number5RowButtonSwipeUpHintForegroundStyle',
    },
    'number5RowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '5',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
    },
    'number6RowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'number6RowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'number6RowButtonSwipeUpHintForegroundStyle',
    },
    'number6RowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '6',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
    },
    'number7RowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'number7RowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'number7RowButtonSwipeUpHintForegroundStyle',
    },
    'number7RowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '7',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
    },
    'number8RowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'number8RowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'number8RowButtonSwipeUpHintForegroundStyle',
    },
    'number8RowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '8',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
    },
    'number9RowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'number9RowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'number9RowButtonSwipeUpHintForegroundStyle',
    },
    'number9RowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '9',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
    },
    'number0RowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'number0RowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'number0RowButtonSwipeUpHintForegroundStyle',
    },
    'number0RowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '0',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
    },
    'hyphenRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'hyphenRowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'hyphenRowButtonSwipeUpHintForegroundStyle',
    },
    'hyphenRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '-',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
    },
    'slashRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'slashRowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'slashRowButtonSwipeUpHintForegroundStyle',
    },
    'slashRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '/',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
    },
    'colonRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'colonRowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'colonRowButtonSwipeUpHintForegroundStyle',
    },
    'colonRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: ':',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
    },
    'semicolonRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'semicolonRowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'semicolonRowButtonSwipeUpHintForegroundStyle',
    },
    'semicolonRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: ';',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
    },
    'lparenRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'lparenRowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'lparenRowButtonSwipeUpHintForegroundStyle',
    },
    'lparenRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '(',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
    },
    'rparenRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'rparenRowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'rparenRowButtonSwipeUpHintForegroundStyle',
    },
    'rparenRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: ')',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
    },
    'dollarRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'dollarRowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'dollarRowButtonSwipeUpHintForegroundStyle',
    },
    'dollarRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '$',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
    },
    'ampersandRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'ampersandRowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'ampersandRowButtonSwipeUpHintForegroundStyle',
    },
    'ampersandRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '&',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
    },
    'lquoteRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'lquoteRowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'lquoteRowButtonSwipeUpHintForegroundStyle',
    },
    'lquoteRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '@',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
    },
    'rquoteRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'rquoteRowButtonHintForegroundStyle',
    },
    'rquoteRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '※',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
    },
    'plusRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'plusRowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'plusRowButtonSwipeUpHintForegroundStyle',
    },
    'plusRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '+',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
    },
    'asteriskRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'asteriskRowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'asteriskRowButtonSwipeUpHintForegroundStyle',
    },
    'asteriskRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '*',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
    },
    'chineseCommaRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'chineseCommaRowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'chineseCommaRowButtonSwipeUpHintForegroundStyle',
    },
    'chineseCommaRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '.',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
    },
    'chinesePeriodRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'chinesePeriodRowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'chinesePeriodRowButtonSwipeUpHintForegroundStyle',
    },
    'chinesePeriodRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: ',',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
    },
    'ideographicCommaRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'ideographicCommaRowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'ideographicCommaRowButtonSwipeUpHintForegroundStyle',
    },
    'ideographicCommaRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '?',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
    },
    'questionFullRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'questionFullRowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'questionFullRowButtonSwipeUpHintForegroundStyle',
    },
    'questionFullRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '!',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
    },
    'exclamFullRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'exclamFullRowButtonHintForegroundStyle',
    },
    'exclamFullRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '‘',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
    },
    'equalRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'equalRowButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'equalRowButtonSwipeUpHintForegroundStyle',
    },
    'equalRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '=',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
    },
    'dotRowButtonHintStyle': {
    checkIfOverflowsParentHeight: false,
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'dotRowButtonHintForegroundStyle',
    },
    'dotRowButtonHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '“',
      center: { x: 0.5, y: 0.63 },
      fontSize: fontSize['划动气泡前景文字大小'],
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
    },
  } + {
    'number1RowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '１',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    'number2RowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '２',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    'number3RowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '３',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    'number4RowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '４',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    'number5RowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '５',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    'number6RowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '６',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    'number7RowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '７',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    'number8RowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '８',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    'number9RowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '９',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    'number0RowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '０',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    'hyphenRowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '－',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    'slashRowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '／',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    'colonRowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '：',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    'semicolonRowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '；',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    'lparenRowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '（',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    'rparenRowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '）',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    'dollarRowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '＄',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    'ampersandRowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '＆',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    'lquoteRowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '＠',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    'plusRowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '＋',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    'asteriskRowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '＊',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    'chineseCommaRowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '。',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    'chinesePeriodRowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '，',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    'ideographicCommaRowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '？',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    'questionFullRowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '！',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
      center: { x: 0.5, y: 0.63 },
    },
    'equalRowButtonSwipeUpHintForegroundStyle': {
      buttonStyleType: 'text',
      text: '＝',
      fontSize: fontSize['划动气泡前景文字大小'],
      fontWeight: 'medium',
      normalColor: color[theme]['Row数字键盘按下气泡文字顏色'],
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
      insets: { left: 6, right: 6, top: -3, bottom: -3 },
      normalImage: { file: 'hint', image: 'IMG2' },
      highlightImage: { file: 'hint', image: 'IMG2' },
    },
  };

// 創建數字鍵盤的長按樣式（直接使用 hintSymbolsStyles.getStyle，與拼音26鍵一致）
local createNumericHintSymbolsStyles(theme) =
  hintSymbolsStyles.getStyle(theme, hintSymbolsData_numeric);

{
  new(theme, skinName='蝦米輸入法'):
    keyboard(theme) +
    createNumericHintSymbolsStyles(theme) +
    toolbar.getToolBar(theme, 'portrait', 'numeric', skinName) +
    utils.genNumberStyles(theme),
}
