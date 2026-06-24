// 鍵盤佈局定義 - 蝦米專用（第四排：123、逗號、空白、句號、Enter）
local color = import 'color.libsonnet';
local settings = import '../Settings.libsonnet';

local keyboardLayout(theme='light') = {
  // 竖屏中文26键（蝦米佈局）
  '竖屏中文26键': {
    keyboardLayout: [
      {
        HStack: {
          subviews: [
            { Cell: 'qButton' }, { Cell: 'wButton' }, { Cell: 'eButton' }, { Cell: 'rButton' }, { Cell: 'tButton' },
            { Cell: 'yButton' }, { Cell: 'uButton' }, { Cell: 'iButton' }, { Cell: 'oButton' }, { Cell: 'pButton' },
          ],
        },
      },
      {
        HStack: {
          subviews: [
            { Cell: 'aButton' }, { Cell: 'sButton' }, { Cell: 'dButton' }, { Cell: 'fButton' }, { Cell: 'gButton' },
            { Cell: 'hButton' }, { Cell: 'jButton' }, { Cell: 'kButton' }, { Cell: 'lButton' },
          ],
        },
      },
      {
        HStack: {
          subviews: [
            { Cell: 'shiftButton' },
            { Cell: 'zButton' }, { Cell: 'xButton' }, { Cell: 'cButton' }, { Cell: 'vButton' },
            { Cell: 'bButton' }, { Cell: 'nButton' }, { Cell: 'mButton' },
            { Cell: 'backspaceButton' },
          ],
        },
      },
      {
        HStack: {
          subviews: [
            { Cell: 'numericButton' },
            { Cell: 'commaButton' },
            { Cell: 'spaceButton' },
            { Cell: 'periodButton' },
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
      normalColor: color[theme]['键盘背景顏色'],
    },
  },

  // 横屏中文26键（分裂式佈局 - 仿仓默认-元书）
  '横屏中文26键': {
    keyboardLayout: [
      {
        VStack: {
          style: 'columnStyle1',
          subviews: [
            {
              HStack: {
                subviews: [
                  { Cell: 'qButton' }, { Cell: 'wButton' }, { Cell: 'eButton' }, { Cell: 'rButton' }, { Cell: 'tButton' },
                ],
              },
            },
            {
              HStack: {
                subviews: [
                  { Cell: 'aButton' }, { Cell: 'sButton' }, { Cell: 'dButton' }, { Cell: 'fButton' }, { Cell: 'gButton' },
                ],
              },
            },
            {
              HStack: {
                subviews: [
                  { Cell: 'shiftButton' }, { Cell: 'zButton' }, { Cell: 'xButton' }, { Cell: 'cButton' }, { Cell: 'vButton' },
                ],
              },
            },
            {
              HStack: {
                subviews: [
                  { Cell: 'numericButton' }, { Cell: 'commaButton' }, { Cell: 'spaceButton' },
                ],
              },
            },
          ],
        },
      },
      {
        VStack: {
          style: 'columnStyle2',
        },
      },
      {
        VStack: {
          style: 'columnStyle3',
          subviews: [
            {
              HStack: {
                subviews: [
                  { Cell: 'yButton' }, { Cell: 'uButton' }, { Cell: 'iButton' }, { Cell: 'oButton' }, { Cell: 'pButton' },
                ],
              },
            },
            {
              HStack: {
                subviews: [
                  { Cell: 'gButton' }, { Cell: 'hButton' }, { Cell: 'jButton' }, { Cell: 'kButton' }, { Cell: 'lButton' },
                ],
              },
            },
            {
              HStack: {
                subviews: [
                  { Cell: 'vButton' }, { Cell: 'bButton' }, { Cell: 'nButton' }, { Cell: 'mButton' }, { Cell: 'backspaceButton' },
                ],
              },
            },
            {
              HStack: {
                subviews: [
                  { Cell: 'spaceButton' }, { Cell: 'periodButton' }, { Cell: 'enterButton' },
                ],
              },
            },
          ],
        },
      },
    ],
    keyboardStyle: {
      backgroundStyle: 'keyboardBackgroundStyle',
    },
    keyboardBackgroundStyle: {
      buttonStyleType: 'geometry',
      normalColor: color[theme]['键盘背景顏色'],
    },
    columnStyle1: {
      size: {
        width: '2/5',
      },
    },
    columnStyle2: {
      size: {
        width: '1/5',
      },
    },
    columnStyle3: {
      size: {
        width: '2/5',
      },
    },
  },

  // 竖屏英文26键（蝦米佈局）
  '竖屏英文26键': {
    keyboardLayout: [
      {
        HStack: {
          subviews: [
            { Cell: 'qButton' }, { Cell: 'wButton' }, { Cell: 'eButton' }, { Cell: 'rButton' }, { Cell: 'tButton' },
            { Cell: 'yButton' }, { Cell: 'uButton' }, { Cell: 'iButton' }, { Cell: 'oButton' }, { Cell: 'pButton' },
          ],
        },
      },
      {
        HStack: {
          subviews: [
            { Cell: 'aButton' }, { Cell: 'sButton' }, { Cell: 'dButton' }, { Cell: 'fButton' }, { Cell: 'gButton' },
            { Cell: 'hButton' }, { Cell: 'jButton' }, { Cell: 'kButton' }, { Cell: 'lButton' },
          ],
        },
      },
      {
        HStack: {
          subviews: [
            { Cell: 'shiftButton' },
            { Cell: 'zButton' }, { Cell: 'xButton' }, { Cell: 'cButton' }, { Cell: 'vButton' },
            { Cell: 'bButton' }, { Cell: 'nButton' }, { Cell: 'mButton' },
            { Cell: 'backspaceButton' },
          ],
        },
      },
      {
        HStack: {
          subviews: [
            { Cell: 'numericButton' },
            { Cell: 'commaButton' },
            { Cell: 'spaceButton' },
            { Cell: 'periodButton' },
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
      normalColor: color[theme]['键盘背景顏色'],
    },
  },

  // 横屏英文26键（分裂式佈局 - 仿仓默认-元书）
  '横屏英文26键': {
    keyboardLayout: [
      {
        VStack: {
          style: 'columnStyle1',
          subviews: [
            {
              HStack: {
                subviews: [
                  { Cell: 'qButton' }, { Cell: 'wButton' }, { Cell: 'eButton' }, { Cell: 'rButton' }, { Cell: 'tButton' },
                ],
              },
            },
            {
              HStack: {
                subviews: [
                  { Cell: 'aButton' }, { Cell: 'sButton' }, { Cell: 'dButton' }, { Cell: 'fButton' }, { Cell: 'gButton' },
                ],
              },
            },
            {
              HStack: {
                subviews: [
                  { Cell: 'shiftButton' }, { Cell: 'zButton' }, { Cell: 'xButton' }, { Cell: 'cButton' }, { Cell: 'vButton' },
                ],
              },
            },
            {
              HStack: {
                subviews: [
                  { Cell: 'numericButton' }, { Cell: 'commaButton' }, { Cell: 'spaceButton' },
                ],
              },
            },
          ],
        },
      },
      {
        VStack: {
          style: 'columnStyle2',
        },
      },
      {
        VStack: {
          style: 'columnStyle3',
          subviews: [
            {
              HStack: {
                subviews: [
                  { Cell: 'yButton' }, { Cell: 'uButton' }, { Cell: 'iButton' }, { Cell: 'oButton' }, { Cell: 'pButton' },
                ],
              },
            },
            {
              HStack: {
                subviews: [
                  { Cell: 'gButton' }, { Cell: 'hButton' }, { Cell: 'jButton' }, { Cell: 'kButton' }, { Cell: 'lButton' },
                ],
              },
            },
            {
              HStack: {
                subviews: [
                  { Cell: 'vButton' }, { Cell: 'bButton' }, { Cell: 'nButton' }, { Cell: 'mButton' }, { Cell: 'backspaceButton' },
                ],
              },
            },
            {
              HStack: {
                subviews: [
                  { Cell: 'spaceButton' }, { Cell: 'periodButton' }, { Cell: 'enterButton' },
                ],
              },
            },
          ],
        },
      },
    ],
    keyboardStyle: {
      backgroundStyle: 'keyboardBackgroundStyle',
    },
    keyboardBackgroundStyle: {
      buttonStyleType: 'geometry',
      normalColor: color[theme]['键盘背景顏色'],
    },
    columnStyle1: {
      size: {
        width: '2/5',
      },
    },
    columnStyle2: {
      size: {
        width: '1/5',
      },
    },
    columnStyle3: {
      size: {
        width: '2/5',
      },
    },
  },

  // 竖屏按键尺寸（蝦米）- 根據 spaceKeyLayout 設定動態調整
  '竖屏按键尺寸': {
    '普通键size': { width: { percentage: 0.1 } },
    // T鍵和Y鍵在竖屏時與普通鍵相同
    't键size': { width: { percentage: 0.1 } },
    't键bounds': null,
    'y键size': { width: { percentage: 0.1 } },
    'y键bounds': null,
    'a键size': { width: '168.75/1125' },
    'a键bounds': { width: '111/168.75', alignment: 'right' },
    'l键size': { width: '168.75/1125' },
    'l键bounds': { width: '111/168.75', alignment: 'left' },
    'shift键size': { width: { percentage: 0.15 } },
    'shift键bounds': { width: '151/168.75', alignment: 'left' },
    'backspace键size': { width: { percentage: 0.15 } },
    'backspace键bounds': { width: '151/168.75', alignment: 'right' },
    // 蝦米第四排 - 根據 spaceKeyLayout 設定動態調整
    // '1': 空白鍵最小 (40%)  '2': 空白鍵適中 (48%)  '3': 空白鍵最大 (53.16%)
    'numeric键size': { width: { percentage: if settings.spaceKeyLayout == '1' then 0.16 else if settings.spaceKeyLayout == '2' then 0.16 else 0.1342 } },
    'comma键size': { width: { percentage: if settings.spaceKeyLayout == '1' then 0.14 else 0.10 } },
    'space键size': { width: { percentage: if settings.spaceKeyLayout == '1' then 0.40 else if settings.spaceKeyLayout == '2' then 0.48 else 0.5316 } },
    'period键size': { width: { percentage: if settings.spaceKeyLayout == '1' then 0.14 else 0.10 } },
    'enter键size': { width: if settings.spaceKeyLayout == '1' then { percentage: 0.16 } else if settings.spaceKeyLayout == '2' then { percentage: 0.16 } else '168.75/1125' },
    [if settings.spaceKeyLayout == '3' then 'enter键bounds']: { width: '151/168.75', alignment: 'right' },
  },

  // 横屏按键尺寸（完全依照「仿仓默认-元书」）- 根據 spaceKeyLayout 設定動態調整
  '横屏按键尺寸': {
    // 普通字母鍵
    '普通键size': { width: '146/784' },
    // T鍵：使用普通鍵尺寸，但有 bounds 讓按鍵靠左對齊（與「仿仓默认-元书」一致）
    't键size': { width: '146/784' },
    't键bounds': { width: '146/200', alignment: 'left' },
    // Y鍵：右側邊緣鍵，需要 bounds 讓按鍵靠右對齊
    'y键size': { width: '200/784' },
    'y键bounds': { width: '146/200', alignment: 'right' },
    // A鍵：左側邊緣鍵
    'a键size': { width: '200/784' },
    'a键bounds': { width: '146/200', alignment: 'right' },
    // L鍵：右側邊緣鍵
    'l键size': { width: '200/784' },
    'l键bounds': { width: '146/200', alignment: 'left' },
    // Shift鍵：與「仿仓默认-元书」一樣 200/784，無 bounds
    'shift键size': { width: '200/784' },
    'shift键bounds': null,
    // Backspace鍵：與「仿仓默认-元书」一樣 200/784，無 bounds
    'backspace键size': { width: '200/784' },
    'backspace键bounds': null,
    // 蝦米第四排（功能鍵尺寸）- 根據 spaceKeyLayout 設定動態調整
    'numeric键size': { width: '173/784' },
    'comma键size': { width: if settings.spaceKeyLayout == '1' then '173/784' else '146/784' },
    'space键size': { width: if settings.spaceKeyLayout == '1' then '438/784' else '492/784' },
    'period键size': { width: if settings.spaceKeyLayout == '1' then '173/784' else '146/784' },
    'enter键size': { width: '173/784' },
  },
};

{
  getPinyinLayout(theme, orientation):
    if orientation == 'portrait' then keyboardLayout(theme)['竖屏中文26键']
    else keyboardLayout(theme)['横屏中文26键'],

  getEnLayout(theme, orientation):
    if orientation == 'portrait' then keyboardLayout(theme)['竖屏英文26键']
    else keyboardLayout(theme)['横屏英文26键'],

  getButtonSize(theme, orientation):
    if orientation == 'portrait' then keyboardLayout(theme)['竖屏按键尺寸']
    else keyboardLayout(theme)['横屏按键尺寸'],
}
