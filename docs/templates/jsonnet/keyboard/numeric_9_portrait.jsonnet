local animation = import '../lib/animation.libsonnet';
local collectionData = import '../lib/collectionData.libsonnet';
local color = import '../lib/color.libsonnet';
local fontSize = import '../lib/fontSize.libsonnet';
local others = import '../lib/others.libsonnet';
local toolbar = import '../lib/toolbar.libsonnet';
local utils = import '../lib/utils.libsonnet';
local swipeStyles = import '../lib/swipeStyles.libsonnet';
local settings = import '../Settings.libsonnet';

// 建立按鈕的函數
local createButton(params={}) =
  local isNumber = std.get(params, 'isNumber', true);
  local isEnter = std.get(params, 'key') == 'enter';
  std.prune({
    // 每個按鈕高度均分為 1/4（54/216）
    size: std.get(params, 'size', { height: '1/4' }),
    bounds: std.get(params, 'bounds'),
    // Enter 鍵使用獨立背景，數字鍵使用字母鍵背景，其他功能鍵使用系統鍵背景
    backgroundStyle: if isEnter then 'enterButtonBackgroundStyle' else if isNumber then 'numberButtonBackgroundStyle' else 'systemButtonBackgroundStyle',
    foregroundStyle: if isNumber then 'number' + params.key + 'ButtonForegroundStyle' else params.key + 'ButtonForegroundStyle',
    action: std.get(params, 'action', { character: params.key }),
    repeatAction: std.get(params, 'repeatAction'),
    // 動畫
    animation: ['ButtonScaleAnimation'],
  });

local keyboard(theme) =
  {
    // 設定鍵盤高度，與中英文鍵盤一致
    preeditHeight: others['竖屏']['preedit高度'],
    toolbarHeight: others['竖屏']['toolbar高度'],
    keyboardHeight: others['竖屏']['keyboard高度'],

    keyboardLayout: [
      {
        VStack: {
          style: 'VStackStyle1',
          subviews: [
            { Cell: 'collection' },
            { Cell: 'symbolButton' },
          ],
        },
      },
      {
        VStack: {
          style: 'VStackStyle2',
          subviews: [
            { Cell: 'number1Button' },
            { Cell: 'number4Button' },
            { Cell: 'number7Button' },
            { Cell: 'returnButton' },
          ],
        },
      },
      {
        VStack: {
          style: 'VStackStyle2',
          subviews: [
            { Cell: 'number2Button' },
            { Cell: 'number5Button' },
            { Cell: 'number8Button' },
            { Cell: 'number0Button' },
          ],
        },
      },
      {
        VStack: {
          style: 'VStackStyle2',
          subviews: [
            { Cell: 'number3Button' },
            { Cell: 'number6Button' },
            { Cell: 'number9Button' },
            { Cell: 'spaceButton' },
          ],
        },
      },
      {
        VStack: {
          style: 'VStackStyle1',
          subviews: [
            { Cell: 'backspaceButton' },
            { Cell: 'periodButton' },
            { Cell: 'equalButton' },
            { Cell: 'enterButton' },
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
    VStackStyle1: {
      size: {
        width: '29/183',
      },
    },
    VStackStyle2: {
      size: {
        width: '125/549',
      },
    },
    collection: {
      size: {
        height: '3/4',
      },
      backgroundStyle: 'collectionBackgroundStyle',
      type: 'numericSymbols',
      displaySeparatorLine: false,
      insets: { top: 2, left: 4, bottom: 2, right: 4 },
      useRimeEngine: true,
    },
    collectionBackgroundStyle: {
      buttonStyleType: 'geometry',
      insets: { top: 2, left: 3, bottom: 2, right: 3 },
      normalColor: color[theme]['数字键盘左侧collection背景顏色'],
      cornerRadius: 7,
      normalLowerEdgeColor: color[theme]['数字键盘左侧collection背景下边缘顏色'],
      borderSize: color[theme]['数字键盘左侧collection边框宽度'],
      normalBorderColor: color[theme]['数字键盘左侧collection边框颜色'],
      highlightBorderColor: color[theme]['数字键盘左侧collection边框颜色'],
    },

    // 數字按鈕 1-9, 0
    number1Button: createButton(params={ key: '1' }),
    number2Button: createButton(params={ key: '2' }),
    number3Button: createButton(params={ key: '3' }),
    number4Button: createButton(params={ key: '4' }),
    number5Button: createButton(params={ key: '5' }),
    number6Button: createButton(params={ key: '6' }),
    number7Button: createButton(params={ key: '7' }),
    number8Button: createButton(params={ key: '8' }),
    number9Button: createButton(params={ key: '9' }),
    number0Button: createButton(params={ key: '0' }),

    // 功能按鈕
    returnButton: createButton(
      params={
        key: 'return',
        action: { keyboardType: 'symbolic' },  // 改為到符號表
        isNumber: false,
      }
    ) + {
      foregroundStyle: ['returnButtonForegroundStyle'] + (if swipeStyles.getEffectiveSetting('nineKey', 'showSwipeUpText') then ['returnButtonTopIndicatorStyle'] else []),
      [if swipeStyles.getEffectiveSetting('nineKey', 'enableSwipeUpActions') then 'swipeUpAction']: { character: '(' },  // 上滑輸入左括號
    },
    returnButtonTopIndicatorStyle: {
      buttonStyleType: 'text',
      text: '(',
      fontSize: fontSize['九宮格上划文字大小'],
      normalColor: color[theme]['九宮格上滑提示文字顏色'],
      center: { x: 0.5, y: 0.2 },
    },
    returnButtonForegroundStyle: utils.makeTextStyle({
      text: '#+=',  // 改為顯示 #+=
      normalColor: color[theme]['数字键盘功能键文字颜色'],
      highlightColor: color[theme]['数字键盘功能键文字颜色'],
      fontSize: fontSize['数字键盘功能键字体大小'],  // 使用數字鍵盤專用字號
    }),

    symbolButton: createButton(
      params={
        key: 'symbol',
        action: 'returnLastKeyboard',  // 改為回到qwer鍵盤
        isNumber: false,
        size: { height: '1/4' },
      }
    ) + {
      swipeUpAction: { keyboardType: 'pinyin' },  // 上滑返回拼音鍵盤
    },
    symbolButtonForegroundStyle: utils.makeTextStyle({
      text: '返回',  // 改為顯示 返回
      normalColor: color[theme]['数字键盘功能键文字颜色'],
      highlightColor: color[theme]['数字键盘功能键文字颜色'],
      fontSize: fontSize['数字键盘功能键字体大小'],  // 使用數字鍵盤專用字號
    }),

    spaceButton: createButton(
      params={
        key: 'space',
        action: 'space',
        isNumber: false,
      }
    ) + {
      foregroundStyle: ['spaceButtonForegroundStyle'] + (if swipeStyles.getEffectiveSetting('nineKey', 'showSwipeUpText') then ['spaceButtonTopIndicatorStyle'] else []),
      [if swipeStyles.getEffectiveSetting('nineKey', 'enableSwipeUpActions') then 'swipeUpAction']: { character: ')' },  // 上滑輸入右括號，使用 character 類型
    },
    spaceButtonTopIndicatorStyle: {
      buttonStyleType: 'text',
      text: ')',
      fontSize: fontSize['九宮格上划文字大小'],
      normalColor: color[theme]['九宮格上滑提示文字顏色'],
      center: { x: 0.5, y: 0.2 },
    },
    spaceButtonForegroundStyle: utils.makeTextStyle({
      text: '空格',
      normalColor: color[theme]['数字键盘功能键文字颜色'],
      highlightColor: color[theme]['数字键盘功能键文字颜色'],
      fontSize: fontSize['数字键盘功能键字体大小'],  // 使用數字鍵盤專用字號
    }),

    backspaceButton: createButton(
      params={
        key: 'backspace',
        action: 'backspace',
        repeatAction: 'backspace',
        isNumber: false,
      }
    ) + {
      foregroundStyle: ['backspaceButtonForegroundStyle', 'backspaceButtonDownForegroundStyle'],
      swipeUpAction: { shortcut: '#deleteText' },
      swipeDownAction: { shortcut: '#undo' },
    },
    backspaceButtonForegroundStyle: utils.makeSystemImageStyle({
      systemImageName: 'delete.left',
      normalColor: color[theme]['数字键盘功能键文字颜色'],
      highlightColor: color[theme]['数字键盘功能键文字颜色'],
      fontSize: fontSize['数字键盘功能键字体大小'],  // 使用數字鍵盤專用字號
      center: { y: 0.45 },
    }),
    backspaceButtonDownForegroundStyle: {
      buttonStyleType: 'text',
      text: 'undo',
      fontSize: fontSize['下划文字大小'],
      normalColor: color[theme]['数字键盘功能键文字颜色'],
      center: { x: 0.5, y: 0.72 },
    },

    periodButton: createButton(
      params={
        key: 'period',
        action: { symbol: '.' },
        isNumber: false,
      }
    ) + {
      foregroundStyle: ['periodButtonForegroundStyle'] + (if swipeStyles.getEffectiveSetting('nineKey', 'showSwipeUpText') then ['periodButtonTopIndicatorStyle'] else []),
      [if swipeStyles.getEffectiveSetting('nineKey', 'enableSwipeUpActions') then 'swipeUpAction']: { symbol: ',' },
      notification: ['periodButtonPreeditNotification'],
    },
    periodButtonPreeditNotification: {
      notificationType: 'preeditChanged',
      backgroundStyle: 'systemButtonBackgroundStyle',
      foregroundStyle: ['periodButtonForegroundStyle'] + (if swipeStyles.getEffectiveSetting('nineKey', 'showSwipeUpText') then ['periodButtonTopIndicatorStyle'] else []),
      action: { character: '.' },
      [if swipeStyles.getEffectiveSetting('nineKey', 'enableSwipeUpActions') then 'swipeUpAction']: { character: ',' },
    },
    periodButtonTopIndicatorStyle: {
      buttonStyleType: 'text',
      text: ',',
      fontSize: fontSize['九宮格上划文字大小'],
      normalColor: color[theme]['九宮格上滑提示文字顏色'],
      center: { x: 0.5, y: 0.2 },
    },
    periodButtonForegroundStyle: utils.makeTextStyle({
      text: '.',
      normalColor: color[theme]['数字键盘功能键文字颜色'],
      highlightColor: color[theme]['数字键盘功能键文字颜色'],
      fontSize: fontSize['数字键盘数字前景字体大小'],
    }),

    equalButton: createButton(
      params={
        key: 'equal',
        action: { character: '=' },
        isNumber: false,
      }
    ) + {
      foregroundStyle: ['equalButtonForegroundStyle'] + (if swipeStyles.getEffectiveSetting('nineKey', 'showSwipeUpText') then ['equalButtonTopIndicatorStyle'] else []),
      [if swipeStyles.getEffectiveSetting('nineKey', 'enableSwipeUpActions') then 'swipeUpAction']: { sendKeys: 'Control+equal' },  // 上滑輸入 ,,= 觸發計算機
    },
    equalButtonTopIndicatorStyle: {
      buttonStyleType: 'text',
      text: '計算',
      fontSize: fontSize['九宮格上划文字大小'],
      normalColor: color[theme]['九宮格上滑提示文字顏色'],
      center: { x: 0.5, y: 0.2 },
    },
    equalButtonForegroundStyle: utils.makeTextStyle({
      text: '=',
      normalColor: color[theme]['数字键盘功能键文字颜色'],
      highlightColor: color[theme]['数字键盘功能键文字颜色'],
      fontSize: fontSize['collection前景字体大小'],
      fontWeight: 0,
    }),

    enterButton: createButton(
      params={
        key: 'enter',
        action: 'enter',
        isNumber: false,
      }
    ) + {
      notification: ['returnKeyTypeChangedNotification'],
      swipeDownAction: { shortcut: '#换行' },  // 下滑換行
    },
    enterButtonForegroundStyle: utils.makeTextStyle({
      text: '$returnKeyType',
      normalColor: color[theme]['数字键盘enter键文字颜色'],
      highlightColor: color[theme]['数字键盘enter键文字颜色'],
      fontSize: fontSize['数字键盘enter键字体大小'],
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
      normalColor: color[theme]['数字键盘enter键文字颜色'],
      highlightColor: color[theme]['数字键盘enter键文字颜色'],
      fontSize: fontSize['数字键盘enter键字体大小'],
    }),

    // 背景樣式
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

    systemButtonBackgroundStyle: utils.makeGeometryStyle({
      insets: { top: 2, left: 2, bottom: 2, right: 2 },
      normalColor: color[theme]['数字键盘功能键背景颜色-普通'],
      highlightColor: color[theme]['数字键盘功能键背景颜色-高亮'],
      cornerRadius: 7,
      normalLowerEdgeColor: color[theme]['数字键盘功能键底边缘颜色-普通'],
      highlightLowerEdgeColor: color[theme]['数字键盘功能键底边缘颜色-高亮'],
      borderSize: color[theme]['数字键盘功能键边框宽度'],
      normalBorderColor: color[theme]['数字键盘功能键边框颜色-普通'],
      highlightBorderColor: color[theme]['数字键盘功能键边框颜色-高亮'],
    }),

    enterButtonBackgroundStyle: utils.makeGeometryStyle({
      insets: { top: 2, left: 2, bottom: 2, right: 2 },
      normalColor: color[theme]['数字键盘enter键背景颜色-普通'],
      highlightColor: color[theme]['数字键盘enter键背景颜色-高亮'],
      cornerRadius: 7,
      normalLowerEdgeColor: color[theme]['数字键盘enter键底边缘颜色-普通'],
      highlightLowerEdgeColor: color[theme]['数字键盘enter键底边缘颜色-高亮'],
      borderSize: color[theme]['数字键盘enter键边框宽度'],
      normalBorderColor: color[theme]['数字键盘enter键边框颜色-普通'],
      highlightBorderColor: color[theme]['数字键盘enter键边框颜色-高亮'],
    }),

    ButtonScaleAnimation: animation['26键按键动画'],
  };

{
  new(theme, skinName='蝦米輸入法'):
    keyboard(theme) +
    toolbar.getToolBar(theme, 'portrait', 'numeric', skinName) +  // 工具栏（傳入 keyboardType 和 skinName）
    utils.genNumberStyles(theme),
}