// 注音鍵盤（bopomofo）- 蝦米專用，竖屏
// 按鍵尺寸完全照抄空山素影 iPhoneBopomofo 的參數
// 背景 insets 使用空山素影竖屏值：top:3, left:2, bottom:3, right:2
local animation = import '../lib/animation.libsonnet';
local color = import '../lib/color.libsonnet';
local fontSize = import '../lib/fontSize.libsonnet';
local others = import '../lib/others.libsonnet';
local settings = import '../Settings.libsonnet';
local toolbar = import '../lib/toolbar.libsonnet';
local utils = import '../lib/utils.libsonnet';

// 注音按鍵對應表（鍵名 → 注音符號）
local bpmfMap = {
  '1': 'ㄅ', '2': 'ㄉ', '3': 'ˇ', '4': 'ˋ', '5': 'ㄓ',
  '6': 'ˊ',  '7': '˙',  '8': 'ㄚ', '9': 'ㄞ', '0': 'ㄢ', '-': 'ㄦ',
  'q': 'ㄆ', 'w': 'ㄊ', 'e': 'ㄍ', 'r': 'ㄐ', 't': 'ㄔ',
  'y': 'ㄗ', 'u': 'ㄧ', 'i': 'ㄛ', 'o': 'ㄟ', 'p': 'ㄣ',
  'a': 'ㄇ', 's': 'ㄋ', 'd': 'ㄎ', 'f': 'ㄑ', 'g': 'ㄕ',
  'h': 'ㄘ', 'j': 'ㄨ', 'k': 'ㄜ', 'l': 'ㄠ', ';': 'ㄤ',
  'z': 'ㄈ', 'x': 'ㄌ', 'c': 'ㄏ', 'v': 'ㄒ', 'b': 'ㄖ',
  'n': 'ㄙ', 'm': 'ㄩ', ',': 'ㄝ', '.': 'ㄡ', '/': 'ㄥ',
};

// ===== 完全照抄空山素影的按鍵尺寸 =====
// 普通鍵：3/33
local normalSize = { width: '3/33' };
// 邊緣鍵（空山素影的 getAlphabeticButtonSize）
local qSize   = { size: { width: '4/33' }, bounds: { width: '3/4', alignment: 'right' } };
local pSize   = { size: { width: '5/33' }, bounds: { width: '3/5', alignment: 'left' } };
local aSize   = { size: { width: '5/33' }, bounds: { width: '3/5', alignment: 'right' } };
local semiSize = { size: { width: '4/33' }, bounds: { width: '3/4', alignment: 'left' } };

// 建立注音字母按鍵
local createBpmfButton(theme, key, size, bounds=null) =
  std.prune({
    size: size,
    bounds: bounds,
    backgroundStyle: 'alphabeticBackgroundStyle',
    foregroundStyle: key + 'BpmfButtonForegroundStyle',
    hintStyle: key + 'BpmfButtonHintStyle',
    action: { character: key },
    animation: ['ButtonScaleAnimation'],
  });

// 建立注音按鍵氣泡樣式（嚴格對齊拼音26鍵的 genHintStyles）
local createBpmfHintStyle(theme, key) = {
  [key + 'BpmfButtonHintStyle']: utils.hintBubbleLayout + {
    backgroundStyle: 'alphabeticHintBackgroundStyle',
    foregroundStyle: key + 'BpmfButtonHintForegroundStyle',
  },
  [key + 'BpmfButtonHintForegroundStyle']: utils.makeTextStyle({
    center: { x: 0.5, y: 0.63 },
    text: bpmfMap[key],
    fontSize: fontSize['划动气泡前景文字大小'],
    normalColor: color[theme]['注音按下气泡文字颜色'],
  }),
};

// 建立注音字母按鍵前景樣式
local createBpmfForegroundStyle(theme, key) = {
  [key + 'BpmfButtonForegroundStyle']: utils.makeTextStyle({
    text: bpmfMap[key],
    normalColor: color[theme]['注音符號键文字颜色'],
    highlightColor: color[theme]['注音符號键文字颜色'],
    fontSize: fontSize['按键前景文字大小'],
  }),
};

local keyboard(theme) =
  // 第一排（11 鍵，全部普通鍵尺寸）
  { '1BpmfButton': createBpmfButton(theme, '1', normalSize) }
  + { '2BpmfButton': createBpmfButton(theme, '2', normalSize) }
  + { '3BpmfButton': createBpmfButton(theme, '3', normalSize) }
  + { '4BpmfButton': createBpmfButton(theme, '4', normalSize) }
  + { '5BpmfButton': createBpmfButton(theme, '5', normalSize) }
  + { '6BpmfButton': createBpmfButton(theme, '6', normalSize) }
  + { '7BpmfButton': createBpmfButton(theme, '7', normalSize) }
  + { '8BpmfButton': createBpmfButton(theme, '8', normalSize) }
  + { '9BpmfButton': createBpmfButton(theme, '9', normalSize) }
  + { '0BpmfButton': createBpmfButton(theme, '0', normalSize) }
  + { 'dashBpmfButton': createBpmfButton(theme, '-', normalSize) }
  // 第二排（10 鍵，q 和 p 用邊緣尺寸）
  + { qBpmfButton: createBpmfButton(theme, 'q', qSize.size, qSize.bounds) }
  + { wBpmfButton: createBpmfButton(theme, 'w', normalSize) }
  + { eBpmfButton: createBpmfButton(theme, 'e', normalSize) }
  + { rBpmfButton: createBpmfButton(theme, 'r', normalSize) }
  + { tBpmfButton: createBpmfButton(theme, 't', normalSize) }
  + { yBpmfButton: createBpmfButton(theme, 'y', normalSize) }
  + { uBpmfButton: createBpmfButton(theme, 'u', normalSize) }
  + { iBpmfButton: createBpmfButton(theme, 'i', normalSize) }
  + { oBpmfButton: createBpmfButton(theme, 'o', normalSize) }
  + { pBpmfButton: createBpmfButton(theme, 'p', pSize.size, pSize.bounds) }
  // 第三排（10 鍵，a 和 ; 用邊緣尺寸）
  + { aBpmfButton: createBpmfButton(theme, 'a', aSize.size, aSize.bounds) }
  + { sBpmfButton: createBpmfButton(theme, 's', normalSize) }
  + { dBpmfButton: createBpmfButton(theme, 'd', normalSize) }
  + { fBpmfButton: createBpmfButton(theme, 'f', normalSize) }
  + { gBpmfButton: createBpmfButton(theme, 'g', normalSize) }
  + { hBpmfButton: createBpmfButton(theme, 'h', normalSize) }
  + { jBpmfButton: createBpmfButton(theme, 'j', normalSize) }
  + { kBpmfButton: createBpmfButton(theme, 'k', normalSize) }
  + { lBpmfButton: createBpmfButton(theme, 'l', normalSize) }
  + { semicolonBpmfButton: createBpmfButton(theme, ';', semiSize.size, semiSize.bounds) }
  // 第四排（10 鍵 + backspace，全部普通鍵尺寸）
  + { zBpmfButton: createBpmfButton(theme, 'z', normalSize) }
  + { xBpmfButton: createBpmfButton(theme, 'x', normalSize) }
  + { cBpmfButton: createBpmfButton(theme, 'c', normalSize) }
  + { vBpmfButton: createBpmfButton(theme, 'v', normalSize) }
  + { bBpmfButton: createBpmfButton(theme, 'b', normalSize) }
  + { nBpmfButton: createBpmfButton(theme, 'n', normalSize) }
  + { mBpmfButton: createBpmfButton(theme, 'm', normalSize) }
  + { commaBpmfButton: createBpmfButton(theme, ',', normalSize) }
  + { periodBpmfButton: createBpmfButton(theme, '.', normalSize) }
  + { slashBpmfButton: createBpmfButton(theme, '/', normalSize) }
  + {
    // Backspace（普通鍵同寬）
    backspaceBpmfButton: {
      size: normalSize,
      backgroundStyle: 'systemButtonBackgroundStyle',
      foregroundStyle: ['backspaceBpmfButtonForegroundStyle', 'backspaceBpmfButtonDownForegroundStyle'],
      action: 'backspace',
      repeatAction: 'backspace',
      swipeUpAction: { shortcut: '#deleteText' },
      swipeDownAction: { shortcut: '#undo' },
      animation: ['ButtonScaleAnimation'],
    },
    backspaceBpmfButtonForegroundStyle: utils.makeSystemImageStyle({
      systemImageName: 'delete.left',
      normalColor: color[theme]['注音功能键文字颜色'],
      highlightColor: color[theme]['注音功能键文字颜色'],
      fontSize: fontSize['注音enter键字体大小'],
    }),
    backspaceBpmfButtonDownForegroundStyle: {
      buttonStyleType: 'text',
      text: 'undo',
      fontSize: fontSize['下划文字大小'],
      normalColor: color[theme]['注音功能键文字颜色'],
      center: { x: 0.5, y: 0.8 },
    },
    // 第五排：功能列，尺寸完全對齊蝦米 26 鍵第四排，並支援 spaceKeyLayout 設定
    // 返回拼音26鍵
    numericBpmfButton: {
      size: { width: { percentage: if settings.spaceKeyLayout == '3' then 0.1342 else 0.16 } },
      backgroundStyle: 'systemButtonBackgroundStyle',
      foregroundStyle: 'numericBpmfButtonForegroundStyle',
      action: 'returnLastKeyboard',
      swipeUpAction: { keyboardType: 'pinyin' },
      animation: ['ButtonScaleAnimation'],
    },
    numericBpmfButtonForegroundStyle: utils.makeTextStyle({
      text: '返回',
      normalColor: color[theme]['注音功能键文字颜色'],
      highlightColor: color[theme]['注音功能键文字颜色'],
      fontSize: fontSize['注音enter键字体大小'],
    }),
    // 直出（sendKeys ';'），使用 system 鍵色
    chineseCommaBpmfButton: {
      size: { width: { percentage: if settings.spaceKeyLayout == '1' then 0.14 else 0.10 } },
      backgroundStyle: 'systemButtonBackgroundStyle',
      foregroundStyle: 'chineseCommaBpmfButtonForegroundStyle',
      action: { sendKeys: "';'" },
      swipeUpAction: { sendKeys: "''" },  // 上滑輸出 ''
      animation: ['ButtonScaleAnimation'],
    },
    chineseCommaBpmfButtonForegroundStyle: utils.makeTextStyle({
      text: '直出',
      normalColor: color[theme]['注音功能键文字颜色'],
      highlightColor: color[theme]['注音功能键文字颜色'],
      fontSize: fontSize['注音enter键字体大小'],
    }),
    spaceBpmfButton: {
      size: if settings.spaceKeyLayout == '3' then
        { width: { percentage: 0.5316 } }
      else
        { width: { percentage: if settings.spaceKeyLayout == '1' then 0.40 else 0.48 } },
      backgroundStyle: 'alphabeticBackgroundStyle',
      foregroundStyle: 'spaceBpmfButtonForegroundStyle',
      action: 'space',
      animation: ['ButtonScaleAnimation'],
    },
    spaceBpmfButtonForegroundStyle: utils.makeTextStyle({
      text: '注音',
      normalColor: color[theme]['注音空白键文字颜色'],
      highlightColor: color[theme]['注音空白键文字颜色'],
      fontSize: fontSize['英文空白键文字大小'],
    }),
    // 輸入（sendKeys ';'），使用 system 鍵色
    switchBpmfButton: {
      size: { width: { percentage: if settings.spaceKeyLayout == '1' then 0.14 else 0.10 } },
      backgroundStyle: 'systemButtonBackgroundStyle',
      foregroundStyle: 'switchBpmfButtonForegroundStyle',
      action: { sendKeys: "';" },
      animation: ['ButtonScaleAnimation'],
    },
    switchBpmfButtonForegroundStyle: utils.makeTextStyle({
      text: '輸入',
      normalColor: color[theme]['注音功能键文字颜色'],
      highlightColor: color[theme]['注音功能键文字颜色'],
      fontSize: fontSize['注音enter键字体大小'],
    }),
    enterBpmfButton: {
      size: { width: { percentage: if settings.spaceKeyLayout == '3' then 0.1342 else 0.16 } },
      backgroundStyle: 'enterButtonBackgroundStyle',
      foregroundStyle: 'enterBpmfButtonForegroundStyle',
      action: 'enter',
      notification: ['returnKeyTypeChangedForBpmfNotification'],
      animation: ['ButtonScaleAnimation'],
    },
    enterBpmfButtonForegroundStyle: utils.makeTextStyle({
      text: '$returnKeyType',
      normalColor: color[theme]['注音enter键文字颜色'],
      highlightColor: color[theme]['注音enter键文字颜色'],
      fontSize: fontSize['注音enter键字体大小'],
    }),
    returnKeyTypeChangedForBpmfNotification: {
      notificationType: 'returnKeyType',
      returnKeyType: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
      backgroundStyle: 'enterButtonBackgroundStyle',
      foregroundStyle: 'enterBpmfReturnKeyTypeForegroundStyle',
    },
    enterBpmfReturnKeyTypeForegroundStyle: utils.makeTextStyle({
      text: '$returnKeyType',
      normalColor: color[theme]['注音enter键文字颜色'],
      highlightColor: color[theme]['注音enter键文字颜色'],
      fontSize: fontSize['注音enter键字体大小'],
    }),
  }
  // 所有注音按鍵前景樣式
  + createBpmfForegroundStyle(theme, '1') + createBpmfForegroundStyle(theme, '2')
  + createBpmfForegroundStyle(theme, '3') + createBpmfForegroundStyle(theme, '4')
  + createBpmfForegroundStyle(theme, '5') + createBpmfForegroundStyle(theme, '6')
  + createBpmfForegroundStyle(theme, '7') + createBpmfForegroundStyle(theme, '8')
  + createBpmfForegroundStyle(theme, '9') + createBpmfForegroundStyle(theme, '0')
  + createBpmfForegroundStyle(theme, '-')
  + createBpmfForegroundStyle(theme, 'q') + createBpmfForegroundStyle(theme, 'w')
  + createBpmfForegroundStyle(theme, 'e') + createBpmfForegroundStyle(theme, 'r')
  + createBpmfForegroundStyle(theme, 't') + createBpmfForegroundStyle(theme, 'y')
  + createBpmfForegroundStyle(theme, 'u') + createBpmfForegroundStyle(theme, 'i')
  + createBpmfForegroundStyle(theme, 'o') + createBpmfForegroundStyle(theme, 'p')
  + createBpmfForegroundStyle(theme, 'a') + createBpmfForegroundStyle(theme, 's')
  + createBpmfForegroundStyle(theme, 'd') + createBpmfForegroundStyle(theme, 'f')
  + createBpmfForegroundStyle(theme, 'g') + createBpmfForegroundStyle(theme, 'h')
  + createBpmfForegroundStyle(theme, 'j') + createBpmfForegroundStyle(theme, 'k')
  + createBpmfForegroundStyle(theme, 'l') + createBpmfForegroundStyle(theme, ';')
  + createBpmfForegroundStyle(theme, 'z') + createBpmfForegroundStyle(theme, 'x')
  + createBpmfForegroundStyle(theme, 'c') + createBpmfForegroundStyle(theme, 'v')
  + createBpmfForegroundStyle(theme, 'b') + createBpmfForegroundStyle(theme, 'n')
  + createBpmfForegroundStyle(theme, 'm') + createBpmfForegroundStyle(theme, ',')
  + createBpmfForegroundStyle(theme, '.') + createBpmfForegroundStyle(theme, '/')
  // 所有注音按鍵氣泡樣式
  + createBpmfHintStyle(theme, '1') + createBpmfHintStyle(theme, '2')
  + createBpmfHintStyle(theme, '3') + createBpmfHintStyle(theme, '4')
  + createBpmfHintStyle(theme, '5') + createBpmfHintStyle(theme, '6')
  + createBpmfHintStyle(theme, '7') + createBpmfHintStyle(theme, '8')
  + createBpmfHintStyle(theme, '9') + createBpmfHintStyle(theme, '0')
  + createBpmfHintStyle(theme, '-')
  + createBpmfHintStyle(theme, 'q') + createBpmfHintStyle(theme, 'w')
  + createBpmfHintStyle(theme, 'e') + createBpmfHintStyle(theme, 'r')
  + createBpmfHintStyle(theme, 't') + createBpmfHintStyle(theme, 'y')
  + createBpmfHintStyle(theme, 'u') + createBpmfHintStyle(theme, 'i')
  + createBpmfHintStyle(theme, 'o') + createBpmfHintStyle(theme, 'p')
  + createBpmfHintStyle(theme, 'a') + createBpmfHintStyle(theme, 's')
  + createBpmfHintStyle(theme, 'd') + createBpmfHintStyle(theme, 'f')
  + createBpmfHintStyle(theme, 'g') + createBpmfHintStyle(theme, 'h')
  + createBpmfHintStyle(theme, 'j') + createBpmfHintStyle(theme, 'k')
  + createBpmfHintStyle(theme, 'l') + createBpmfHintStyle(theme, ';')
  + createBpmfHintStyle(theme, 'z') + createBpmfHintStyle(theme, 'x')
  + createBpmfHintStyle(theme, 'c') + createBpmfHintStyle(theme, 'v')
  + createBpmfHintStyle(theme, 'b') + createBpmfHintStyle(theme, 'n')
  + createBpmfHintStyle(theme, 'm') + createBpmfHintStyle(theme, ',')
  + createBpmfHintStyle(theme, '.') + createBpmfHintStyle(theme, '/')
  // 背景樣式：insets 對齊蝦米 26 鍵 top:2, left:2, bottom:2, right:2
  + {
    alphabeticHintBackgroundStyle: {
      buttonStyleType: 'fileImage',
      contentMode: 'scaleAspectFit',
      insets: { left: -3, right: -3, top: -3, bottom: -3 },
      center: { y: 0.68 },
      normalImage: { file: 'hint', image: 'IMG3' },
      highlightImage: { file: 'hint', image: 'IMG3' },
    },
    
    // 空白鍵專屬背景樣式
    spaceButtonBackgroundStyle: utils.makeGeometryStyle({
      insets: { top: 2, left: 2, bottom: 2, right: 2 },
      normalColor: color[theme]['空白键背景颜色-普通'],
      highlightColor: color[theme]['空白键背景颜色-高亮'],
      cornerRadius: 8.5,
      normalLowerEdgeColor: color[theme]['空白键阴影颜色-普通'],
      highlightLowerEdgeColor: color[theme]['空白键阴影颜色-高亮'],
      borderSize: color[theme]['空白键边框宽度'],
      normalBorderColor: color[theme]['空白键边框颜色'],
      highlightBorderColor: color[theme]['空白键边框颜色'],
    }),
    alphabeticBackgroundStyle: utils.makeGeometryStyle({
      insets: { top: 2, left: 2, bottom: 2, right: 2 },
      normalColor: color[theme]['注音符號键背景颜色-普通'],
      highlightColor: color[theme]['注音符號键背景颜色-高亮'],
      cornerRadius: 8.5,
      normalLowerEdgeColor: color[theme]['注音符號键底边缘颜色-普通'],
      highlightLowerEdgeColor: color[theme]['注音符號键底边缘颜色-高亮'],
      borderSize: color[theme]['注音符號键边框宽度'],
      normalBorderColor: color[theme]['注音符號键边框颜色-普通'],
      highlightBorderColor: color[theme]['注音符號键边框颜色-高亮'],
    }),
    systemButtonBackgroundStyle: utils.makeGeometryStyle({
      insets: { top: 2, left: 2, bottom: 2, right: 2 },
      normalColor: color[theme]['注音功能键背景颜色-普通'],
      highlightColor: color[theme]['注音功能键背景颜色-高亮'],
      cornerRadius: 8.5,
      normalLowerEdgeColor: color[theme]['注音符號键底边缘颜色-普通'],
      highlightLowerEdgeColor: color[theme]['注音符號键底边缘颜色-高亮'],
      borderSize: color[theme]['注音功能键边框宽度'],
      normalBorderColor: color[theme]['注音功能键边框颜色-普通'],
      highlightBorderColor: color[theme]['注音功能键边框颜色-高亮'],
    }),
    enterButtonBackgroundStyle: utils.makeGeometryStyle({
      insets: { top: 2, left: 2, bottom: 2, right: 2 },
      normalColor: color[theme]['注音enter键背景颜色-普通'],
      highlightColor: color[theme]['注音enter键背景颜色-高亮'],
      cornerRadius: 8.5,
      normalLowerEdgeColor: color[theme]['注音符號键底边缘颜色-普通'],
      highlightLowerEdgeColor: color[theme]['注音符號键底边缘颜色-高亮'],
      borderSize: color[theme]['注音enter键边框宽度'],
      normalBorderColor: color[theme]['注音enter键边框颜色-普通'],
      highlightBorderColor: color[theme]['注音enter键边框颜色-高亮'],
    }),
    keyboardBackgroundStyle: {
      buttonStyleType: 'geometry',
      normalColor: color[theme]['注音键盘背景颜色'],
    },
    keyboardStyle: {
      backgroundStyle: 'keyboardBackgroundStyle',
    },
    ButtonScaleAnimation: animation['26键按键动画'],
    keyboardLayout: [
      // 第一排：11 鍵
      {
        HStack: {
          subviews: [
            { Cell: '1BpmfButton' }, { Cell: '2BpmfButton' }, { Cell: '3BpmfButton' },
            { Cell: '4BpmfButton' }, { Cell: '5BpmfButton' }, { Cell: '6BpmfButton' },
            { Cell: '7BpmfButton' }, { Cell: '8BpmfButton' }, { Cell: '9BpmfButton' },
            { Cell: '0BpmfButton' }, { Cell: 'dashBpmfButton' },
          ],
        },
      },
      // 第二排：10 鍵
      {
        HStack: {
          subviews: [
            { Cell: 'qBpmfButton' }, { Cell: 'wBpmfButton' }, { Cell: 'eBpmfButton' },
            { Cell: 'rBpmfButton' }, { Cell: 'tBpmfButton' }, { Cell: 'yBpmfButton' },
            { Cell: 'uBpmfButton' }, { Cell: 'iBpmfButton' }, { Cell: 'oBpmfButton' },
            { Cell: 'pBpmfButton' },
          ],
        },
      },
      // 第三排：10 鍵
      {
        HStack: {
          subviews: [
            { Cell: 'aBpmfButton' }, { Cell: 'sBpmfButton' }, { Cell: 'dBpmfButton' },
            { Cell: 'fBpmfButton' }, { Cell: 'gBpmfButton' }, { Cell: 'hBpmfButton' },
            { Cell: 'jBpmfButton' }, { Cell: 'kBpmfButton' }, { Cell: 'lBpmfButton' },
            { Cell: 'semicolonBpmfButton' },
          ],
        },
      },
      // 第四排：10 鍵 + backspace
      {
        HStack: {
          subviews: [
            { Cell: 'zBpmfButton' }, { Cell: 'xBpmfButton' }, { Cell: 'cBpmfButton' },
            { Cell: 'vBpmfButton' }, { Cell: 'bBpmfButton' }, { Cell: 'nBpmfButton' },
            { Cell: 'mBpmfButton' }, { Cell: 'commaBpmfButton' }, { Cell: 'periodBpmfButton' },
            { Cell: 'slashBpmfButton' }, { Cell: 'backspaceBpmfButton' },
          ],
        },
      },
      // 第五排：功能列
      {
        HStack: {
          subviews: [
            { Cell: 'numericBpmfButton' },
            { Cell: 'chineseCommaBpmfButton' },
            { Cell: 'spaceBpmfButton' },
            { Cell: 'switchBpmfButton' },
            { Cell: 'enterBpmfButton' },
          ],
        },
      },
    ],
  };

{
  new(theme, skinName='蝦米輸入法'):
    toolbar.getToolBar(theme, 'portrait', 'bopomofo', skinName) +
    {
      preeditHeight: others['竖屏']['preedit高度'],
      toolbarHeight: others['竖屏']['toolbar高度'],
      keyboardHeight: others['竖屏']['keyboard高度'],
    } +
    keyboard(theme),
}
