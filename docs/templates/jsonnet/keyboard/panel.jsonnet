// 面板鍵盤 - 快捷功能面板（參考空山素影）
local animation = import '../lib/animation.libsonnet';
local color = import '../lib/color.libsonnet';
local fontSize = import '../lib/fontSize.libsonnet';
local utils = import '../lib/utils.libsonnet';

// 創建面板按鈕
local createButton(params, theme) = {
  [params.key + 'Button']: {
    size: { height: '1/2' },  // 改為 1/2，因為只有2行
    backgroundStyle: 'panelButtonBackgroundStyle',
    foregroundStyle: [
      params.key + 'ButtonForegroundStyle',
      params.key + 'ButtonForegroundStyle2',
    ],
    action: params.action,
    animation: ['ButtonScaleAnimation'],
  },

  [params.key + 'ButtonForegroundStyle']: utils.makeSystemImageStyle({
    systemImageName: params.systemImageName,
    fontSize: 20,  // 稍微縮小圖標
    normalColor: color[theme]['按键前景颜色'],
    highlightColor: color[theme]['按键前景颜色'],
    center: { x: 0.5, y: 0.35 },
  }),

  [params.key + 'ButtonForegroundStyle2']: utils.makeTextStyle({
    text: params.text,
    fontSize: 11,  // 稍微縮小文字
    normalColor: color[theme]['按键前景颜色'],
    highlightColor: color[theme]['按键前景颜色'],
    center: { x: 0.5, y: 0.72 },
  }),
};

local keyboard(theme, orientation) =
  // 第一行按鈕
  // 元書主程式
  createButton(
    params={
      key: 'Hamster',
      action: 'settings',  // 使用 settings 而不是 openURL
      systemImageName: 'keyboard',
      text: '元書',
    },
    theme=theme
  ) +
  // 按鍵震動
  createButton(
    params={
      key: 'Feedback',
      action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/feedback' },
      systemImageName: 'iphone.radiowaves.left.and.right',
      text: '按鍵震動',
    },
    theme=theme
  ) +
  // 檢查更新
  createButton(
    params={
      key: 'CheckUpdate',
      action: { openURL: 'https://apps.apple.com/cn/app/%E5%85%83%E4%B9%A6%E8%BE%93%E5%85%A5%E6%B3%95/id6744464701' },
      systemImageName: 'arrow.down.circle',
      text: '檢查更新',
    },
    theme=theme
  ) +
  // 檔案管理
  createButton(
    params={
      key: 'Finder',
      action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/finder' },
      systemImageName: 'folder',
      text: '檔案管理',
    },
    theme=theme
  ) +
  // 第二行按鈕
  // 鍵盤皮膚
  createButton(
    params={
      key: 'Skin',
      action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/keyboardSkins' },
      systemImageName: 'tshirt',
      text: '鍵盤皮膚',
    },
    theme=theme
  ) +
  // 無線傳輸
  createButton(
    params={
      key: 'Upload',
      action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/wifi' },
      systemImageName: 'wifi',
      text: '無線傳輸',
    },
    theme=theme
  ) +
  // Rime部署
  createButton(
    params={
      key: 'RimeDeploy',
      action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/rime?action=deploy' },
      systemImageName: 'slider.horizontal.2.arrow.trianglehead.counterclockwise',
      text: 'Rime部署',
    },
    theme=theme
  ) +
  // 內嵌開關
  createButton(
    params={
      key: 'ToggleEmbedded',
      action: { shortcut: '#toggleEmbeddedInputMode' },
      systemImageName: 'square.and.pencil',
      text: '內嵌開關',
    },
    theme=theme
  ) +
  {
    keyboardLayout: [
      {
        HStack: {
          subviews: [
            { Cell: 'HamsterButton' },
            { Cell: 'FeedbackButton' },
            { Cell: 'CheckUpdateButton' },
            { Cell: 'FinderButton' },
          ],
        },
      },
      {
        HStack: {
          subviews: [
            { Cell: 'SkinButton' },
            { Cell: 'UploadButton' },
            { Cell: 'RimeDeployButton' },
            { Cell: 'ToggleEmbeddedButton' },
          ],
        },
      },
    ],
    // 參考空山素影的比例設定，稍微調整避免太擠
    floatTargetScale:
      if orientation == 'portrait' then
        { x: 0.8, y: 0.6 }  // 稍微放大
      else
        { x: 0.45, y: 0.8 },
    keyboardStyle: {
      insets: { top: 10, left: 12, bottom: 10, right: 12 },  // 參考空山素影的設定
      backgroundStyle: 'keyboardBackgroundStyle',
    },
    keyboardBackgroundStyle: {
      buttonStyleType: 'fileImage',
      normalImage: { file: 'float_back', image: 'IMG1' },
      highlightImage: { file: 'float_back', image: 'IMG1' },
    },
    panelButtonBackgroundStyle: {
      buttonStyleType: 'geometry',
      insets: { top: 6, left: 3, bottom: 6, right: 3 },  // 稍微增加上下間距
      normalColor: color[theme]['字母键背景颜色-普通'],
      highlightColor: color[theme]['字母键背景颜色-高亮'],
      cornerRadius: 8.5,  // 使用與其他按鈕一致的圓角
      normalLowerEdgeColor: color[theme]['底边缘顏色-普通'],
      highlightLowerEdgeColor: color[theme]['底边缘顏色-高亮'],
    },
    ButtonScaleAnimation: animation['26键按键动画'],
  };

{
  new(theme, orientation): keyboard(theme, orientation),
}
