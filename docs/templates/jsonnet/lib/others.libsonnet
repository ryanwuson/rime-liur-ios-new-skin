// 其他設定 - 使用原版 Xiami 的高度
local fromVh(s) =
  local num = std.substr(s, 0, std.length(s) - 2);
  std.parseJson(num);

local sumVh(arr) = (
  local sum = std.foldl(
    function(acc, v) acc + fromVh(v),
    arr,
    0
  );
  std.toString(sum) + 'vh'
);

local sumHeights(arr) = (
  if std.length(arr) == 0 then
    null
  else if std.type(arr[0]) == 'string' && std.endsWith(arr[0], 'vh') then
    sumVh(arr)
  else
    std.sum(arr)
);

{
  // 鍵盤高度設定 - 原版 Xiami 的值
  '竖屏': {
    'preedit高度': 25,
    'toolbar高度': 40,
    'keyboard高度': 216,
    '键盘总高度': sumHeights([
      self['preedit高度'],
      self['toolbar高度'],
      self['keyboard高度'],
    ]),
  },
  '横屏': {
    'preedit高度': 14,
    'toolbar高度': 30,
    'keyboard高度': 160,
    '键盘总高度': sumHeights([
      self['preedit高度'],
      self['toolbar高度'],
      self['keyboard高度'],
    ]),
  },
}
