// Z 鍵慣用手動態配置
// 根據 Settings.libsonnet 中的 handedness 設定動態生成 z 鍵長按選項和滑動功能
local settings = import '../Settings.libsonnet';

// 獲取 z 鍵長按選項（根據慣用手設定）
local getZKeyLongPressOptions(keyboardType) = 
  local handedness = std.get(settings, 'handedness', 'left');
  local isLeftHanded = handedness == 'left';
  
  {
    selectedIndex: 0,
    list: [
      { action: { sendKeys: '``Z' }, label: { text: 'Z' } },
      // 根據慣用手設定選擇對應的單手模式
      if isLeftHanded then
        { action: { shortcut: '#左手模式' }, label: { systemImageName: 'keyboard.onehanded.left' } }
      else
        { action: { shortcut: '#右手模式' }, label: { systemImageName: 'keyboard.onehanded.right' } },
      { action: { shortcut: '#行首' }, label: { text: '句首' }, fontSize: 13 },
      { action: { sendKeys: '``z' }, label: { text: 'z' } },
    ],
  };

// 獲取 z 鍵上滑配置（根據慣用手設定）
local getZKeySwipeUpConfig() = 
  local handedness = std.get(settings, 'handedness', 'left');
  local isLeftHanded = handedness == 'left';
  
  if isLeftHanded then
    { action: { shortcut: '#左手模式' }, label: { systemImageName: 'keyboard.onehanded.left' } }
  else
    { action: { shortcut: '#右手模式' }, label: { systemImageName: 'keyboard.onehanded.right' } };

{
  getZKeyLongPressOptions: getZKeyLongPressOptions,
  getZKeySwipeUpConfig: getZKeySwipeUpConfig,
}
