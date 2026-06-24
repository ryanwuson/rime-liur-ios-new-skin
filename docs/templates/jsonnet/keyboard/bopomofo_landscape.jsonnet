// 注音鍵盤（bopomofo）- 蝦米專用，橫屏
// 所有注音字母鍵及 backspace 統一寬度 1/11，確保每鍵大小一致
// 鍵盤高度維持 160px，工具列 30px
local animation = import '../lib/animation.libsonnet';
local color = import '../lib/color.libsonnet';
local fontSize = import '../lib/fontSize.libsonnet';
local others = import '../lib/others.libsonnet';
local settings = import '../Settings.libsonnet';
local toolbar = import '../lib/toolbar.libsonnet';
local utils = import '../lib/utils.libsonnet';

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

local bpmfKeySize = { width: '1/6' };
// 第2排左欄：0.25 spacer + 5鍵 + 0.75 spacer
// 第3排左欄：0.5 spacer + 5鍵 + 0.5 spacer
// 右欄對稱
// backspace 鍵
local bpmfBackspaceSize = null;
// 功能列按鍵（給予固定寬度，讓空白鍵佔據剩餘空間）
local bpmfFuncSize = { width: '1.2/6' };

// 透明佔位鍵
local spacerBpmfButton = {
  backgroundStyle: 'spacerBpmfBackgroundStyle',
};

local createBpmfButton(theme, key, size=bpmfKeySize, bounds=null) = std.prune({
  size: size,
  bounds: bounds,
  backgroundStyle: 'alphabeticBackgroundStyle',
  foregroundStyle: key + 'BpmfButtonForegroundStyle',
  hintStyle: key + 'BpmfButtonHintStyle',
  action: { character: key },
  animation: ['ButtonScaleAnimation'],
});

local createBpmfForegroundStyle(theme, key) = {
  [key + 'BpmfButtonForegroundStyle']: utils.makeTextStyle({
    text: bpmfMap[key],
    normalColor: color[theme]['注音符號键文字颜色'],
    highlightColor: color[theme]['注音符號键文字颜色'],
    fontSize: fontSize['按键前景文字大小'],
  }),
};

local createBpmfHintStyle(theme, key) = {
  [key + 'BpmfButtonHintStyle']: {
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

local keyboard(theme) =
  { '1BpmfButton': createBpmfButton(theme, '1') }
  + { '2BpmfButton': createBpmfButton(theme, '2') }
  + { '3BpmfButton': createBpmfButton(theme, '3') }
  + { '4BpmfButton': createBpmfButton(theme, '4') }
  + { '5BpmfButton': createBpmfButton(theme, '5') }
  + { '6BpmfButton': createBpmfButton(theme, '6') }
  + { '7BpmfButton': createBpmfButton(theme, '7') }
  + { '8BpmfButton': createBpmfButton(theme, '8') }
  + { '9BpmfButton': createBpmfButton(theme, '9') }
  + { '0BpmfButton': createBpmfButton(theme, '0') }
  + { 'dashBpmfButton': createBpmfButton(theme, '-') }
  + { qBpmfButton: createBpmfButton(theme, 'q') }
  + { wBpmfButton: createBpmfButton(theme, 'w') }
  + { eBpmfButton: createBpmfButton(theme, 'e') }
  + { rBpmfButton: createBpmfButton(theme, 'r') }
  + { tBpmfButton: createBpmfButton(theme, 't') }
  + { yBpmfButton: createBpmfButton(theme, 'y') }
  + { uBpmfButton: createBpmfButton(theme, 'u') }
  + { iBpmfButton: createBpmfButton(theme, 'i') }
  + { oBpmfButton: createBpmfButton(theme, 'o') }
  + { pBpmfButton: createBpmfButton(theme, 'p') }
  + { aBpmfButton: createBpmfButton(theme, 'a') }
  + { sBpmfButton: createBpmfButton(theme, 's') }
  + { dBpmfButton: createBpmfButton(theme, 'd') }
  + { fBpmfButton: createBpmfButton(theme, 'f') }
  + { gBpmfButton: createBpmfButton(theme, 'g') }
  + { hBpmfButton: createBpmfButton(theme, 'h') }
  + { jBpmfButton: createBpmfButton(theme, 'j') }
  + { kBpmfButton: createBpmfButton(theme, 'k') }
  + { lBpmfButton: createBpmfButton(theme, 'l') }
  + { semicolonBpmfButton: createBpmfButton(theme, ';') }
  + { zBpmfButton: createBpmfButton(theme, 'z') }
  + { xBpmfButton: createBpmfButton(theme, 'x') }
  + { cBpmfButton: createBpmfButton(theme, 'c') }
  + { vBpmfButton: createBpmfButton(theme, 'v') }
  + { bBpmfButton: createBpmfButton(theme, 'b') }
  + { nBpmfButton: createBpmfButton(theme, 'n') }
  + { mBpmfButton: createBpmfButton(theme, 'm') }
  + { commaBpmfButton: createBpmfButton(theme, ',') }
  + { periodBpmfButton: createBpmfButton(theme, '.') }
  + { slashBpmfButton: createBpmfButton(theme, '/') }
  + {
    backspaceBpmfButton: {
      size: bpmfBackspaceSize,
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
    numericBpmfButton: {
      size: bpmfFuncSize,
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
    chineseCommaBpmfButton: {
      size: bpmfFuncSize,
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
      size: { width: { percentage: if settings.spaceKeyLayout == '1' then 0.40 else 0.48 } },
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
    switchBpmfButton: {
      size: bpmfFuncSize,
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
      size: bpmfFuncSize,
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
  + {
    alphabeticHintBackgroundStyle: {
      buttonStyleType: 'fileImage',
      contentMode: 'scaleAspectFit',
      insets: { left: -3, right: -3, top: -3, bottom: -3 },
      center: { y: 0.68 },
      normalImage: { file: 'hint', image: 'IMG3' },
      highlightImage: { file: 'hint', image: 'IMG3' },
    },
    // 透明佔位鍵（階梯效果）
    spacerBpmfBackgroundStyle: {
      buttonStyleType: 'geometry',
      normalColor: '#00000000',
      highlightColor: '#00000000',
    },
    spacerQtr: { backgroundStyle: 'spacerBpmfBackgroundStyle', size: { width: '1/24' } },
    spacerHalf: { backgroundStyle: 'spacerBpmfBackgroundStyle', size: { width: '1/12' } },
    spacerRest2: { backgroundStyle: 'spacerBpmfBackgroundStyle', size: { width: '1/8' } },
    
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
      {
        HStack: {
          subviews: [
            // 左半 VStack (2/5)
            {
              VStack: {
                style: 'leftColumnStyle',
                subviews: [
                  // 行1左：ㄅ ㄉ ˇ ˋ ㄓ ˊ（6鍵）
                  { HStack: { subviews: [
                    { Cell: '1BpmfButton' }, { Cell: '2BpmfButton' }, { Cell: '3BpmfButton' },
                    { Cell: '4BpmfButton' }, { Cell: '5BpmfButton' }, { Cell: '6BpmfButton' },
                  ] } },
                  // 行2左：ㄆ ㄊ ㄍ ㄐ ㄔ（0.25偏移）
                  { HStack: { subviews: [
                    { Cell: 'spacerQtr' },
                    { Cell: 'qBpmfButton' }, { Cell: 'wBpmfButton' }, { Cell: 'eBpmfButton' },
                    { Cell: 'rBpmfButton' }, { Cell: 'tBpmfButton' },
                    { Cell: 'spacerRest2' },
                  ] } },
                  // 行3左：ㄇ ㄋ ㄎ ㄑ ㄕ（0.5偏移）
                  { HStack: { subviews: [
                    { Cell: 'spacerHalf' },
                    { Cell: 'aBpmfButton' }, { Cell: 'sBpmfButton' }, { Cell: 'dBpmfButton' },
                    { Cell: 'fBpmfButton' }, { Cell: 'gBpmfButton' },
                    { Cell: 'spacerHalf' },
                  ] } },
                  // 行4左：ㄈ ㄌ ㄏ ㄒ ㄖ ㄙ（6鍵）
                  { HStack: { subviews: [
                    { Cell: 'zBpmfButton' }, { Cell: 'xBpmfButton' }, { Cell: 'cBpmfButton' },
                    { Cell: 'vBpmfButton' }, { Cell: 'bBpmfButton' }, { Cell: 'nBpmfButton' },
                  ] } },
                  // 行5左：返回 直出 空白(左)
                  { HStack: { subviews: [
                    { Cell: 'numericBpmfButton' },
                    { Cell: 'chineseCommaBpmfButton' },
                    { Cell: 'spaceBpmfButtonLeft' },
                  ] } },
                ],
              },
            },
            // 中間空白
            {
              VStack: {
                style: 'centerColumnStyle',
              },
            },
            // 右半 VStack (2/5)
            {
              VStack: {
                style: 'rightColumnStyle',
                subviews: [
                  // 行1右：ˊ ˙ ㄚ ㄞ ㄢ ㄦ（6鍵）
                  { HStack: { subviews: [
                    { Cell: '6BpmfButton' }, { Cell: '7BpmfButton' }, { Cell: '8BpmfButton' },
                    { Cell: '9BpmfButton' }, { Cell: '0BpmfButton' }, { Cell: 'dashBpmfButton' },
                  ] } },
                  // 行2右：ㄗ ㄧ ㄛ ㄟ ㄣ（0.25偏移）
                  { HStack: { subviews: [
                    { Cell: 'spacerRest2' },
                    { Cell: 'yBpmfButton' }, { Cell: 'uBpmfButton' }, { Cell: 'iBpmfButton' },
                    { Cell: 'oBpmfButton' }, { Cell: 'pBpmfButton' },
                    { Cell: 'spacerQtr' },
                  ] } },
                  // 行3右：ㄘ ㄨ ㄜ ㄠ ㄤ（0.5偏移）
                  { HStack: { subviews: [
                    { Cell: 'spacerHalf' },
                    { Cell: 'hBpmfButton' }, { Cell: 'jBpmfButton' }, { Cell: 'kBpmfButton' },
                    { Cell: 'lBpmfButton' }, { Cell: 'semicolonBpmfButton' },
                    { Cell: 'spacerHalf' },
                  ] } },
                  // 行4右：ㄙ ㄩ ㄝ ㄡ ㄥ delete（6鍵）
                  { HStack: { subviews: [
                    { Cell: 'nBpmfButton' }, { Cell: 'mBpmfButton' }, { Cell: 'commaBpmfButton' },
                    { Cell: 'periodBpmfButton' }, { Cell: 'slashBpmfButton' }, { Cell: 'backspaceBpmfButton' },
                  ] } },
                  // 行5右：空白(右) 輸入 enter
                  { HStack: { subviews: [
                    { Cell: 'spaceBpmfButtonRight' },
                    { Cell: 'switchBpmfButton' },
                    { Cell: 'enterBpmfButton' },
                  ] } },
                ],
              },
            },
          ],
        },
      },
    ],

    leftColumnStyle: { size: { width: '2/5' } },
    centerColumnStyle: { size: { width: '1/5' } },
    rightColumnStyle: { size: { width: '2/5' } },

    // 空白鍵分為左右兩半（各自填滿功能列剩餘空間）
    spaceBpmfButtonLeft: {
      backgroundStyle: 'alphabeticBackgroundStyle',
      foregroundStyle: 'spaceBpmfButtonForegroundStyle',
      action: 'space',
      swipeUpAction: { sendKeys: "''" },
      animation: ['ButtonScaleAnimation'],
    },
    spaceBpmfButtonRight: {
      backgroundStyle: 'alphabeticBackgroundStyle',
      foregroundStyle: 'spaceBpmfButtonForegroundStyle',
      action: 'space',
      swipeUpAction: { sendKeys: "''" },
      animation: ['ButtonScaleAnimation'],
    },
  };

{
  new(theme, skinName='蝦米輸入法'):
    toolbar.getToolBar(theme, 'landscape', 'bopomofo', skinName) +
    {
      preeditHeight: others['横屏']['preedit高度'],
      toolbarHeight: others['横屏']['toolbar高度'],
      keyboardHeight: others['横屏']['keyboard高度'],
    } +
    keyboard(theme),
}
